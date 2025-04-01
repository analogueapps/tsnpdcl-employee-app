import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MiddlePoles33kvViewModel extends ChangeNotifier {
  final BuildContext context; // Add this field
  MiddlePoles33kvViewModel({required this.context});

  void initialize() {
    // Add initialization logic here, e.g., fetching initial data or setting up listeners
    _handleLocationIconClick(); // Example: Trigger location fetch on init
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

  // Method to set photo path
  void setPoleAPhotoPath(String? path) {
    poleAPhotoPath = path;
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

    // if (!isLocationEnabled) {
    //   // Show a snackbar if the location service is still disabled
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Location services are still disabled."),
    //     ),
    //   );
    //   return;
    // }

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
      // Show a dialog to open app settings
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
        // After opening settings, check again if the permissions are granted
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

    // Fetch current location if permissions are granted
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
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Failed to fetch location."))
      // );
    }
  }
}