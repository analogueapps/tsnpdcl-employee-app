import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';

class AddGisPointViewModel extends ChangeNotifier {
  final BuildContext context;

  AddGisPointViewModel( {required this.context,  required this.gisIndiData,}) {
    remarksFocusNode = FocusNode();
    _handleLocationIconClick();
    print("gisIndiData: $gisIndiData");
    if(gisIndiData!=[]){
      init();
    }
  }
  final  GisSurveyData gisIndiData;
  // Text controllers
  final TextEditingController gisRegController = TextEditingController();
  final TextEditingController gisIdController = TextEditingController();
  final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  // Dropdown values
  String? voltageLevel;
  String? pointType;

  String? _latitude;
  String? _longitude;

  void init(){
    gisRegController.text="GIS -00${gisIndiData.gisId. toString()}";
    gisIdController.text=gisIndiData.gisId. toString();
    feederController.text=gisIndiData.feederName. toString();
    workDescriptionController.text=gisIndiData.workDescription. toString();

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

  final List<String> pointTypeItems = [
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

  void setPointType(String? newValue) {
    pointType = newValue;
    notifyListeners();
  }

  // Focus request for remarks
  void requestRemarksFocus() {
    remarksFocusNode.requestFocus();
  }

  // Placeholder methods for save and folder actions
  void save() {
    print("Save action triggered");
    // Implement save logic here
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

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permissions are still denied.")),
      );
      return;
    }

    await _getCurrentLocation();
  }


  //capture image
  File? _capturedImage;
  File? get capturedImage => _capturedImage;
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
                ? SnackBarAction(label: 'Settings', onPressed: openAppSettings)
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
      final imageUrl = await _imageUploader.uploadImage(context, File(photo.path));
      if (imageUrl != null) {
        print("Image uploaded successfully: $imageUrl");
      } else {
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
      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
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

////init: /load11KVmaintenanceForm :{"path":"\/load11KVmaintenanceForm","apiVersion":"1.0","method":"POST","data":"{\"authToken\":\"D105ACE3F88684F6F625C1A8B2928107\",\"api\":\"d0bbef01-87c6-4629-9659-d95c59c22a9c\",\"gis\":true,\"gisId\":\"127616\",\"gisReg\":\"GIS-00127616\"}"}
//
//
// // save:
// // images/in.tsnpdcl.npdclemployee/d0bbef01-87c6-4629-9659-d95c59c22a9c/images/IMG_4320AB43C0DB421B.jpeg
// // Build Request:: {"path":"\/submitMaintenance","apiVersion":"1.0","method":"POST","data":"{\"authToken\":\"D105ACE3F88684F6F625C1A8B2928107\",\"api\":\"d0bbef01-87c6-4629-9659-d95c59c22a9c\",\"updateDataJson\":\"{\\\"gisId\\\":\\\"127616\\\",\\\"remarksBySurveyor\\\":\\\"test \\\",\\\"gisReg\\\":\\\"GIS-00127616\\\",\\\"beforeLat\\\":\\\"17.4446106\\\",\\\"pointVoltage\\\":\\\"33KV\\\",\\\"lineType\\\":\\\"LINE TAPPING POINT\\\",\\\"pbeforeLon\\\":\\\"78.3844279\\\",\\\"workDescription\\\":\\\"Test12\\\",\\\"feederNameCodeGis\\\":\\\"0113-05-33KV-F PEDDAPALLY\\\",\\\"beforeImageUrl\\\":\\\"images\\\\\\\/in.tsnpdcl.npdclemployee\\\\\\\/d0bbef01-87c6-4629-9659-d95c59c22a9c\\\\\\\/images\\\\\\\/IMG_4320AB43C0DB421B.jpeg\\\"}\"}"}