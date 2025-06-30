import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';

class AddGisPointViewModel extends ChangeNotifier {
  final BuildContext context;

  AddGisPointViewModel(
      {required this.context,
      required this.gisId,
      required this.gisReg,
      required this.gis,
      required this.t}) {
    remarksFocusNode = FocusNode();
    _handleLocationIconClick();
    if (gisId != []) {
      init();
    }
    print("add gisID viewmodel: $gisId, $gisReg, $gis, $t ");
  }

  final int gisId;
  final String gisReg;
  final bool gis;
  final String t;

  final formKey = GlobalKey<FormState>();
  // Text controllers
  final TextEditingController gisRegController = TextEditingController();
  final TextEditingController gisIdController = TextEditingController();
  final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController =
      TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  // Dropdown values
  String? voltageLevel;
  String? lineType;

  String? _latitude;
  String? _longitude;

  void init() {
    gisRegController.text = gisReg;
    gisIdController.text = gisId.toString();
    getLoadMaintenanceForm(gis, gisId, gisReg, t);
  }

  // Focus node
  late FocusNode remarksFocusNode;

  // Dropdown items
  final List<String> voltageItems = [
    'SELECT',
    '33KV',
    '11KV',
    'LT',
  ];

  final List<String> lineTypeItems = [
    '--SELECT--',
    'LINE TRAPPING POINT',
    'LINE TURNING/ANGLE POINT',
    'LINE END POINT',
    'SS CONSTRUCTION',
    'MIDDLE POLE',
    'BROKEN POLE',
    'DAMAGED POLE',
    'RUSTED POLE',
    'RE-CONSTRUCTION',
    'LOOSE LINE STRINGING',
    'THEFT OF CONDUCTOR',
    'THEFT OF DTR',
    'DTR ENHANCEMENT',
    'DTR IMPROVEMENT',
    'DTR DAMAGE DUO TO CYCLONE',
    'DTR FOR NEW SERVICE',
    'SHIFTING OF DTR',
    'PERMISSION OF SERVICE CONNECTION',
    'TREE CUTTING START POINT',
    'TREE CUTTING END POINT',
    'CIVIL WORKS',
    'SECTION OFFICE LOCATION',
    'OTHERS'
  ];

  // Dropdown change handlers
  void setVoltageLevel(String? newValue) {
    voltageLevel = newValue;
    notifyListeners();
  }

  void setlineType(String? newValue) {
    lineType = newValue;
    notifyListeners();
  }

  // Focus request for remarks
  void requestRemarksFocus() {
    remarksFocusNode.requestFocus();
  }

  void openFolder() {
    print("Folder action triggered");
    // Implement folder logic here
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
  }

  Future<void> getLoadMaintenanceForm(
      bool gis, int gisId, String gisReg, String t) async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading available data...",
        );
      }
    });

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "gis": gis,
      "gisId": gisId.toInt() ?? 0,
      "gisReg": gisReg
    };

    final payload = {
      "path":
          t == "11KV" ? "/load11KVmaintenanceForm" : "/load33KVmaintenanceForm",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList =
                    jsonDecode(response.data['objectJson']);
                print("/load11KVmaintenanceForm data: $jsonList");
                final firstItem = jsonList[0];
                feederController.text = firstItem['feederCode11kv'] ?? '';
                workDescriptionController.text =
                    firstItem['workDescription'] ?? "";
                notifyListeners();
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }
    }

    notifyListeners();
  }

  //capture image
  String _capturedImage = "";
  String get capturedImage => _capturedImage;
  final ImageUploader _imageUploader = ImageUploader();

  final ImagePicker _picker = ImagePicker();

  Future<void> capturePhoto() async {
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
      final XFile? photo = await _picker.pickImage(
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
          await _imageUploader.uploadImage(context, File(photo.path));
      print("add gis $imageUrl");
      if (imageUrl != null) {
        _capturedImage = imageUrl;
        notifyListeners();
        print("Image uploaded successfully: $imageUrl");
        await _getCurrentLocation();
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

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      latitudeController.text = _latitude!;
      longitudeController.text = _longitude!;
      notifyListeners();
      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else {
        submitData();
        print("in else block");
      }
    }
  }

  bool validateForm() {
    if (_capturedImage == "") {
      AlertUtils.showSnackBar(context, "Please capture the image", isTrue);
      return false;
    }
    if ((_latitude == '' || _latitude == null) &&
        (_longitude == '' || _longitude == null)) {
      AlertUtils.showSnackBar(
          context, "Please wait until we capture your location", isTrue);
      return false;
    } else if (voltageLevel == null) {
      AlertUtils.showSnackBar(context, "Please select voltage level", isTrue);
      return false;
    } else if (lineType == null) {
      AlertUtils.showSnackBar(context, "Please select point type ", isTrue);
      return false;
    } else if (gisRegController.text == "") {
      AlertUtils.showSnackBar(context, "Please enter GIS REG ", isTrue);
      return false;
    } else if (gisIdController.text == "") {
      AlertUtils.showSnackBar(context, "Please enter GIS ID ", isTrue);
      return false;
    } else if (workDescriptionController.text == "") {
      AlertUtils.showSnackBar(
          context, "Please enter Work Description ", isTrue);
      return false;
    } else if (feederController.text == "") {
      AlertUtils.showSnackBar(context, "Please enter 11KV Feeder ", isTrue);
      return false;
    }
    return true;
  }

  Map<String, dynamic> getUpdateData() {
    return {
      "gisId": gisId,
      "remarksBySurveyor": remarksController.text,
      "gisReg": gisReg,
      "beforeLat": _latitude,
      "pointVoltage": voltageLevel,
      "lineType": lineType,
      "pbeforeLon": _longitude,
      "workDescription": workDescriptionController.text,
      "feederNameCodeGis": feederController.text,
      "beforeImageUrl": capturedImage
    };
  }

  Future<void> submitData() async {
    print("${jsonEncode(getUpdateData())}:JsoonEncode data");

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "updateDataJson": jsonEncode(getUpdateData()),
    };

    final payload = {
      "path": "/submitMaintenance",
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
                AlertUtils.showSnackBar(
                    context, responseData['message'], isFalse);
                Navigation.instance.navigateTo(
                  Routes.gisIndividual,
                );
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Operation failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showErrorDialog(
              context, "Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  @override
  void dispose() {
    gisRegController.dispose();
    gisIdController.dispose();
    feederController.dispose();
    workDescriptionController.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    remarksController.dispose();
    remarksFocusNode.dispose();
    super.dispose();
  }
}

//error: type 'Null' is not a subtype of type 'int' in type cast
