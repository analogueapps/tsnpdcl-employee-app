import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';

class OnlineDtrViewmodel extends ChangeNotifier{ // all fields are required
  OnlineDtrViewmodel({required this.context}) {
    init();
    notifyListeners();
  }

  final BuildContext context;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;


  final formKey = GlobalKey<FormState>();
  final TextEditingController sapDTRStructCode= TextEditingController();
  final TextEditingController dtrLocatLandMark= TextEditingController();
  final TextEditingController serialNo= TextEditingController();
  final TextEditingController first_time_charged_date= TextEditingController();
  final TextEditingController sap_dtr= TextEditingController();

  void init() {
    getCurrentLocation();
    sapDTRStructCode.text = "SELECT-SS-0001";
  }

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
  String? _selectedSSNo="01";
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

  List _station = ["ALLIPURAM", "BACHODU", "BEEROLU"];

  List get station => _station;
  void onListStationSelected(String? value) {
    _selectedStation = value;
    notifyListeners();
  }

  //5. IF SUB STATION IS SELECTED LET USER SELECT Choose Feeder
  String? _selectedFeeder;
  String? get selectedFeeder => _selectedFeeder;

  List _feeder = ["SUBLAID", "RAJARAM", "BEEROLU"];
  List get feeder => _feeder;

  void onListFeederSelected(String? value) {
    _selectedFeeder = value;
    notifyListeners();
  }

  //6. Structure Capacity
  String? _selectedCapacity;
  String? get selectedCapacity => _selectedCapacity;

  List _capacity = ["Select", "1x10(L)", "1x10KVA(AGL)", "1X63+2x15KVA"];
  List get capacity => _capacity;

  void onListCapacitySelected(String? value) {
    _selectedCapacity = value;
    print("$_selectedCapacity: selected Capacity ");

    // Reset all DTR Details fields when capacity changes
    _selectedMake = null;
    _selectedDtrCapacity = null;
    _selectedYearOfMfg = null;
    _selectedPhase = null;
    _selectedRatio = null;
    _selectedTypeOfMeter = null;
    first_time_charged_date.text="";
    serialNo.text="";
    notifyListeners();
  }

  //7.DTR Struct Type(*)
  String? _selectedDTRType;
  String? get selectedDTRType => _selectedDTRType;

  List _dTRtype = ["SELECT", "Single Pole", "Double Pole"];
  List get dTRtype => _dTRtype;

  void onListDTRTypeSelected(String? value) {
    _selectedDTRType = value;
    notifyListeners();
  }

  //8.Plint Type(*)
  String? _selectedPlintType;
  String? get selectedPlintType => _selectedPlintType;

  List _plintType= ["Rings", "Pillar Type", "Rock Plint"];
  List get plintType=> _plintType;

  void onListPlintTypeSelected(String? value) {
    _selectedPlintType = value;
    notifyListeners();
  }

  //9. AB Switch
  String? _selectedABSwitch;
  String? get selectedABSwitch => _selectedABSwitch;

  List _aBSwitch = ["Select", "Horizontal", "Vertical", "Not Available"];
  List get aBSwitch => _aBSwitch;

  void onListABSwitchSelected(String? value) {
    _selectedABSwitch = value;
    notifyListeners();
  }

  //10.HG Fuse sets(*)
  String? _selectedHGFuse;
  String? get selectedHGFuse => _selectedHGFuse;

  List _hGFuse = ["Select", "Horizontal", "Vertical", "Not Available"];
  List get hGFuse => _hGFuse;

  void onListHGFuseSelected(String? value) {
    _selectedHGFuse = value;
    notifyListeners();
  }

  //11.LT Fuse Sets(*)
  String? _selectedLTFuseSet;
  String? get selectedLTFuseSet => _selectedLTFuseSet;

  List _lTFuseSet = ["Select", "Available and OK", "Available but Parallel", "Not Available"];
  List get lTFuseSet => _lTFuseSet;

  void onListLTFuseSelected(String? value) {
    _selectedLTFuseSet = value;
    notifyListeners();
  }

  //12.LT Fuse Type(*)
  String? _selectedLTFuseType;
  String? get selectedLTFuseType => _selectedLTFuseType;

  List _lTType = ["Select", "Not Available", "Distribution Box", "LT Fuse Set"];
  List get lTType => _lTType;

  void onListLTFuseTypeSelected(String? value) {
    _selectedLTFuseType = value;
    notifyListeners();
  }

  //Load Pattern
  String? _selectedLoadPattern;
  String? get selectedLoadPattern => _selectedLoadPattern;

  List _loadPattern = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get loadPattern => _loadPattern;

  void onListLoadPatternSelected(String? value) {
    _selectedLoadPattern= value;
    notifyListeners();
  }

  ///DTR Details
  //Make
  String? _selectedMake;
  String? get selectedMake => _selectedMake;

  List _make = ["11KV VCB-AREVA T&D INDIA LTD, NAINI W..", "Idle", "HT Service", "Mixed Load"];
  List get make => _make;

  void onListMake(String? value) {
    _selectedMake= value;
    notifyListeners();
  }

  //Capacity
  String? _selectedDtrCapacity;
  String? get selectedDtrCapacity => _selectedDtrCapacity;

  List _dtrCapacity = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get dtrCapacity => _dtrCapacity;

  void onListDtrCapacity(String? value) {
    _selectedDtrCapacity= value;
    notifyListeners();
  }

  //Year of Mfg
  String? _selectedYearOfMfg;
  String? get selectedYearOfMfg => _selectedYearOfMfg;

  List _yearOfMfg = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get yearOfMfg => _yearOfMfg;

  void onListYearOfMfg(String? value) {
    _selectedYearOfMfg= value;
    notifyListeners();
  }

  //Phase
  String? _selectedPhase;
  String? get selectedPhase => _selectedPhase;

  List _phase = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get phase => _phase;

  void onListPhase(String? value) {
    _selectedPhase= value;
    notifyListeners();
  }

  //ratio
  String? _selectedRatio;
  String? get selectedRatio => _selectedRatio;

  List _ratio = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get ratio => _ratio;

  void onListRatio(String? value) {
    _selectedRatio= value;
    notifyListeners();
  }

  //type of meter
  String? _selectedTypeOfMeter;
  String? get selectedTypeOfMeter => _selectedTypeOfMeter;

  List _typeOfMeter = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get typeOfMeter => _typeOfMeter;

  void onListTypeOfMeter(String? value) {
    _selectedTypeOfMeter= value;
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
    if (_selectedFilter==''||_selectedFilter==null) {
      AlertUtils.showSnackBar(context, "Please select location of DTR", isTrue);
      print("Please select any one filter option");
      return false;
    }
    if (_selectedDistribution==""|| _selectedDistribution==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Distribution",
          isTrue);
      return false;
    } else if (_selectedSSNo==null||_selectedSSNo=="" ) {
      AlertUtils.showSnackBar(
          context, "Please select Distribution",
          isTrue);
      return false;
    }else if (_selectedStation==""|| _selectedStation==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Sub Station",
          isTrue);
      return false;
    }else if (_selectedCircle==""|| _selectedCircle==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Circle",
          isTrue);
      return false;
    }else if (_selectedFeeder==""|| _selectedFeeder==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Feeder",
          isTrue);
      return false;
    }else if (dtrLocatLandMark.text.isEmpty||dtrLocatLandMark.text=="") {
      AlertUtils.showSnackBar(
          context, "Please enter DTR Lank mark",
          isTrue);
      return false;
    }else if (_selectedCapacity==""|| _selectedCapacity==null ) {
      AlertUtils.showSnackBar(
          context, "Please select structure Capacity",
          isTrue);
      return false;
    }else if (_selectedPlintType==""|| _selectedPlintType==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Plinth type",
          isTrue);
      return false;
    }else if (_selectedABSwitch==""|| _selectedABSwitch==null ) {
      AlertUtils.showSnackBar(
          context, "Please select AB switch type",
          isTrue);
      return false;
    }else if (_selectedHGFuse==""|| _selectedHGFuse==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Feeder",
          isTrue);
      return false;
    }else if (_selectedLTFuseSet==""|| _selectedLTFuseSet==null ) {
      AlertUtils.showSnackBar(
          context, "Please select LT Fuse sets",
          isTrue);
      return false;
    }else if (_selectedLTFuseType==""|| _selectedLTFuseType==null ) {
      AlertUtils.showSnackBar(
          context, "Please select LT Fuse type",
          isTrue);
      return false;
    }else if (_selectedLoadPattern==""|| _selectedLoadPattern==null ) {
      AlertUtils.showSnackBar(
          context, "Please select Load Pattern",
          isTrue);
      return false;
    }else if (_latitude==null|| _longitude==null ) {
      getCurrentLocation();
      print(" Final Loaction $_latitude and $_longitude");
      AlertUtils.showSnackBar(
          context, "Please await until we capture  your current location",
          isTrue);
      return false;
    }
    return true;
  }
}