import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:vendor_app/services/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/create_online_card_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/online_submit_model.dart';
import 'package:tsnpdcl_employee/view/dtr_master/viewmodel/image_upload.dart';

class OnlineDtrViewmodel extends ChangeNotifier {
  OnlineDtrViewmodel({required this.context}) {
    init();
    notifyListeners();
    print("Designation Code: ${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.designationCodeKey)}");
  }

  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  bool isLocationGranted = false;

  double MINIMUM_GPS_ACCURACY_REQUIRED = 15.0;
  StreamSubscription<Position>? _positionStream;
  double? latitude;
  double? longitude;
  double? totalAccuracy;

  final ImageUploader _imageUploader = ImageUploader();
  final formKey = GlobalKey<FormState>();
  final TextEditingController sapDTRStructCode = TextEditingController();
  final TextEditingController dtrLocatLandMark = TextEditingController();
  // final TextEditingController serialNo = TextEditingController();
  // final TextEditingController first_time_charged_date = TextEditingController();
  // final TextEditingController sap_dtr = TextEditingController();

  List<DtrCardData> dtrCardData = [];

  void init() {
    fetchCurrentLocation();
    getDistributions();

    _ssno = List.generate(
      999,
          (index) => (index + 1).toString().padLeft(3, '0'),
    );
    sapDTRStructCode.text = "SELECT-SS-0001";
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
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
  List<SubstationModel> _distributions = [];
  List<SubstationModel> get distributions => _distributions;
  Future<void> getDistributions() async {
    _stations.clear();
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/load/distributions",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      // Validate response
      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      // Process station data
      if (responseData['objectJson'] == null) {
        throw Exception("No _distributions data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList
            .replaceAll(r'\"', '"')
            .trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }
      else if (jsonList is List) {
        dataList = jsonList
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }

      _distributions.addAll(dataList);
      print("Successfully loaded ${_distributions.length} stations");
    } catch (e, stackTrace) {
      print("Error fetching _distributions: $e\n$stackTrace");
      showErrorDialog(
          context, "Failed to load _distributions: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void onListDistriSelected(String? value, String? distriName) {
    _selectedDistribution = value;
    sapDTRStructCode.text = "$distriName-SS-0001";
    print("sapDTRStructCode $sapDTRStructCode");
    notifyListeners();
  }

  //2.SS No
  String? _selectedSSNo = "001";
  String? get selectedSSNo => _selectedSSNo;
  List _ssno = [];
  List get ssno => _ssno;
  void onListSSNoSelected(String? value) {
    _selectedSSNo = value;
    notifyListeners();
  }


  //3.Circle
  String? _selectedCircle = '000';
  String? get selectedCircle => _selectedCircle;
  final List<Circle> _circle = [
    Circle("000", "SELECT"),
    Circle("401", "KHAMMAM"),
    Circle("402", "HANAMKONDA"),
    Circle("407", "WARANGAL"),
    Circle("403", "KARIMNAGAR"),
    Circle("405", "ADILABAD"),
    Circle("404", "NIZAMABAD"),
    Circle("406", "BHADRADRI KOTHAGUDEM"),
    Circle("408", "JANGAON"),
    Circle("409", "BHOOPALAPALLY"),
    Circle("410", "MAHABUBABAD"),
    Circle("411", "JAGITYAL"),
    Circle("412", "PEDDAPALLY"),
    Circle("413", "KAMAREDDY"),
    Circle("414", "NIRMAL"),
    Circle("415", "ASIFABAD"),
    Circle("416", "MANCHERIAL"),
  ];

  List<Circle> get circle => _circle;

  void onListCircleSelected(String? value) {
    _selectedCircle = value ?? '000';
    _selectedStation = null;
    _selectedFeeder = null;
    getSubstations();
    print("_selectedCircle: $_selectedCircle");
    notifyListeners();
  }

  //4.Sub station
  String? _selectedStation;

  String? get selectedStation => _selectedStation;

  List<SubstationModel> _stations = [];

  List<SubstationModel> get stations => _stations;

  void onStationSelected(String? value) {
    _selectedStation = value;
    _selectedFeeder = null;
    getFeeders();
    print("_selectedStation: $_selectedStation");
    notifyListeners();
  }

  Future<void> getSubstations() async {
    _stations.clear();
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "circleCode": _selectedCircle
      };

      final payload = {
        "path": "/load/load33kvssOfCircle",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      // Validate response
      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      // Process station data
      if (responseData['objectJson'] == null) {
        throw Exception("No station data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList
            .replaceAll(r'\"', '"')
            .trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }
      else if (jsonList is List) {
        dataList = jsonList
            .map((json) => SubstationModel.fromJson(json))
            .toList();
      }

      _stations.addAll(dataList);
      print("Successfully loaded ${_stations.length} stations");
    } catch (e, stackTrace) {
      print("Error fetching stations: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load stations: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //5. IF SUB STATION IS SELECTED LET USER SELECT Choose Feeder
  String? _selectedFeeder;

  String? get selectedFeeder => _selectedFeeder;

  List<SubstationModel> _feeder = [];

  List<SubstationModel> get feeder => _feeder;


  void onListFeederSelected(String? value) {
    if (value != null && _feeder.any((item) => item.optionCode == value)) {
      _selectedFeeder = value;
      notifyListeners();
    }
  }

  Future<void> getFeeders() async {
    if (_isLoading) return;

    _isLoading = true;
    _feeder.clear();
    _selectedFeeder = null;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
        "ss": _selectedStation ?? "",
      };

      final payload = {
        "path": "/load/feeders",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      if (responseData['objectJson'] == null) {
        throw Exception("No feeder data received");
      }

      final jsonList = responseData['objectJson'];
      List<SubstationModel> dataList = [];

      if (jsonList is String) {
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }
        dataList = (jsonDecode(cleanedJson) as List<dynamic>)
            .map((json) =>
            SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (jsonList is List) {
        dataList = (jsonList as List<dynamic>)
            .map((json) =>
            SubstationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      _feeder = dataList.toSet().toList(); // Deduplicate based on optionCode
      print(
          "Feeder option codes: ${_feeder.map((f) => f.optionCode).toList()}");
      if (_feeder.isNotEmpty) {
        _selectedFeeder = _feeder.first.optionCode; // Default to first feeder
      }
      print("Successfully loaded ${_feeder.length} feeders");
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //6. Structure Capacity
  String? _selectedCapacity;

  String? get selectedCapacity => _selectedCapacity;

  final List<SubstationModel> _capacity = [
    SubstationModel(optionCode: "0", optionName: "SELECT"),
    SubstationModel(optionCode: "1", optionName: "1x10(L)"),
    SubstationModel(optionCode: "1", optionName: "1x10KVA(AGL)"),
    SubstationModel(optionCode: "3", optionName: "1x63+2x15KVA"),
    SubstationModel(optionCode: "1", optionName: "1x100"),
    SubstationModel(optionCode: "1", optionName: "1x75"),
    SubstationModel(optionCode: "1", optionName: "1x50"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x15(L)"),
    SubstationModel(optionCode: "2", optionName: "1x100+1x160"),
    SubstationModel(optionCode: "1", optionName: "1x15 (Agl)"),
    SubstationModel(optionCode: "1", optionName: "1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x16"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x160"),
    SubstationModel(optionCode: "1", optionName: "1x200"),
    SubstationModel(optionCode: "1", optionName: "1x25"),
    SubstationModel(optionCode: "1", optionName: "1x40"),
    SubstationModel(optionCode: "1", optionName: "1x25L"),
    SubstationModel(optionCode: "2", optionName: "1x25+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x250"),
    SubstationModel(optionCode: "1", optionName: "1x300"),
    SubstationModel(optionCode: "1", optionName: "1x315"),
    SubstationModel(optionCode: "1", optionName: "1x400"),
    SubstationModel(optionCode: "1", optionName: "1x500"),
    SubstationModel(optionCode: "1", optionName: "1x63"),
    SubstationModel(optionCode: "2", optionName: "1x63+1x15(L)"),
    SubstationModel(optionCode: "1", optionName: "1x630"),
    SubstationModel(optionCode: "1", optionName: "1x650"),
    SubstationModel(optionCode: "1", optionName: "1x750"),
    SubstationModel(optionCode: "1", optionName: "1x800"),
    SubstationModel(optionCode: "1", optionName: "1x1000"),
    SubstationModel(optionCode: "1", optionName: "1x1600"),
    SubstationModel(optionCode: "1", optionName: "1x2000"),
    SubstationModel(optionCode: "1", optionName: "1x2500"),
    SubstationModel(optionCode: "2", optionName: "2x100"),
    SubstationModel(optionCode: "2", optionName: "2x150"),
    SubstationModel(optionCode: "2", optionName: "2x16"),
    SubstationModel(optionCode: "2", optionName: "2x25"),
    SubstationModel(optionCode: "2", optionName: "2x15"),
    SubstationModel(optionCode: "2", optionName: "2x250"),
    SubstationModel(optionCode: "2", optionName: "2x63"),
    SubstationModel(optionCode: "3", optionName: "3x10(A)"),
    SubstationModel(optionCode: "3", optionName: "3x16"),
    SubstationModel(optionCode: "3", optionName: "3x25"),
    SubstationModel(optionCode: "3", optionName: "3x15"),
    SubstationModel(optionCode: "2", optionName: "1x16+1x63"),
  ];

  List<SubstationModel> get capacity => _capacity;

  int? _selectedCapacityIndex;

  int? get selectedCapacityIndex => _selectedCapacityIndex;

  void onListCapacitySelected(int? index) {
    _selectedCapacityIndex = index;
    _selectedCapacity = index != null ? _capacity[index].optionCode : null;
    generateYearOfMfgList();
    print("$_selectedCapacity: selected Capacity ");

    final capacityCount = int.tryParse(_selectedCapacity ?? "0") ?? 0;
    if (dtrCardData.length != capacityCount) {
      // Dispose old controllers
      for (var data in dtrCardData) {
        data.dispose();
      }
      dtrCardData.clear();
      // Create new DtrCardData instances
      dtrCardData = List.generate(capacityCount, (_) => DtrCardData());
    }

    getMake();
    // _make;
    // _selectedDtrCapacity = null;
    // _selectedYearOfMfg = null;
    // _selectedPhase = null;
    // _selectedRatio = null;
    // _selectedTypeOfMeter = null;
    // first_time_charged_date.text = "";
    // serialNo.text = "";
    // getMake();
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

  List _plintType = [
    "Select",
    "Mounting Arrangements",
    "Rings",
    "Rock Plinth",
    "Pillar Type"
  ];

  List get plintType => _plintType;

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

  List _lTFuseSet = [
    "Select",
    "Available and Ok",
    "Available but Parallel",
    "Not Available"
  ];

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

  List _loadPattern = [
    "Select",
    "Idle",
    "Dedicated PWS",
    "Dedicated LI",
    "Dedicated Industrial",
    "Dedicated Agl Without PWS",
    "HT Service",
    "Appartment",
    "Dedicated Agl with PWS",
    "Mixed Agl With PWS",
    "Mixed Agl without PWS",
    "Mixed Load",
    "Pure Domestic",
    "Pure Non Domestic",
    "Mixed without AGL",
    "Substation DTR "
  ];

  List get loadPattern => _loadPattern;

  void onListLoadPatternSelected(String? value) {
    _selectedLoadPattern = value;
    notifyListeners();
  }

  ///DTR Details
  //Make
  //
  //
  String? _selectedMake;
  String? get selectedMake => _selectedMake;

  List<SubstationModel> _make = [];
  List<SubstationModel> get make => _make;


  Future<void> getMake() async {
  if (_isLoading) return;

  _isLoading = true;
  _make.clear();
  _selectedMake = null;
  notifyListeners();

  try {
  final requestData = {
  "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
  "api": Apis.API_KEY,
  };

  final payload = {
  "path": "/getDtrMakes",
  "apiVersion": "1.0",
  "method": "POST",
  "data": jsonEncode(requestData),
  };

  final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
      .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

  if (response == null) {
  throw Exception("No response received from server");
  }

  dynamic responseData = response.data;
  if (responseData is String) {
  responseData = jsonDecode(responseData);
  }

  if (response.statusCode != 200) { // Use a constant for success code
  throw Exception(responseData['message'] ?? "Request failed with status ${response.statusCode}");
  }

  if (responseData['tokenValid'] != true) {
  showSessionExpiredDialog(context);
  return;
  }

  if (responseData['success'] != true) {
  throw Exception(responseData['message'] ?? "Operation failed");
  }

  final jsonList = responseData['objectJson'];
  if (jsonList == null) {
  throw Exception("No make data received");
  }

  List<SubstationModel> dataList;
  if (jsonList is List) {
  dataList = jsonList
      .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
      .toList();
  } else if (jsonList is String) {
  dataList = (jsonDecode(jsonList) as List<dynamic>)
      .map((json) => SubstationModel.fromJson(json as Map<String, dynamic>))
      .toList();
  } else {
  throw Exception("Invalid objectJson format");
  }

  // Deduplicate based on optionCode
  _make = dataList.toSet().toList();
  print("Make option codes: ${_make.map((f) => f.optionCode).toList()}");

  if (_make.isNotEmpty) {
  _selectedMake = _make.first.optionCode; // Default to first item
  }
  print("Successfully loaded ${_make.length} makes");
  } catch (e, stackTrace) {
  print("Error fetching makes: $e\n$stackTrace");
  if (context.mounted) {
  showErrorDialog(context, "Failed to load makes: ${e.toString()}");
  }
  } finally {
  _isLoading = false;
  notifyListeners();
  }
  }

  void onListMake(String? value, int cardIndex) {
  if (cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].selectedMake = value;
  notifyListeners();
  }
  }



  //Capacity
  String? _selectedDtrCapacity;
  String? get selectedDtrCapacity => _selectedDtrCapacity;

  List _dtrCapacity = ["Select",
    "2500KVA",
    "2000KVA",
    "1600KVA",
    "1000KVA",
    "800KVA",
    "500KVA",
    "400KVA",
    "315KVA",
    "250KVA",
    "200KVA",
    "160KVA",
    "100KVA",
    "75KVA",
    "63KVA",
    "50KVA",
    "40KVA",
    "3.Ph.25KVA",
    "3.Ph.16KVA",
    "S.Ph.25KVA",
    "15KVALTN",
    "15KVAAGL",
    "10KVALTN",
    "10KVAAGL"];
  List get dtrCapacity => _dtrCapacity;

  void onListDtrCapacity(String? value,int cardIndex) {
  if (cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].selectedDtrCapacity = value;
  notifyListeners();
  }
  }

  //Year of Mfg
  String? _selectedYearOfMfg;
  String? get selectedYearOfMfg => _selectedYearOfMfg;

  List _yearOfMfg = [];
  List get yearOfMfg => _yearOfMfg;

  void generateYearOfMfgList() {
    _yearOfMfg = List.generate(
      DateTime.now().year - 1952 + 1,
          (index) => (1952 + index).toString(),
    );
    notifyListeners();
  }

  void onListYearOfMfg(String? value, int cardIndex) {
    if (cardIndex < dtrCardData.length) {
      dtrCardData[cardIndex].selectedYearOfMfg = value;
      notifyListeners();
    }
  }

  //Phase
  String? _selectedPhase;
  String? get selectedPhase => _selectedPhase;

  List _phase = ["Select","Single Phase","3-Phase"];
  List get phase => _phase;

  void onListPhase(String? value, int cardIndex) {
  if (cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].selectedPhase = value;
  notifyListeners();
  }
  }

  //ratio
  String? _selectedRatio;
  String? get selectedRatio => _selectedRatio;

  List _ratio = ["Select","6.6KV/240V","11KV/440V"];
  List get ratio => _ratio;

  void onListRatio(String? value,int cardIndex) {
  if (cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].selectedRatio = value;
  notifyListeners();
  }
  }

  //type of meter
  String? _selectedTypeOfMeter;
  String? get selectedTypeOfMeter => _selectedTypeOfMeter;

  List _typeOfMeter = ["Select","Not Available","1Ph Meter","3Ph Meter","CT Meter","HT Meter"];
  List get typeOfMeter => _typeOfMeter;

  void onListTypeOfMeter(String? value, int cardIndex) {
  if (cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].selectedTypeOfMeter = value;
  notifyListeners();
  }
  }



  //capture image
  File? _capturedImage;
  File? get capturedImage => _capturedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> capturePhoto(int cardIndex) async {
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
  final XFile? photo = await ImagePicker().pickImage(
  source: ImageSource.camera,
  imageQuality: 85,
  maxWidth: 1024,
  maxHeight: 1024,
  );
  if (photo != null && cardIndex < dtrCardData.length) {
  dtrCardData[cardIndex].capturedImage = File(photo.path);
  notifyListeners();
  }


  } catch (e) {
  if (context.mounted) showErrorDialog(context, "Error capturing photo");
  }
  }


  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
      totalAccuracy = position.accuracy;
      print("totalAccuracy: $totalAccuracy");
      _isLoading = false;
      notifyListeners();
    });
  }


  Future<void> requestSerialNo(int cardIndex) async {
    if (_isLoading || cardIndex >= dtrCardData.length) return;
    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
      };

      final payload = {
        "path": "/generateSerialNo",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      if (response.statusCode != successResponseCode) {
        throw Exception(responseData['message'] ??
            "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      if (responseData['message'] == null) {
        throw Exception("No serial number received");
      }
        final serialNumber = responseData['message'] as String?;
        if (serialNumber != null) {
        dtrCardData[cardIndex].serialNo.text = serialNumber;
        }
      print("Successfully generated serial number: $serialNumber");
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateEquipmentNo() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/generateEquipmentNo",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("post2sapGis response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              if (responseData['message'] != null) {
                try {
                  final jsonMessage = responseData['message'];
                  print("jsonMessage: $jsonMessage");
                } catch (e, stackTrace) {
                  print("Error parsing message: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse structure data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Operation failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showErrorDialog(context,
              "Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }


  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> submitForm(
      ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      notifyListeners();

      if (!validateForm()) {
        return;
      } else {
        try {
          // Collect DTR data
          final dtrs = <DTR>[];
          for (var i = 0; i < dtrCardData.length; i++) {
            final card = dtrCardData[i];
            if (card.selectedMake == null ||
                card.selectedDtrCapacity == null ||
                card.selectedYearOfMfg == null ||
                card.selectedPhase == null ||
                card.selectedRatio == null ||
                card.selectedTypeOfMeter == null ||
                card.serialNo.text.isEmpty ||
                card.firstTimeChargedDate.text.isEmpty ||
                card.sapDtr.text.isEmpty ||
                card.capturedImage == null) {
              AlertUtils.showSnackBar(
                  context, "Please complete all DTR details for DTR ${i + 1}",
                  isTrue);
              _isLoading = false;
              notifyListeners();
              return;
            }

            final makeVendorId = _make
                .firstWhere((m) => m.optionCode == card.selectedMake)
                .optionCode;
            dtrs.add(DTR(
              capacity: card.selectedDtrCapacity!,
              make: card.selectedMake!,
              makeVendorId: makeVendorId,
              imageFile: card.capturedImage!,
              phase: card.selectedPhase!,
              meterPhase: card.selectedTypeOfMeter!,
              dtrChargeDate: card.firstTimeChargedDate.text,
              ratio: card.selectedRatio!,
              sapEquipmentNo: card.sapDtr.text,
              serialNo: card.serialNo.text,
              yearOfMfg: card.selectedYearOfMfg!,
            ));
          }

          // Create Structure object
          final structure = Structure(
            replace: "false",
            // Adjust as needed
            structureCode: sapDTRStructCode.text,
            abSwitch: _selectedABSwitch!,
            capacity: _selectedCapacity!,
            landMark: dtrLocatLandMark.text,
            distributionCode: _selectedDistribution!,
            distribution: _distributions
                .firstWhere((d) => d.optionCode == _selectedDistribution)
                .optionName,
            structureType: _selectedDTRType!,
            feederCode: _selectedFeeder!,
            feederName: _feeder
                .firstWhere((f) => f.optionCode == _selectedFeeder)
                .optionName,
            hgFuseSet: _selectedHGFuse!,
            lat: latitude!,
            lon: longitude!,
            loadPattern: _selectedLoadPattern!,
            ltFuseSet: _selectedLTFuseSet!,
            ltFuseType: _selectedLTFuseType!,
            plinthType: _selectedPlintType!,
            ssCode: _selectedStation!,
            ssName: _stations
                .firstWhere((s) => s.optionCode == _selectedStation)
                .optionName,
            ssNo: _selectedSSNo!,
            spmfl: null,
            // Adjust as needed
            dtrs: dtrs,
          );

          // Call createStructure
          final success = await createStructure(context, structure);
          if (success && context.mounted) {
            showSuccessDialog(context, "Structure created successfully", () {
              Navigator.pop(context);
            });
          }
        } catch (e, stackTrace) {
          print("Error submitting form: $e\n$stackTrace");
          if (context.mounted) showErrorDialog(
              context, "Failed to submit form: ${e.toString()}");
        } finally {
          _isLoading = false;
          notifyListeners();
        }
      }
    }
  }

    Future<bool> createStructure(BuildContext context, Structure structure) async {
      _isLoading = true;
      _errorMessage = null;
      if (context.mounted) {
        ProcessDialogHelper.showProcessDialog(context, message: "Uploading images...");
      }
      notifyListeners();

      try {
        // Upload images for each DTR
        final imageUrls = <String>[];
        for (final dtr in structure.dtrs) {
          final imageUrl = await _imageUploader.uploadImage(context, dtr.imageFile);
          if (imageUrl == null) {
            _errorMessage = 'Failed to upload image for DTR';
            if (context.mounted) {
              ProcessDialogHelper.closeDialog(context);
              showAlertDialog(context, _errorMessage!);
            }
            return false;
          }
          imageUrls.add(imageUrl);
        }

        // Update progress dialog
        if (context.mounted) {
          ProcessDialogHelper.showProcessDialog(context, message: "Creating structure...");
        }

        final structureJson = structure.toJson(imageUrls);
        final requestData = {
          "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
          "dtrData": jsonEncode(structureJson),
        };


        final payload = {
          "path": "/saveDTRStructure",
          "apiVersion": "1.0",
          "method": "POST",
          "data": requestData,
        };

        final response = await ApiProvider(baseUrl: Apis.CHECK_ROOT_URL)
            .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }

        if (response == null) {
          throw Exception("No response received from server");
        }

        dynamic responseData = response.data;
        if (responseData is String) responseData = jsonDecode(responseData);

        if (response.statusCode == 200) {
          if (responseData['taskSuccess'] == true) {
            return true;
          } else {
            throw Exception(responseData['message'] ?? "Structure creation failed");
          }
        } else {
          throw Exception(responseData['message'] ?? "Request failed with status ${response.statusCode}");
        }
      } catch (e, stackTrace) {
        print("Error creating structure: $e\n$stackTrace");
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
          showAlertDialog(context, "Failed to create structure: ${e.toString()}");
        }
        return false;
      } finally {
        _isLoading = false;
        notifyListeners();
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
    }else if (latitude==null|| longitude==null ) {
      fetchCurrentLocation();
      print(" Final Loaction $latitude and $longitude");
      AlertUtils.showSnackBar(
          context, "Please await until we capture  your current location",
          isTrue);
      return false;
    }
    return true;
  }
}



