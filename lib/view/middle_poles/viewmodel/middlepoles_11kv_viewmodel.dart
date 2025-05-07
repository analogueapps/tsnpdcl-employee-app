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
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/calLatLog_model.dart';

class Middlepoles11kvViewmodel extends ChangeNotifier {
  final BuildContext context;
  Middlepoles11kvViewmodel({required this.context});

  void initialize() {
    _handleLocationIconClick();
    getFeeders();
  }

  // Text controllers for all text fields
  final formKey = GlobalKey<FormState>();
  final Map<String, String> paramsHashMap = {};
  // final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();
  final TextEditingController sanctionNoController = TextEditingController();
  final TextEditingController poleBLongitudeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController latPoleA11kv = TextEditingController();
  final TextEditingController logPoleA11kv = TextEditingController();
  final TextEditingController latPoleB11kv = TextEditingController();
  final TextEditingController logPoleB11kv = TextEditingController();

  String? _latitude;
  String? _longitude;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _disposed = true;
    workDescriptionController.dispose();
    sanctionNoController.dispose();
    poleBLongitudeController.dispose();
    distanceController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  // Photo-related state
  String _poleAPhoto11KV="";
  String get poleAPhoto11KV => _poleAPhoto11KV;
  final ImageUploader _poleA11ImageUploader = ImageUploader();

  final ImagePicker _poleA11Picker = ImagePicker();

  Future<void> capturePoleA11Photo() async {
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
      final XFile? photo = await _poleA11Picker.pickImage(
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
      final imageUrl = await _poleA11ImageUploader.uploadImage(context, File(photo.path));
      print("middle poles 33kv: $imageUrl");

      if (imageUrl != null) {
        _poleAPhoto11KV=imageUrl;
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

  //Pole B 11KV
  String _poleB11PhotoPath="";
  String get poleB11PhotoPath => _poleB11PhotoPath;
  final ImageUploader _poleB11ImageUploader = ImageUploader();

  final ImagePicker _poleB11Picker = ImagePicker();

  Future<void> capturePoleB11Photo() async {
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
      final XFile? photo = await _poleB11Picker.pickImage(
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
      final imageUrl = await _poleB11ImageUploader.uploadImage(context, File(photo.path));
      print("middle poles b 33kv: $imageUrl");

      if (imageUrl != null) {
        _poleB11PhotoPath=imageUrl;
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

  // Pole Type state
  String? _selectedPoleType = "SELECT"; // Default value
  String? get selectedPoleType => _selectedPoleType;

  // Method to set pole type
  void setPoleType(String? value) {
    _selectedPoleType = value;
    notifyListeners();
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
      safeNotifyListeners();
    } catch (e) {
      print("Error fetching location: $e");

    }
  }
  bool _disposed = false;
  void safeNotifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List<SubstationModel> _feeder = [];
  List<SubstationModel> get feeder => _feeder;


  void onListFeederSelected(String? value) {
    if (value != null && _feeder.any((item) => item.optionCode == value)) {
      _selectedFeeder = value;
      notifyListeners();
    }
  }
  Future<void> getFeeders() async {
    _isLoading = true;
    _feeder.clear();
    _selectedFeeder = null;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
        "sdc": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.subDivisionPrefKey) ?? "",
      };

      final payload = {
        "path": "/load11KVFeeders",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
      _isLoading = false;

      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue||responseData['tokenValid'] == isFalse) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<SubstationModel> dataList = [];

                  if (jsonList is String) {
                    final parsedList = jsonDecode(jsonList) as List;
                    dataList = parsedList.map((json) => SubstationModel.fromJson(json)).toList();

                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => SubstationModel.fromJson(json)).toList();
                  }

                  _feeder.clear();
                  _feeder.addAll(dataList);
                  if (_feeder.isNotEmpty) {
                    _selectedFeeder = _feeder.first.optionCode;
                  }
                      notifyListeners();
                  print("feeder data in 11KV: ${_feeder.length} items loaded here");
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse pending and finished data. Please contact support.");
                }
              } else {
                _feeder = []; // Clear list if no data
                notifyListeners();
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Request failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, responseData['message'] ??
              "Request failed with status ${response.statusCode}");
        }
      } else {
        showAlertDialog(context, "No response received from server");
      }
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void capturePoleLocation(String poleId, double lat, double lon) {
    print("capturePoleLocation started");
    // Simulating captured location
    paramsHashMap["${poleId}Lat"] = lat.toString();
    paramsHashMap["${poleId}Lon"] = lon.toString();

    // Optionally fill text fields
    if (poleId == "poleA") {
      latPoleA11kv.text = lat.toString();
      logPoleA11kv.text = lon.toString();
      print("capturePoleLocation  pole A");
      notifyListeners();
    } else {
      latPoleB11kv.text = lat.toString();
      logPoleB11kv.text = lon.toString();
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
    // if (selectedFeeder==null||selectedFeeder=="") {
    //   AlertUtils.showSnackBar(
    //       context, "Please enter 33KV FEEDER",
    //       isTrue);
    //   return false;
    // }
    if (selectedPoleType==null||selectedPoleType=="") {
    AlertUtils.showSnackBar(
    context, "Please enter pole type",
    isTrue);
    return false;
    }else if (workDescriptionController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please enter Work Description ",
          isTrue);
      return false;
    }else if (sanctionNoController.text==null||sanctionNoController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please enter sanction no",
          isTrue);
      return false;
    }
    else if (poleAPhoto11KV==null||poleAPhoto11KV=="") {
      AlertUtils.showSnackBar(
          context, "Please capture pole A details photo ",
          isTrue);
      return false;
    } else if (poleB11PhotoPath==null||poleB11PhotoPath=="") {
      AlertUtils.showSnackBar(
          context, "Please capture pole B details photo ",
          isTrue);
      return false;
    }else if ((latPoleA11kv.text==''||logPoleA11kv.text==null)&&(latPoleA11kv.text==''||logPoleA11kv.text==null)) {
      AlertUtils.showSnackBar(context, "Please wait until we capture your location, make sure you turn on your location", isTrue);
      return false;
    }else if ((latPoleB11kv.text==''||logPoleB11kv.text==null)&&(logPoleB11kv.text==''||logPoleB11kv.text==null)) {
      AlertUtils.showSnackBar(context, "Please wait until we capture your location, make sure you turn on your location", isTrue);
      return false;
    }
    else if (distanceController.text==null||distanceController.text=="") {
      AlertUtils.showSnackBar(
          context, "Please wait until we calculate distance ",
          isTrue);
      return false;
    }
    return true;
  }

  Map<String, dynamic>   getUpdateData( ) {
    return {
      "poleBLat":latPoleB11kv.text,
      "poleBLon":logPoleB11kv.text,
      "poleBImageUrl":poleB11PhotoPath,
      "poleALon":logPoleA11kv.text,
      "poleALat":latPoleA11kv.text,
      "poleAImageUrl":poleAPhoto11KV,
      "remarksBySurveyor":remarksController.text,
      "workDescription":workDescriptionController.text,
      "feederCode11kv":selectedFeeder=="00"?"":selectedFeeder,//feederName11kv
      "poleType":selectedPoleType,
      "sanctionNo":sanctionNoController.text,
      "distance":distanceController.text,
      //sectionnn: NAKKALAGUTTA
      // I/flutter (25728): subdivisionCode: 402911001

    };
  }

  Future<void> updateForm() async {
    print("feederName11kv:${selectedFeeder=="00"?"":selectedFeeder}");
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
        if(responseData!=null){
          Navigator.pop(context);
        }
        // if (responseData is String) {
        //   try {
        //     responseData = jsonDecode(responseData);
        //   } catch (e) {
        //     print("Error decoding response data: $e");
        //     showErrorDialog(
        //         context, "Invalid response format. Please try again.");
        //     return;
        //   }
        // }

        // if (response.statusCode == successResponseCode) {
        //   if (responseData['tokenValid'] == true) {
        //     if (responseData['success'] == true) {
        //       if (responseData['message'] != null) {
        //         AlertUtils.showSnackBar(context,responseData['message'] , isFalse);
        //         Navigator.pop(context);
        //       }
        //     } else {
        //       showAlertDialog(
        //           context, responseData['message'] ?? "Operation failed");
        //     }
        //   } else {
        //     showSessionExpiredDialog(context);
        //   }
        // } else {
        //   showErrorDialog(context,
        //       "Request failed with status: ${response.statusCode}");
        // }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

}