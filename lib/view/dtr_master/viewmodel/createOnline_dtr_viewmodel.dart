import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class OnlineDtrViewmodel extends ChangeNotifier{
  OnlineDtrViewmodel({required this.context}) {
    getCurrentLocation();
  }

  final BuildContext context;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;


  final formKey = GlobalKey<FormState>();
  final TextEditingController equipNoORStructCode = TextEditingController();

  String? _selectedFilter;
  String? get selectedFilter => _selectedFilter;
  void setSelectedFilter(String title) {
    _selectedFilter = title;
    print("$_selectedFilter: filter selected");
    notifyListeners();
  }

  // 1.Distribution
  String? _selectedDistribution;
  String? get selectedDistribution => _selectedDistribution;

  // List<Option> _circles = [];
  List _distributions = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get distributions => _distributions;

  void onListDistriSelected(String? value) {
    _selectedDistribution = value;
    notifyListeners();
  }

  //2.SS No
  String? _selectedSSNo;
  String? get selectedSSNo=> _selectedSSNo;

  List _ssno= ["01", "02", "03"];
  List get ssno => _ssno;

  void onListSSNoSelected(String? value) {
    _selectedSSNo = value;
    notifyListeners();
  }

  //3.Circle
  String? _selectedCircle;
  String? get selectedCircle => _selectedCircle;

  // List<Option> _circles = [];
  List _circle = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get circle => _circle;

  void onListCircleSelected(String? value) {
    _selectedCircle = value;
    notifyListeners();
  }

  //4.Sub station
  String? _selectedStation;
  String? get selectedStation => _selectedStation;

  List _station = ["KHA", "ANGALp", "ADILA"];

  List get station => _station;
  void onListStationSelected(String? value) {
    _selectedStation = value;
    notifyListeners();
  }

  //5.Choose Feeder
  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List _feeder = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get feeder => _feeder;

  void onListFeederSelected(String? value) {
    _selectedFeeder = value;
    notifyListeners();
  }

  //6. Structure Capacity
  String? _selectedCapacity;
  String? get selectedCapacity => _selectedCapacity;

  List _capacity = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get capacity => _capacity;

  void onListCapacitySelected(String? value) {
    _selectedCapacity = value;
    notifyListeners();
  }

  //7.DTR Struct Type(*)
  String? _selectedDTRType;
  String? get selectedDTRType => _selectedDTRType;

  List _dTRtype = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get dTRtype => _dTRtype;

  void onListDTRTypeSelected(String? value) {
    _selectedDTRType = value;
    notifyListeners();
  }

  //8.Plint Type(*)
  String? _selectedPlintType;
  String? get selectedPlintType => _selectedPlintType;

  List _plintType= ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get plintType=> _plintType;

  void onListPlintTypeSelected(String? value) {
    _selectedPlintType = value;
    notifyListeners();
  }

  //9. AB Switch
  String? _selectedABSwitch;
  String? get selectedABSwitch => _selectedABSwitch;

  List _aBSwitch = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get aBSwitch => _aBSwitch;

  void onListABSwitchSelected(String? value) {
    _selectedABSwitch = value;
    notifyListeners();
  }

  //10.HG Fuse sets(*)
  String? _selectedHGFuse;
  String? get selectedHGFuse => _selectedHGFuse;

  List _hGFuse = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get hGFuse => _hGFuse;

  void onListHGFuseSelected(String? value) {
    _selectedHGFuse = value;
    notifyListeners();
  }

  //11.LT Fuse Sets(*)
  String? _selectedLTFuseSet;
  String? get selectedLTFuseSet => _selectedLTFuseSet;

  List _lTFuseSet = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get lTFuseSet => _lTFuseSet;

  void onListLTFuseSelected(String? value) {
    _selectedLTFuseSet = value;
    notifyListeners();
  }

  //12.LT Fuse Type(*)
  String? _selectedLTFuseType;
  String? get selectedLTFuseType => _selectedLTFuseType;

  List _lTType = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get lTType => _lTType;

  void onListLTFuseTypeSelected(String? value) {
    _selectedCircle = value;
    notifyListeners();
  }

  //Load Pattern
  String? _selectedLoadPattern;
  String? get selectedLoadPattern => _selectedLoadPattern;

  List _loadPattern = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get loadPattern => _loadPattern;

  void onListLoadPatternSelected(String? value) {
    _selectedLoadPattern= value;
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

}