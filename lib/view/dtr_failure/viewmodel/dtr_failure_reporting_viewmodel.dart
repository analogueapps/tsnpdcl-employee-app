import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dropdown_option.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dtr_structure_entity.dart';

class ReportDTRFailureViewModel extends ChangeNotifier {
  ReportDTRFailureViewModel( {required this.context}) {
    _fetchStructures();
  }
  final sectionCode =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final section =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionPrefKey);
  final BuildContext context;
  List<DropdownOption> _structures = [];
  List<Map<String, String>> _structureDetails = [];
  DateTime? selectedDateTime;
  Map<String, dynamic>? _currentStructure;
  bool _isLoading = false;
  bool _isLoadingStructures = false;
  bool _isLoadingStructureDetails = false;
  String? _selectedStructureId;

  List<DropdownOption> get structures => _structures;
  List<Map<String, String>> get structureDetails => _structureDetails;
  Map<String, dynamic>? get currentStructure => _currentStructure;
  bool get isLoading => _isLoading;
  bool get isLoadingStructures => _isLoadingStructures;
  bool get isLoadingStructureDetails => _isLoadingStructureDetails;
  String? get selectedStructureId => _selectedStructureId;

  //equipment code :
  final List<String> failedEquipmentList = ["00000"];
  String? get failedEquipmentCode => _failedEquipmentCode;
  void setFailedEquipmentCode(String? value) {
    _failedEquipmentCode = value;
    notifyListeners();
  }


  // Dropdown selections
  String? _selectedLocation;
  String? _failedEquipmentCode;
  String? _selectedStructureCode;

  final List<String> _structureDetailLabels = [
    'STRUCTURE CODE',
    'LANDMARK',
    'DISTRIBUTION',
    'SS NO',
    'SUB STATION',
    'FEEDER',
    'STRUCTURE CAPACITY',
    'STRUCTURE TYPE',
    'PLINTH TYPE',
    'AB SWITCH TYPE',
    'HG FUSE SETS',
    'LT FUSE SETS',
    'LT FUSE TYPE',
    'LOAD PATTERN',
    'LATITUDE',
    'LONGITUDE',
    'DATE OF CREATION',
    'EMPLOYEE ID',
  ];

  Future<void> _fetchStructures() async {
    if (_isLoadingStructures) return; // Prevent duplicate calls
    _isLoadingStructures = true;
    notifyListeners();
    failedEquipmentList.clear();

    try {
      final requestData = {
        "authToken":
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "sectionCode": sectionCode,
      };

      final payload = {
        "path": "/getStructuresOfSection",
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

      // Process structure data (check 'objectJson' or 'message')
      dynamic jsonList = responseData['objectJson'] ?? responseData['message'];
      if (jsonList == null) {
        throw Exception("No structure data received");
      }

      List<DTRStructureEntity> dataList = [];

      if (jsonList is String) {
        // Clean and parse JSON string
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }

        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => DTRStructureEntity.fromJson(json))
            .toList();
      } else if (jsonList is List) {
        dataList =
            jsonList.map((json) => DTRStructureEntity.fromJson(json)).toList();
      }


      _structures = dataList
          .where((e) => e.structureCode != null)
          .map((e) => DropdownOption(
        optionId: e.structureCode!,
        optionName: e.structureCode!,
      ))
          .toList();

      // Extract the first structureCode from the dataList (or the 'objectJson')
      String firstStructureCode =
      dataList.isNotEmpty ? dataList[0].structureCode! : "";
      await _loadStructureDetails(firstStructureCode);


      // Debugging: Print first structureCode and the structures list
      print("Fetched ${dataList.length} structures");
      print("First structure code: $firstStructureCode");

      // Set the default selected structure code
      if (firstStructureCode.isNotEmpty) {
        _selectedStructureId = firstStructureCode; // Set default selection
        print("Default selected structure ID set to: $_selectedStructureId");
        print(
            "Calling _loadStructureDetails with $firstStructureCode, isLoadingStructures: $_isLoadingStructures");
        // await _loadStructureDetails(firstStructureCode);
        _isLoadingStructures =
        false;
        notifyListeners();
      } else {
        print("No structure code found.");
      }

      print("Successfully loaded ${_structures.length} structures");
    } catch (e, stackTrace) {
      print("Error fetching structures: $e\n$stackTrace");
      if (context.mounted) {
        showErrorDialog(context, "Failed to load structures: ${e.toString()}");
      }
    } finally {
      _isLoadingStructures = false;
      notifyListeners();
    }
  }


  Future<void> setSelectedStructure(String? structureId) async {
    _selectedStructureId = structureId;
    if (structureId != null) {
      await _loadStructureDetails(structureId);
    } else {
      _currentStructure = null;
    }
    notifyListeners();
  }

  Future<void> _loadStructureDetails(String structureCode) async {
    if (_isLoadingStructureDetails) return;
    print("Confirmed entry into _loadStructureDetails with $structureCode");
    _isLoadingStructureDetails = true;
    notifyListeners();

    try {
      print("Inside try block of _loadStructureDetails");
      String authToken =
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '';
      print("Auth token retrieved: $authToken");

      final requestData = {
        "authToken": authToken,
        "api": Apis.API_KEY,
        "structureCode": structureCode,
      };

      final payload = {
        "path": "/getDtrsOfStructure",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      print("Request payload: $payload");

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload)
          .timeout(const Duration(seconds: 30), onTimeout: () {
        throw Exception("API call timed out");
      });

      print("API response: $response");
      if (response == null) {
        throw Exception("No response received from server");
      }

      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      print("Structure details data received: $responseData");

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

      dynamic jsonData = responseData['objectJson'] ?? responseData['message'];
      if (jsonData == null) {
        throw Exception("No structure data received");
      }

      // Parse the nested JSON
      Map<String, dynamic> apiDetails;
      if (jsonData is String) {
        String cleanedJson = jsonData.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        apiDetails = jsonDecode(cleanedJson);
      } else {
        apiDetails = jsonData as Map<String, dynamic>;
      }

      print("Parsed structure details: $apiDetails");

      // Populate failedEquipmentList
      failedEquipmentList.clear();
      final equipmentCode = apiDetails['equipmentCode']?.toString();
      if (equipmentCode != null && equipmentCode.isNotEmpty) {
        failedEquipmentList.add(equipmentCode);
        if (_failedEquipmentCode == null) {
          _failedEquipmentCode = equipmentCode;
        }
      }

      // Map API fields to labels
      _structureDetails = _structureDetailLabels.map((label) {
        String value;
        switch (label) {
          case 'STRUCTURE CODE':
            value = structureCode; // Use input structureCode
            break;
          case 'LANDMARK':
            value = apiDetails['landMark']?.toString() ?? 'Corporate office 2';
            break;
          case 'DISTRIBUTION':
            value = apiDetails['distributionCode']?.toString() ?? '122121';
            break;
          case 'SS NO':
            value = apiDetails['ssNo']?.toString() ?? 'SS-0078';
            break;
          case 'SUB STATION':
            value = apiDetails['subStation']?.toString() ?? '12241-NAKKALAGUTTA';
            break;
          case 'FEEDER':
            value = apiDetails['feeder']?.toString() ?? 'NAKKALAGUTTA-NKG-SS-0078';
            break;
          case 'STRUCTURE CAPACITY':
            value = apiDetails['capacity']?.toString() ?? '1*135';
            break;
          case 'STRUCTURE TYPE':
            value = apiDetails['locType']?.toString() ?? 'Double pole';
            break;
          case 'PLINTH TYPE':
            value = apiDetails['plinthType']?.toString() ?? 'Pillar Type';
            break;
          case 'AB SWITCH TYPE':
            value = apiDetails['abSwitch']?.toString() ?? 'Horizontal';
            break;
          case 'HG FUSE SETS':
            value = apiDetails['hgFuse']?.toString() ?? 'Horizontal';
            break;
          case 'LT FUSE SETS':
            value = apiDetails['ltFuse']?.toString() ?? 'Not Available';
            break;
          case 'LT FUSE TYPE':
            value = apiDetails['ltFuseType']?.toString() ?? 'Not Available';
            break;
          case 'LOAD PATTERN':
            value = apiDetails['loadPattern']?.toString() ?? 'HT Service';
            break;
          case 'LATITUDE':
            value = apiDetails['latitude']?.toString() ?? '18.005345';
            break;
          case 'LONGITUDE':
            value = apiDetails['longitude']?.toString() ?? '79.78788';
            break;
          case 'DATE OF CREATION':
            value = apiDetails['confirmDate']?.toString() ?? '2024-02-20 09:05:01.0';
            break;
          case 'EMPLOYEE ID':
            value = apiDetails['createdBy']?.toString() ?? '40005450';
            break;
          default:
            value = 'N/A';
        }
        return {'label': label, 'value': value};
      }).toList();

      print("Structure details list: $_structureDetails");
      print("Updated failedEquipmentList: $failedEquipmentList");

      print("Successfully loaded structure details");
    } catch (e, stackTrace) {
      print("Error fetching structure details: $e\n$stackTrace");
      if (context.mounted) {
        showErrorDialog(context, "Failed to load structure details: ${e.toString()}");
      }
    } finally {
      _isLoadingStructureDetails = false;
      notifyListeners();
    }
  }

  // Lists
  // final List<String> locationList = ["NAKKALAGUTTA"];
  // final List<String> failedEquipmentList = ["200049446"];
  // final List<String> failedStructureCodeList = [
  //   '12234-NAKKALAGUTTA-NKG-SS-0071',
  //   '12235-NAKKALAGUTTA-NKG-SS-0072',
  //   '12236-NAKKALAGUTTA-NKG-SS-0073',
  //   '12237-NAKKALAGUTTA-NKG-SS-0074',
  //   '12238-NAKKALAGUTTA-NKG-SS-0075',
  //   '12239-NAKKALAGUTTA-NKG-SS-0076',
  //   '12240-NAKKALAGUTTA-NKG-SS-0077',
  //   '12241-NAKKALAGUTTA-NKG-SS-0078',
  //   '12242-NAKKALAGUTTA-NKG-SS-0079',
  //   '12243-NAKKALAGUTTA-NKG-SS-0080',
  // ];

  // Text controllers
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Failure reason checkboxes
  bool highRatingHG = false;
  bool highRatingLT = false;
  bool ventPipeBurst = false;
  bool gasketDamaged = false;
  bool earthWireCut = false;
  bool looseLinesInTheEarth = false;
  bool phaseTouching = false;
  bool phTouching = false;
  bool dueToLightning = false;
  bool heavyWind = false;
  bool dtrInstalled = false;
  bool improperHG = false;
  bool improperLT = false;
  bool tankCrack = false;
  bool moistureEntry = false;
  bool flashover = false;
  bool improperEarthing = false;
  bool overload = false;
  bool hgFuse = false;
  bool faultDueToAGL = false;
  bool oilGushing = false;
  bool lowOilLevel = false;
  bool tankBurst = false;
  bool agingOfDTR = false;
  bool theftOfOil = false;
  bool floodsFallenOil = false;
  bool floodsSubmerged = false;
  bool other = false;

  // Estimate required checkboxes
  bool estimateRequiredYes = false;
  bool estimateRequiredNo = false;

  // Getters
  String? get selectedLocation => _selectedLocation;
  String? get selectedStructureCode => _selectedStructureCode;

  // Setters
  void setSelectedLocation(String? value) {
    _selectedLocation = value;
    notifyListeners();
  }

  void setSelectedStructureCode(String? value) {
    _selectedStructureCode = value;
    notifyListeners();
  }

  void setFailureDate(String date) {
    dateController.text = date;
    notifyListeners();
  }

  void setFailureTime(String time) {
    timeController.text = time;
    notifyListeners();
  }

  void toggleCheckbox(String field, bool value) {
    switch (field) {
      case 'highRatingHG':
        highRatingHG = value;
        break;
      case 'highRatingLT':
        highRatingLT = value;
        break;
      case 'ventPipeBurst':
        ventPipeBurst = value;
        break;
      case 'gasketDamaged':
        gasketDamaged = value;
        break;
      case 'earthWireCut':
        earthWireCut = value;
        break;
      case 'looseLinesInTheEarth':
        looseLinesInTheEarth = value;
        break;
      case 'phaseTouching':
        phaseTouching = value;
        break;
      case 'phTouching':
        phTouching = value;
        break;
      case 'dueToLightning':
        dueToLightning = value;
        break;
      case 'heavyWind':
        heavyWind = value;
        break;
      case 'dtrInstalled':
        dtrInstalled = value;
        break;
      case 'improperHG':
        improperHG = value;
        break;
      case 'improperLT':
        improperLT = value;
        break;
      case 'tankCrack':
        tankCrack = value;
        break;
      case 'moistureEntry':
        moistureEntry = value;
        break;
      case 'flashover':
        flashover = value;
        break;
      case 'improperEarthing':
        improperEarthing = value;
        break;
      case 'overload':
        overload = value;
        break;
      case 'hgFuse':
        hgFuse = value;
        break;
      case 'faultDueToAGL':
        faultDueToAGL = value;
        break;
      case 'oilGushing':
        oilGushing = value;
        break;
      case 'lowOilLevel':
        lowOilLevel = value;
        break;
      case 'tankBurst':
        tankBurst = value;
        break;
      case 'agingOfDTR':
        agingOfDTR = value;
        break;
      case 'theftOfOil':
        theftOfOil = value;
        break;
      case 'floodsFallenOil':
        floodsFallenOil = value;
        break;
      case 'floodsSubmerged':
        floodsSubmerged = value;
        break;
      case 'other':
        other = value;
        break;
      case 'estimateRequiredYes':
        estimateRequiredYes = value;
        estimateRequiredNo = !value; // Mutually exclusive
        break;
      case 'estimateRequiredNo':
        estimateRequiredNo = value;
        estimateRequiredYes = !value; // Mutually exclusive
        break;
    }
    notifyListeners();
  }

  void save() {
   print( SharedPreferenceHelper.getStringValue(
        LoginSdkPrefs.sectionCodePrefKey)+"Section Code");
    // Implement save logic here (e.g., API call)
    print('Saving DTR Failure Report:');
    print('Location: $_selectedLocation');
    print('Equipment Code: $_failedEquipmentCode');
    print('Structure Code: $_selectedStructureCode');
    print('Date: ${dateController.text}');
    print('Time: ${timeController.text}');
    // Add other fields as needed
  }
}