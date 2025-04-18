import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AddGisPointViewModel extends ChangeNotifier {
  final BuildContext context;

  AddGisPointViewModel( {required this.context}) {
    remarksFocusNode = FocusNode();
    _handleLocationIconClick();
  }
  // Text controllers
  final TextEditingController gisRegController = TextEditingController(text: "GIS-00121036");
  final TextEditingController gisIdController = TextEditingController(text: "121036");
  final TextEditingController feederController = TextEditingController(text: "007-09-11KV ADVOCATESCOLONY");
  final TextEditingController workDescriptionController = TextEditingController(text: "After Work T230102010101003 Alternate supply @ Caption");
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  // Dropdown values
  String? voltageLevel;
  String? pointType;

  String? _latitude;
  String? _longitude;

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