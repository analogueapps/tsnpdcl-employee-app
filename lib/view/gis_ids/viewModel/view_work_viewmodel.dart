import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class WorkDetailsViewModel extends ChangeNotifier {
  WorkDetailsViewModel({required this.context}){
    getCurrentLocation();
  }

  final BuildContext context;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AlertUtils.showSnackBar(context, "Location permission denied", isTrue);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AlertUtils.showSnackBar(
            context, "Location permissions are permanently denied", isTrue);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      isLocationGranted = true;

      print("Geo Current location: $_latitude , $_longitude");

      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
      AlertUtils.showSnackBar(context, "Error fetching location", isTrue);
    }
  }


  // Static data
  final List<Map<String, String>> data = [
    {'label': 'Work Description', 'value': 'After Work T230102010101003 Alternate supply @ Captain'},
    {'label': 'Status', 'value': 'PENDING'},
    {'label': 'Substation Code', 'value': ''},
    {'label': '11kV Feeder Name', 'value': '0007-09-11kV ADVOCATESCOLONY'},
    {'label': 'DTR SS No', 'value': ''},
    {'label': 'Pole Type', 'value': 'LOOSE LINE STRINGING'},
    {'label': 'Sanction No.', 'value': '-'},
    {'label': 'Now Proposed Latitude', 'value': '18.0054961'},
  ];


  // Action handlers
  void close(BuildContext context) {
    Navigator.pop(context);
  }

  void openFolder() {
    print("Folder action triggered");
    // Implement folder logic here
  }

  void edit() {
    print("Edit action triggered");
    // Implement edit logic here
  }
}