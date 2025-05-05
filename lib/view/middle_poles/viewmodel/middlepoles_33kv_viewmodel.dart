import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
import 'package:tsnpdcl_employee/view/gis_ids/model/calLatLog_model.dart';

class MiddlePoles33kvViewModel extends ChangeNotifier {
  final BuildContext context; // Add this field
  MiddlePoles33kvViewModel({required this.context});

  void initialize() {
    _handleLocationIconClick();
  }

  // Text controllers for all text fields
  final formKey = GlobalKey<FormState>();
  final Map<String, String> paramsHashMap = {};
  final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();
  final TextEditingController sanctionNoController = TextEditingController();
  final TextEditingController poleBLongitudeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController latPoleA = TextEditingController();
  final TextEditingController logPoleA = TextEditingController();
  final TextEditingController latPoleB = TextEditingController();
  final TextEditingController logPoleB = TextEditingController();

  String? _latitude;
  String? _longitude;


  //pole A Image Upload
  String _poleAPhotoPath="";
  String get poleAPhotoPath => _poleAPhotoPath;
  final ImageUploader _poleAImageUploader = ImageUploader();

  final ImagePicker _poleAPicker = ImagePicker();

  Future<void> capturePoleAPhoto() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status.isPermanentlyDenied
                ? 'Camera permission permanently denied. Enable in settings.'
                : 'Camera permission denied'),
            action: status.isPermanentlyDenied
                ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
                : null,
          ),
        );
      }
      return;
    }

    try {
      final XFile? photo = await _poleAPicker.pickImage(
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
      ProcessDialogHelper.showProcessDialog(context, message: "Uploading image...");
      notifyListeners();
      final imageUrl = await _poleAImageUploader.uploadImage(context, File(photo.path));
      print("middle poles 33kv: $imageUrl");

      if (imageUrl != null) {
        _poleAPhotoPath=imageUrl;
        await _getCurrentLocation();
        print("Pole A Lat: $_latitude, Pole B Lon: $_longitude");
        if (_latitude != null && _longitude != null) {
          _handleLocationIconClick();
          // latPoleA.text = _latitude!;
          // logPoleA.text = _longitude!;

          print("calculating distance pole A");
          final double lat = double.tryParse(_latitude!) ?? 0.0;
          final double lon = double.tryParse(_longitude!) ?? 0.0;
          capturePoleLocation("poleA",lat,lon );
        }
        notifyListeners();
        print("Image uploaded successfully: $imageUrl");
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
      } else {
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
        showErrorDialog(context, "Image upload failed");
      }
    } catch (e) {
      if (context.mounted) showErrorDialog(context, "Error capturing photo");
    }
  }

  //Pole B Image Upload
  String _poleBPhotoPath="";
  String get poleBPhotoPath => _poleBPhotoPath;
  final ImageUploader _poleBImageUploader = ImageUploader();

  final ImagePicker _poleBPicker = ImagePicker();

  Future<void> capturePoleBPhoto() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status.isPermanentlyDenied
                ? 'Camera permission permanently denied. Enable in settings.'
                : 'Camera permission denied'),
            action: status.isPermanentlyDenied
                ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
                : null,
          ),
        );
      }
      return;
    }

    try {
      final XFile? photo = await _poleBPicker.pickImage(
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
      ProcessDialogHelper.showProcessDialog(context, message: "Uploading image...");
      notifyListeners();
      final imageUrl = await _poleBImageUploader.uploadImage(context, File(photo.path));
      print("middle poles b 33kv: $imageUrl");

      if (imageUrl != null) {
        _poleBPhotoPath=imageUrl;
        if((_longitude!=null&&_longitude!=null)||(_longitude==null&&_longitude==null)) {
          _handleLocationIconClick();
          print("calculating distance pole B");
          final double lat = double.tryParse(_latitude!) ?? 0.0;
          final double lon = double.tryParse(_longitude!) ?? 0.0;
          capturePoleLocation("poleB",lat, lon );
        }
        notifyListeners();
        print("Image uploaded successfully: $imageUrl");
        await _getCurrentLocation();
        // handleCalculateDistance();
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
      } else {
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
        showErrorDialog(context, "Image upload failed");
      }
    } catch (e) {
      if (context.mounted) showErrorDialog(context, "Error capturing photo");
    }
  }


  @override
  void dispose() {
    feederController.dispose();
    workDescriptionController.dispose();
    sanctionNoController.dispose();
    poleBLongitudeController.dispose();
    distanceController.dispose();
   remarksController.dispose();
    super.dispose();
  }


  void _handleLocationIconClick() async {

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      // Show a dialog to enable location services
      bool? shouldOpenSettings = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Location Service Disabled"),
              content: const Text("Please enable location services to use this feature."),
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
        // After opening settings, check again if the location service is enabled
        isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      }
    }
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location permissions are denied."),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Location Permission Required"),
            content: Text("Location permissions are permanently denied. Please enable them in the app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Open Settings"),
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

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location permissions are still denied."),
        ),
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

  //Calculate distance between to lat poleA,log poleA, lat poleB, log poleB

  void capturePoleLocation(String poleId, double lat, double lon) {
    print("capturePoleLocation started");
    // Simulating captured location
      paramsHashMap["${poleId}Lat"] = lat.toString();
      paramsHashMap["${poleId}Lon"] = lon.toString();

      // Optionally fill text fields
      if (poleId == "poleA") {
        latPoleA.text = lat.toString();
        logPoleA.text = lon.toString();
        print("capturePoleLocation  pole A");
        notifyListeners();
      } else {
        latPoleB.text = lat.toString();
        logPoleB.text = lon.toString();
        print("capturePoleLocation pole B");
        notifyListeners();
      }

      // If both poles are captured, calculate the distance
      if (paramsHashMap.containsKey("poleALat") && paramsHashMap.containsKey("poleBLat")) {
        LatLng poleA = LatLng(
          double.parse(paramsHashMap["poleALat"]!),
          double.parse(paramsHashMap["poleALon"]!),
        );
        LatLng poleB = LatLng(
          double.parse(paramsHashMap["poleBLat"]!),
          double.parse(paramsHashMap["poleBLon"]!),
        );
        String dist = calculateDistance(poleA, poleB);
        paramsHashMap["distance"] = dist;
        distanceController.text = dist;
        notifyListeners();
      }
    print("capturePoleLocation ended");
  }

  String calculateDistance(LatLng from, LatLng to) {
    return distance(from.latitude, from.longitude, to.latitude, to.longitude);
  }

  String distance(double lat1, double lon1, double lat2, double lon2) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515; // miles
    double distanceInMeters = dist * 1000 * 1.609344;  // convert to meters
    return NumberFormat("0.00").format(distanceInMeters); // two decimal places
  }

  double deg2rad(double deg) {
    return deg * pi / 180.0;
  }

  double rad2deg(double rad) {
    return rad * 180.0 / pi;
  }

  //updateForm
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }else{
        updateForm();
        print("in else block");
      }
    }
  }
  bool validateForm() {
    if (feederController.text==null||feederController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please enter 33KV FEEDER",
          isTrue);
      return false;
    }
    if (poleAPhotoPath==null||poleAPhotoPath=="") {
      AlertUtils.showSnackBar(
          context, "Please capture pole A details photo ",
          isTrue);
      return false;
    } else if (poleBPhotoPath==null||poleBPhotoPath=="") {
      AlertUtils.showSnackBar(
          context, "Please capture pole B details photo ",
          isTrue);
      return false;
    }else if ((latPoleA.text==''||logPoleA.text==null)&&(latPoleA.text==''||logPoleA.text==null)) {
      AlertUtils.showSnackBar(context, "Please wait until we capture your location, make sure you turn on your location", isTrue);
      return false;
    }else if ((latPoleB.text==''||logPoleB.text==null)&&(latPoleB.text==''||logPoleB.text==null)) {
      AlertUtils.showSnackBar(context, "Please wait until we capture your location, make sure you turn on your location", isTrue);
      return false;
    }else if (sanctionNoController.text==null||sanctionNoController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please select voltage level",
          isTrue);
      return false;
    }
    else if (distanceController.text==null||distanceController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please wait until we calculate Distance ",
          isTrue);
      return false;
    } else if (workDescriptionController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please enter Work Description ",
          isTrue);
      return false;
    }
    return true;
  }

  Map<String, dynamic>   getUpdateData( ) {
    return {
      "poleBLat":latPoleB.text,
      "poleBLon":logPoleB.text,
      "poleBImageUrl":poleBPhotoPath,
      "poleALon":logPoleA.text,
      "poleALat":latPoleA.text,
      "poleAImageUrl":poleAPhotoPath,
      "remarksBySurveyor":remarksController.text,
      "workDescription":workDescriptionController.text,
      "feederName":feederController.text,
      "sanctionNo":sanctionNoController.text,
      "distance":distanceController.text,

    };
  }

  Future<void> updateForm() async {
    print("${jsonEncode(getUpdateData())}:JsoonEncode data");


    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "updateDataJson":jsonEncode(getUpdateData()),
    };

    final payload = {
      "path": "/submitMiddlePole",
      "apiVersion": "1.0",
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
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              if (responseData['message'] != null) {
                AlertUtils.showSnackBar(context,responseData['message'] , isFalse);
                Navigator.pop(context);
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Operation failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showErrorDialog(context,
              "Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

}