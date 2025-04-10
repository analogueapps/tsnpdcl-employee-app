import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PendingListFloatingButtonViewmodel extends ChangeNotifier {
  final BuildContext context;
  PendingListFloatingButtonViewmodel({required this.context});

  void initialize() {
    _handleLocationIconClick();
  }

  // Text controllers for all text fields
  final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();
  final TextEditingController sanctionNoController = TextEditingController();
  final TextEditingController poleBLongitudeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController villagesAffectedController = TextEditingController();

  String? _latitude;
  String? _longitude;

  // Photo-related state
  String? poleAPhotoPath;
  String? poleBPhotoPath;

  // Pole Type state
  String? _selectedPoleType = "SELECT"; // Default value
  String? get selectedPoleType => _selectedPoleType;

  // Method to set pole type
  void setPoleType(String? value) {
    _selectedPoleType = value;
    notifyListeners();
  }

  // Method to set photo path
  void setPoleAPhotoPath(String? path) {
    poleAPhotoPath = path;
    notifyListeners();
  }

  void setPoleBPhotoPath(String? path) {
    poleBPhotoPath = path;
    notifyListeners();
  }

  // Cleanup
  @override
  void dispose() {
    feederController.dispose();
    workDescriptionController.dispose();
    sanctionNoController.dispose();
    poleBLongitudeController.dispose();
    distanceController.dispose();
    villagesAffectedController.dispose();
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
}