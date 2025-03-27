import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class DownloadFeederViewmodel extends ChangeNotifier {
  DownloadFeederViewmodel({required this.context}) {
    getCurrentLocation();
  }

  final BuildContext context;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;

  final formKey = GlobalKey<FormState>();
  String? _selectedSubStation;
  String? get selectedSubStation => _selectedSubStation;

  List _subStation = ["KHA", "ANGALp", "ADILA"];

  List get station => _subStation;
  void onListSubStationSelected(String? value) {
    _selectedSubStation = value;
    notifyListeners();
  }

//3.feeder
  String? _chooseFeeder;
  String? get chooseFeeder => _chooseFeeder;

  List _feeder = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get feeder => _feeder;

  void onListFeederSelected(String? value) {
    _chooseFeeder = value;
    notifyListeners();
  }



  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (position != null) {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
        isLocationGranted = true;
        print("Geo Last known location: $_latitude , $_longitude");
      } else {
        // If no last known location, fetch current location
        Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        _latitude = currentPosition.latitude.toString();
        _longitude = currentPosition.longitude.toString();
        print("Geo Current location: $_latitude , $_longitude");
      }
    } catch (e) {
      print("Error fetching location: $e");
      AlertUtils.showSnackBar(context, "Error fetching location", isTrue);
    }
    notifyListeners(); // Notify listeners that the location has been updated
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      }
    }
  }
  bool validateForm() {
    if (_selectedSubStation==''||_selectedSubStation==null) {
      AlertUtils.showSnackBar(context, "Please select 33/11 KV SS", isTrue);
      print("Please select any one filter option");
      return false;
    }
    if (_chooseFeeder==" " && _chooseFeeder==null ) { //not displaying error msg
      AlertUtils.showSnackBar(
          context, "Please choose Feeder",
          isTrue);
      return false;
    }
    return true;
  }
}
