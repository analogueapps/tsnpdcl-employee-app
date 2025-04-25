import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/create_online_card_model.dart';

class OfflineDtrViewmodel extends ChangeNotifier{
  OfflineDtrViewmodel({required this.context}) {
    init();
    notifyListeners();
  }

  final BuildContext context;
  bool isLocationGranted = false;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String? _latitude;
  String? _longitude;

  void init() {
    getCurrentLocation();
    getDistributions();

    _ssnoOffline = List.generate(
      999,
          (index) => (index + 1).toString().padLeft(3, '0'),
    );
    sapDTRStructCodeOffline.text = "SELECT-SS-0001";
    getMake();

  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController sapDTRStructCodeOffline= TextEditingController();
  final TextEditingController dtrLocatLandMarkOffline= TextEditingController();
  final TextEditingController serialNoOffline= TextEditingController();
  final TextEditingController first_time_charged_dateOffline= TextEditingController();
  final TextEditingController sap_dtrOffline= TextEditingController();

  List<DtrCardData> dtrCardData = [];

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

  List<SubstationModel> _distributionsOffline = [];
  List<SubstationModel> get distributionsOffline => _distributionsOffline;

  Future<void> getDistributions() async {
    _stationOffline.clear();
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

      _distributionsOffline.addAll(dataList);
      print("Successfully loaded ${_distributionsOffline.length} stations");
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

  void onListDistriSelectedOffline(String? value, String? distriName) {
    _selectedDistributionOffline = value;
    sapDTRStructCodeOffline.text = "$distriName-SS-0001";
    print("sapDTRStructCode $sapDTRStructCodeOffline");
    notifyListeners();
  }

  //2.SS No
  String? _selectedSSNoOffline="001";
  String? get selectedSSNoOffline=> _selectedSSNoOffline;

  List _ssnoOffline= [];
  List get ssnoOffline => _ssnoOffline;

  void onListSSNoSelectedOffline(String? value) {
    _selectedSSNoOffline = value;
    notifyListeners();
  }

  //3.Circle
  String? _selectedCircleOffline='000';
  String? get selectedCircleOffline => _selectedCircleOffline;

  // List<Option> _circles = [];
  final List<Circle> _circleOffline = [
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
    Circle("416", "MANCHERIAL"),];
  List<Circle> get circleOffline => _circleOffline;

  void onListCircleSelectedOffline(String? value) {
    _selectedCircleOffline = value;
    _selectedStationOffline = null;
    _selectedFeederOffline = null;
    getSubstations();
    notifyListeners();
  }

  //4.Sub station
  String? _selectedStationOffline;
  String? get selectedStation => _selectedStationOffline;

  List<SubstationModel> _stationOffline = [];

  List<SubstationModel> get stationOffline => _stationOffline;

  Future<void> getSubstations() async {
    _stationOffline.clear();
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "circleCode": _selectedCircleOffline
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

      _stationOffline.addAll(dataList);
      print("Successfully loaded ${_stationOffline.length} stations");
    } catch (e, stackTrace) {
      print("Error fetching stations: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load stations: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void onListStationSelectedOffline(String? value) {
    _selectedStationOffline = value;
    _selectedFeederOffline=null;
    getFeeders();
    notifyListeners();
  }

  //5. IF SUB STATION IS SELECTED LET USER SELECT Choose Feeder
  String? _selectedFeederOffline;
  String? get selectedFeederOffline => _selectedFeederOffline;

  List<SubstationModel> _feederOffline = [];
  List<SubstationModel> get feederOffline => _feederOffline;

  Future<void> getFeeders() async {
    if (_isLoading) return;

    _isLoading = true;
    _feederOffline.clear();
    _selectedFeederOffline = null;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? "",
        "api": Apis.API_KEY,
        "ss": _selectedStationOffline ?? "",
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

      _feederOffline = dataList.toSet().toList(); // Deduplicate based on optionCode
      print(
          "Feeder option codes: ${_feederOffline.map((f) => f.optionCode).toList()}");
      if (_feederOffline.isNotEmpty) {
        _selectedFeederOffline = _feederOffline.first.optionCode; // Default to first feeder
      }
      print("Successfully loaded ${_feederOffline.length} feeders");
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void onListFeederSelectedOffline(String? value) {
    _selectedFeederOffline = value;
    notifyListeners();
  }

  //6. Structure Capacity
  String? _selectedCapacityOffline;
  String? get selectedCapacityOffline => _selectedCapacityOffline;

  final List<SubstationModel> _capacityOffline = [SubstationModel(optionCode: "0", optionName: "SELECT"),
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
  List<SubstationModel> get capacityOffline => _capacityOffline;

  int? _selectedCapacityIndex;

  int? get selectedCapacityIndex => _selectedCapacityIndex;

  void onListCapacitySelectedOffline(int? index) {
    _selectedCapacityIndex = index;
    _selectedCapacityOffline = index != null ? _capacityOffline[index].optionCode : null;
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

  List _plintTypeOffline= ["Select",
    "Mounting Arrangements",
    "Rings",
    "Rock Plinth",
    "Pillar Type"];
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

  List _loadPatternOffline = [ "Select",
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
    "Substation DTR "];
  List get loadPatternOffline => _loadPatternOffline;

  void onListLoadPatternSelectedOffline(String? value) {
    _selectedLoadPatternOffline= value;
    notifyListeners();
  }

  ///DTR Details
  //Make
  String? _selectedMakeOffline;
  String? get selectedMakeOffline => _selectedMakeOffline;

  List _makeOffline = [];
  List get make => _makeOffline;

  Future<void> getMake() async {
    if (_isLoading) return;

    _isLoading = true;
    _makeOffline.clear();
    _selectedMakeOffline = null;
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
      _makeOffline = dataList.toSet().toList();
      print("Make option codes: ${_makeOffline.map((f) => f.optionCode).toList()}");

      if (_makeOffline.isNotEmpty) {
        _selectedMakeOffline = _makeOffline.first.optionCode; // Default to first item
      }
      print("Successfully loaded ${_makeOffline.length} makes");
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

  void onListMakeOffline(String? value) {
    _selectedMakeOffline= value;
    notifyListeners();
  }

  //Capacity
  String? _selectedDtrCapacityOffline;
  String? get selectedDtrCapacityOffline => _selectedDtrCapacityOffline;

  List _dtrCapacityOffline = ["Select",
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
  List get dtrCapacity => _dtrCapacityOffline;

  void onListDtrCapacityOffline(String? value) {
    _selectedDtrCapacityOffline= value;
    notifyListeners();
  }

  //Year of Mfg
  String? _selectedYearOfMfgOffline;
  String? get selectedYearOfMfgOffline => _selectedYearOfMfgOffline;

  List _yearOfMfgOffline = [];
  List get yearOfMfg => _yearOfMfgOffline;

  void generateYearOfMfgList() {
    _yearOfMfgOffline = List.generate(
      DateTime.now().year - 1952 + 1,
          (index) => (1952 + index).toString(),
    );
    notifyListeners();
  }

  void onListYearOfMfgOffline(String? value) {
    _selectedYearOfMfgOffline= value;
    notifyListeners();
  }

  //Phase
  String? _selectedPhaseOffline;
  String? get selectedPhaseOffline => _selectedPhaseOffline;

  List _phaseOffline = ["Select","Single Phase","3-Phase"];
  List get phase => _phaseOffline;

  void onListPhaseOffline(String? value) {
    _selectedPhaseOffline= value;
    notifyListeners();
  }

  //ratio
  String? _selectedRatioOffline;
  String? get selectedRatioOffline => _selectedRatioOffline;

  List _ratioOffline = ["Select","6.6KV/240V","11KV/440V"];
  List get ratio => _ratioOffline;

  void onListRatioOffline(String? value) {
    _selectedRatioOffline= value;
    notifyListeners();
  }

  //type of meter
  String? _selectedTypeOfMeterOffline;
  String? get selectedTypeOfMeterOffline => _selectedTypeOfMeterOffline;

  List _typeOfMeterOffline = ["Select","Not Available","1Ph Meter","3Ph Meter","CT Meter","HT Meter"];
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

  //Image
  File? _capturedImage;
  File? get capturedImage => _capturedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> capturePhoto() async {
    // Request camera permission
    final status = await Permission.camera.request();

    if (status.isDenied) {
      if (context.mounted) {
        showErrorDialog(context, "Camera permission denied");
      }
      return;
    }

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Camera permission permanently denied. Please enable it in settings.'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () async {
                await openAppSettings(); // Open app settings
              },
            ),
          ),
        );
      }
      return;
    }

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (photo != null) {
        _capturedImage = File(photo.path);
        notifyListeners(); // Notify UI to update
      }
    } catch (e) {
      print('Error capturing photo: $e');
      if (context.mounted) {
        showErrorDialog(context, "Error capturing photo");
      }
    }
  }


  ///Loaction of DTR -> SPM and Store
  ///physical location of DTR
  String? _physicalLocation; // Fixed typo
  String? get selectedPhysicalLocation => _physicalLocation;

  final List<String> _physicalLocationOther = [
    "SELECT",
    "KHAMMAM-STORE",
    "WARANGAL-STORE",
    "KARIMNAGAR STORE",
    "NIZAMABAD-STORE",
    "ADILABAD-STORE",
    "MANCHERIAL-STORE"
  ];

  final List<String> _physicalLocationSPM = [
    "SELECT",
    "AE/SPM/Khammam",
    "AE/SPM/Tallada",
    "AE/SPM/Kothagudem",
    "AE/SPM/Bhadrachalam",
    "AE/SPM/Hanamkonda",
    "AE/SPM/Warangal",
    "AE/SPM &TRE/Bhupalpally",
    "AE/SPM/Mulugu",
    "AE/CTM <M/WGL Rural",
    "AE/LTM &CTM/Mahabubabad",
    "AE/SPM &TRE/WGL Rural",
    "AE/SPM/Mahabubabad",
    "AE/SPM/Thorrur",
    "AE/SPM/Jangaon",
    "AE/SPM/Ghanpur",
    "AE/SPM/Karimnagar",
    "AE/SPM/Huzurabad",
    "AE/SPM/Jagtial",
    "AE/SPM/Metpally",
    "AE/SPM/Pedpapally",
    "AE/SPM/Manthani",
    "AE/SPM/Nizamabad",
    "AE/SPM/Armoor",
    "AE/SPM/Kamareddy",
    "AE/SPM/Banswada",
    "AE/SPM/Nirmal",
    "AE/SPM/Bhainsa",
    "AE/SPM/Mancherial",
    "AE/SPM &TRE/Asifabad",
    "AE/SPM/Adilabad"
  ];

  List<String> get listPhysicalLocation {
    return _selectedFilterOffline == "SPM" ? _physicalLocationSPM : _physicalLocationOther;
  }


  void onListPhysicalLocation(String? value) {
    _physicalLocation = value;
    notifyListeners();
  }

    // void onListPhysicalLocation(String? value) {
    //   physical_loctaion = value;
    //   notifyListeners();
    // }

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

}



//private String[] storesArray = new String[]{"SELECT","KHAMMAM-STORE","WARANGAL-STORE", "KARIMNAGAR STORE","NIZAMABAD-STORE","ADILABAD-STORE","MANCHERIAL-STORE"};
//     private String[] spmArray = new String[]{
//             "SELECT",
//             "AE/SPM/Khammam",
//             "AE/SPM/Tallada",
//             "AE/SPM/Kothagudem",
//             "AE/SPM/Bhadrachalam",
//             "AE/SPM/Hanamkonda",
//             "AE/SPM/Warangal",
//             "AE/SPM &TRE/Bhupalpally",
//             "AE/SPM/Mulugu",
//             "AE/CTM &LTM/WGL Rural",
//             "AE/LTM &CTM/Mahabubabad",
//             "AE/SPM &TRE/WGL Rural",
//             "AE/SPM/Mahabubabad",
//             "AE/SPM/Thorrur",
//             "AE/SPM/Jangaon",
//             "AE/SPM/Ghanpur",
//             "AE/SPM/Karimnagar",
//             "AE/SPM/Huzurabad",
//             "AE/SPM/Jagtial",
//             "AE/SPM/Metpally",
//             "AE/SPM/Pedpapally",
//             "AE/SPM/Manthani",
//             "AE/SPM/Nizamabad",
//             "AE/SPM/Armoor",
//             "AE/SPM/Kamareddy",
//             "AE/SPM/Banswada",
//             "AE/SPM/Nirmal",
//             "AE/SPM/Bhainsa",
//             "AE/SPM/Mancherial",
//             "AE/SPM &TRE/Asifabad",
//             "AE/SPM/Adilabad"
//     };