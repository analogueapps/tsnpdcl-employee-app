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
  final TextEditingController sapDTRStructCodeOffline= TextEditingController();
  final TextEditingController dtrLocatLandMarkOffline= TextEditingController();
  final TextEditingController serialNoOffline= TextEditingController();
  final TextEditingController first_time_charged_dateOffline= TextEditingController();
  final TextEditingController sap_dtrOffline= TextEditingController();

  String? _selectedFilterOffline;
  String? get selectedFilter => _selectedFilterOffline;
  void setSelectedFilter(String title) {
    _selectedFilterOffline = title;
    print("$_selectedFilterOffline: filter selected");
    notifyListeners();
  }



  // 1.Distribution
  String? _selectedDistributionOffline;
  String? get selectedDistributionOffline => _selectedDistributionOffline;

  // List<Option> _circles = [];
  List _distributionsOffline = ["RTC", "Nakkalagutta", "Ramnagar"];
  List get distributionsOffline => _distributionsOffline;

  void onListDistriSelectedOffline(String? value) {
    _selectedDistributionOffline = value;
    notifyListeners();
  }

  //2.SS No
  String? _selectedSSNoOffline="01";
  String? get selectedSSNoOffline=> _selectedSSNoOffline;

  List _ssnoOffline= ["01", "02", "03"];
  List get ssnoOffline => _ssnoOffline;

  void onListSSNoSelectedOffline(String? value) {
    _selectedSSNoOffline = value;
    notifyListeners();
  }

  //3.Circle
  String? _selectedCircleOffline;
  String? get selectedCircleOffline => _selectedCircleOffline;

  // List<Option> _circles = [];
  List _circleOffline = ["KHAMMAM", "WARANGAL", "ADILABAD"];
  List get circle => _circleOffline;

  void onListCircleSelectedOffline(String? value) {
    _selectedCircleOffline = value;
    notifyListeners();
  }

  //4.Sub station
  String? _selectedStationOffline;
  String? get selectedStation => _selectedStationOffline;

  List _stationOffline = [];

  List get stationOffline => _stationOffline;
  void onListStationSelectedOffline(String? value) {
    _selectedStationOffline = value;
    notifyListeners();
  }

  //5. IF SUB STATION IS SELECTED LET USER SELECT Choose Feeder
  String? _selectedFeederOffline;
  String? get selectedFeederOffline => _selectedFeederOffline;

  List _feederOffline = [];
  List get feederOffline => _feederOffline;

  void onListFeederSelectedOffline(String? value) {
    _selectedFeederOffline = value;
    notifyListeners();
  }

  //6. Structure Capacity
  String? _selectedCapacityOffline;
  String? get selectedCapacityOffline => _selectedCapacityOffline;

  List _capacityOffline = ["Select", "1x10(L)", "1x10KVA(AGL)", "1X63+2x15KVA"];
  List get capacityOffline => _capacityOffline;

  void onListCapacitySelectedOffline(String? value) {
    _selectedCapacityOffline = value;
    print("$_selectedCapacityOffline: selected Capacity ");

    // Reset all DTR Details fields when capacity changes
    _selectedMakeOffline = null;
    _selectedDtrCapacityOffline = null;
    _selectedYearOfMfgOffline = null;
    _selectedPhaseOffline = null;
    _selectedRatioOffline = null;
    _selectedTypeOfMeterOffline = null;
    first_time_charged_dateOffline.text="";
    serialNoOffline.text="";

    notifyListeners();
  }

  //7.DTR Struct Type(*)
  String? _selectedDTRTypeOffline;
  String? get selectedDTRTypeOffline => _selectedDTRTypeOffline;

  List _dTRtypeOffline = ["SELECT", "Single Pole", "Double Pole"];
  List get dTRtypeOffline => _dTRtypeOffline;

  void onListDTRTypeSelectedOffline(String? value) {
    _selectedDTRTypeOffline = value;
    notifyListeners();
  }

  //8.Plint Type(*)
  String? _selectedPlintTypeOffline;
  String? get selectedPlintTypeOffline => _selectedPlintTypeOffline;

  List _plintTypeOffline= ["Rings", "Pillar Type", "Rock Plint"];
  List get plintTypeOffline=> _plintTypeOffline;

  void onListPlintTypeSelectedOffline(String? value) {
    _selectedPlintTypeOffline = value;
    notifyListeners();
  }

  //9. AB Switch
  String? _selectedABSwitchOffline;
  String? get selectedABSwitchOffline => _selectedABSwitchOffline;

  List _aBSwitchOffline = ["Select", "Horizontal", "Vertical", "Not Available"];
  List get aBSwitchOffline => _aBSwitchOffline;

  void onListABSwitchSelectedOffline(String? value) {
    _selectedABSwitchOffline = value;
    notifyListeners();
  }

  //10.HG Fuse sets(*)
  String? _selectedHGFuseOffline;
  String? get selectedHGFuseOffline => _selectedHGFuseOffline;

  List _hGFuseOffline = ["Select", "Horizontal", "Vertical", "Not Available"];
  List get hGFuseOffline => _hGFuseOffline;

  void onListHGFuseSelectedOffline(String? value) {
    _selectedHGFuseOffline = value;
    notifyListeners();
  }

  //11.LT Fuse Sets(*)
  String? _selectedLTFuseSetOffline;
  String? get selectedLTFuseSetOffline => _selectedLTFuseSetOffline;

  List _lTFuseSetOffline = ["Select", "Available and OK", "Available but Parallel", "Not Available"];
  List get lTFuseSetOffline => _lTFuseSetOffline;

  void onListLTFuseSelectedOffline(String? value) {
    _selectedLTFuseSetOffline = value;
    notifyListeners();
  }

  //12.LT Fuse Type(*)
  String? _selectedLTFuseTypeOffline;
  String? get selectedLTFuseTypeOffline => _selectedLTFuseTypeOffline;

  List _lTTypeOffline = ["Select", "Not Available", "Distribution Box", "LT Fuse Set"];
  List get lTTypeOffline => _lTTypeOffline;

  void onListLTFuseTypeSelectedOffline(String? value) {
    _selectedLTFuseTypeOffline = value;
    notifyListeners();
  }

  //Load Pattern
  String? _selectedLoadPatternOffline;
  String? get selectedLoadPatternOffline => _selectedLoadPatternOffline;

  List _loadPatternOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get loadPatternOffline => _loadPatternOffline;

  void onListLoadPatternSelectedOffline(String? value) {
    _selectedLoadPatternOffline= value;
    notifyListeners();
  }

  ///DTR Details
  //Make
  String? _selectedMakeOffline;
  String? get selectedMakeOffline => _selectedMakeOffline;

  List _makeOffline = ["11KV VCB-AREVA T&D INDIA LTD, NAINI W..", "Idle", "HT Service", "Mixed Load"];
  List get make => _makeOffline;

  void onListMakeOffline(String? value) {
    _selectedMakeOffline= value;
    notifyListeners();
  }

  //Capacity
  String? _selectedDtrCapacityOffline;
  String? get selectedDtrCapacityOffline => _selectedDtrCapacityOffline;

  List _dtrCapacityOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get dtrCapacity => _dtrCapacityOffline;

  void onListDtrCapacityOffline(String? value) {
    _selectedDtrCapacityOffline= value;
    notifyListeners();
  }

  //Year of Mfg
  String? _selectedYearOfMfgOffline;
  String? get selectedYearOfMfgOffline => _selectedYearOfMfgOffline;

  List _yearOfMfgOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get yearOfMfg => _yearOfMfgOffline;

  void onListYearOfMfgOffline(String? value) {
    _selectedYearOfMfgOffline= value;
    notifyListeners();
  }

  //Phase
  String? _selectedPhaseOffline;
  String? get selectedPhaseOffline => _selectedPhaseOffline;

  List _phaseOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get phase => _phaseOffline;

  void onListPhaseOffline(String? value) {
    _selectedPhaseOffline= value;
    notifyListeners();
  }

  //ratio
  String? _selectedRatioOffline;
  String? get selectedRatioOffline => _selectedRatioOffline;

  List _ratioOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get ratio => _ratioOffline;

  void onListRatioOffline(String? value) {
    _selectedRatioOffline= value;
    notifyListeners();
  }

  //type of meter
  String? _selectedTypeOfMeterOffline;
  String? get selectedTypeOfMeterOffline => _selectedTypeOfMeterOffline;

  List _typeOfMeterOffline = ["Select", "Idle", "HT Service", "Mixed Load"];
  List get typeOfMeter => _typeOfMeterOffline;

  void onListTypeOfMeterOffline(String? value) {
    _selectedTypeOfMeterOffline= value;
    notifyListeners();
  }

  ///for sub station
  String? _subStationSelectedOffline;
  String? get subStationSelectedOffline => _subStationSelectedOffline;
  void setSelectedSubStationOffline(String title) {
    _subStationSelectedOffline = title;
    print("$_subStationSelectedOffline: _subStationselected");
    notifyListeners();
  }


  ///Loaction of DTR -> SPM and Store
  ///physical location of DTR
  String? physical_loctaion;
    String? get selectedPhysicalLocation => physical_loctaion;

  List<String> _physical_location_SPM = ["01", "02", "03"];
  List<String> _physical_locationOTHER = ["A", "B", "C"];

  List<String> get listPhysicalLocation {
    return selectedFilter == "SPM" ? _physical_location_SPM : _physical_locationOTHER;
  }

    void onListPhysicalLocation(String? value) {
      physical_loctaion = value;
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