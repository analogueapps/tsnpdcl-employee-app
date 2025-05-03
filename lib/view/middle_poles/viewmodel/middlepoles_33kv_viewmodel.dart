import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
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
  final TextEditingController feederController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();
  final TextEditingController sanctionNoController = TextEditingController();
  final TextEditingController poleBLongitudeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController villagesAffectedController = TextEditingController();
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
        if((_longitude!=null&&_longitude!=null)||(_longitude==null&&_longitude==null)) {
          _handleLocationIconClick();
          latPoleA.text = _latitude!;
          logPoleA.text = _longitude!;
        }
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
          latPoleB.text = _latitude!;
          logPoleB.text = _longitude!;
        }
        notifyListeners();
        print("Image uploaded successfully: $imageUrl");
        // calculateDistance();
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
  //Calculate distance between to lat poleA,log poleA, lat poleB, log poleB
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
    double distanceInMeters = dist * 1609.344; // convert to meters
    return distanceInMeters.toStringAsFixed(2); // two decimal places
  }

  double deg2rad(double deg) {
    return deg * pi / 180.0;
  }

  double rad2deg(double rad) {
    return rad * 180.0 / pi;
  }

}