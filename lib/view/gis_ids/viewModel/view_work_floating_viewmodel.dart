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
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';

class ViewWorkFloatingViewmodel extends ChangeNotifier {
  final BuildContext context;
  final String surveyID;
  ViewWorkFloatingViewmodel({required this.context, required this.surveyID}) {
    print("surveyID: $surveyID");
  }

  void initialize() {
    _handleLocationIconClick();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  String? _latitude;
  String? _longitude;

  // Cleanup
  @override
  void dispose() {
    latitudeController.dispose();
    longitudeController.dispose();
    remarksController.dispose();
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

  //capture image
  String _viewWorkCapturedImage = "";
  String get viewWorkCapturedImage => _viewWorkCapturedImage;
  final ImageUploader _viewWorkImageUploader = ImageUploader();

  final ImagePicker _viewWorkPicker = ImagePicker();

  Future<void> viewWorkCapturePhoto() async {
    final status = await Permission.camera.request();
    // if (status.isDenied || status.isPermanentlyDenied) {
    //   if (context.mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(status.isPermanentlyDenied
    //             ? 'Camera permission permanently denied. Enable in settings.'
    //             : 'Camera permission denied'),
    //         action: status.isPermanentlyDenied
    //             ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
    //             : null,
    //       ),
    //     );
    //   }
    //   return;
    // }

    try {
      final XFile? photo = await _viewWorkPicker.pickImage(
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
          await _viewWorkImageUploader.uploadImage(context, File(photo.path));
      print("view workfloating $imageUrl");
      if (imageUrl != null) {
        _viewWorkCapturedImage = imageUrl;
        latitudeController.text = _latitude!;
        longitudeController.text = _longitude!;
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
    if (_viewWorkCapturedImage == "") {
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
      "remarksBySurveyor": remarksController.text,
      "afterLat": _latitude,
      "afterLon": _longitude,
      "afterImageUrl": viewWorkCapturedImage,
      "_id": surveyID,
      "api": Apis.API_KEY
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
      "path": "/saveMaintenance",
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

//Build Request:: {"path":"\/saveMaintenance","apiVersion":"1.1","method":"POST","data":"{\"authToken\":\"26973097C0CE4D15A995879E87A81729\",\"updateDataJson\":\"{\\\"remarksBySurveyor\\\":\\\"\\\",\\\"afterLat\\\":\\\"17.444644\\\",\\\"afterLon\\\":\\\"78.3843945\\\",\\\"afterImageUrl\\\":\\\"images\\\\\\\/in.tsnpdcl.npdclemployee\\\\\\\/d0bbef01-87c6-4629-9659-d95c59c22a9c\\\\\\\/images\\\\\\\/IMG_541A38AE551F44CF.jpeg\\\",\\\"_id\\\":525824(survey id)}\",\"api\":\"d0bbef01-87c6-4629-9659-d95c59c22a9c\"}"}
