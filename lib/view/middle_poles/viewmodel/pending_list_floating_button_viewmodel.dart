import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';

class PendingListFloatingButtonViewmodel extends ChangeNotifier {
  final BuildContext context;
  final int surId;
  final String individualStatus;

  PendingListFloatingButtonViewmodel(
      {required this.context,
      required this.surId,
      required this.individualStatus});

  void initialize() {
    _handleLocationIconClick();
    print("surveyid: $surId");
  }

  // Text controllers for all text fields
  final formKey = GlobalKey<FormState>();
  final TextEditingController middlePoleLatController = TextEditingController();
  final TextEditingController middlePoleLanController = TextEditingController();

  String? _latitude;
  String? _longitude;

  // Cleanup
  @override
  void dispose() {
    middlePoleLanController.dispose();
    middlePoleLatController.dispose();
    super.dispose();
  }

  void _handleLocationIconClick() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Location Service Disabled"),
              content: const Text(
                  "Please enable location services to use this feature."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Open Settings"),
                ),
              ],
            ),
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openLocationSettings();
        isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Location Permission Required"),
            content: const Text(
                "Location permissions are permanently denied. Please enable them in the app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open Settings"),
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        await Geolocator.openAppSettings();
        permission = await Geolocator.checkPermission();
      }
    }

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permissions are still denied.")),
      );
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  // Photo-related state
  String _middlePhotoPath = "";
  String get middlePhotoPath => _middlePhotoPath;
  final ImageUploader _middlePoleImageUploader = ImageUploader();

  final ImagePicker _middlePolePicker = ImagePicker();

  Future<void> middlePoleCapturePhoto() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status.isPermanentlyDenied
                ? 'Camera permission permanently denied. Enable in settings.'
                : 'Camera permission denied'),
            action: status.isPermanentlyDenied
                ? const SnackBarAction(
                    label: 'Settings', onPressed: openAppSettings)
                : null,
          ),
        );
      }
      return;
    }

    try {
      final XFile? photo = await _middlePolePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (photo == null) {
        if (context.mounted) {
          showErrorDialog(context, "No photo captured");
        }
        return;
      }

      // Upload photo if captured
      ProcessDialogHelper.showProcessDialog(context,
          message: "Uploading images...");
      notifyListeners();
      final imageUrl =
          await _middlePoleImageUploader.uploadImage(context, File(photo.path));
      print("view workfloating $imageUrl");
      if (imageUrl != null) {
        _middlePhotoPath = imageUrl;
        middlePoleLatController.text = _latitude!;
        middlePoleLanController.text = _longitude!;
        notifyListeners();
        notifyListeners();
        print("Image uploaded successfully: $imageUrl");
        await _getCurrentLocation();
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
      } else {
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
          // showAlertDialog(context, _errorMessage!);
        }
        showErrorDialog(context, "Image upload failed");
      }
    } catch (e) {
      if (context.mounted) showErrorDialog(context, "Error capturing photo");
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();
      _getCurrentLocation();
      if (!validateForm()) {
        return;
      } else {
        submitData();
        print("in else block");
      }
    }
  }

  bool validateForm() {
    if (_middlePhotoPath == "") {
      AlertUtils.showSnackBar(context, "Please capture the image", isTrue);
      return false;
    }
    if ((_latitude == '' || _latitude == null) &&
        (_longitude == '' || _longitude == null)) {
      AlertUtils.showSnackBar(
          context, "Please wait until we capture your location", isTrue);
      return false;
    }
    return true;
  }

  Map<String, dynamic> viewWorkData() {
    return {
      "middlePoleLat": middlePoleLatController.text,
      "middlePoleLon": middlePoleLanController.text,
      "middlePoleImageUrl": middlePhotoPath,
      "_id": surId,
    };
  }

  Future<void> submitData() async {
    print("${jsonEncode(viewWorkData())}:JsoonEncode data");

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "updateDataJson": jsonEncode(viewWorkData()),
    };

    final payload = {
      "path": "/saveMiddlePole",
      "apiVersion": "1.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      print("load structure response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
            if (responseData['tokenValid'] == true) {
              if (responseData['success'] == true) {
                if (responseData['message'] != null) {
                  showSuccessDialog(context, responseData['message'], () {
                    Navigator.pop(context);
                  });
                }
              } else {
                showAlertDialog(
                    context, responseData['message'] ?? "Operation failed");
              }
            } else {
              showSessionExpiredDialog(context);
            }
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }
}
