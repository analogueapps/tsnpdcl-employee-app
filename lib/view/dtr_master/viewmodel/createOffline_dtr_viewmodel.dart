import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class OfflineDtrViewmodel extends ChangeNotifier{
  OfflineDtrViewmodel({required this.context}) {
    init();
    notifyListeners();
  }

  final BuildContext context;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;

  void init() {
    getCurrentLocation();
  }

  final formKey = GlobalKey<FormState>();

///for SPM, store, structure
  String? _selectedFilter;
  String? get selectedFilter => _selectedFilter;
  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    notifyListeners();
  }

  ///for sub station
  String? _subStationSelected;
  String? get subStationSelected => _subStationSelected;
  void setSelectedSubStation(String title) {
    _subStationSelected = title;
    print("$_subStationSelected: _subStationselected");
    notifyListeners();
  }

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

}