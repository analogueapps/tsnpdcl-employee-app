import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dtr_structure_entity.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dropdown_option.dart';

class OverloadedDtrsProvider with ChangeNotifier {
  final sectionCode = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final section = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionPrefKey);
  final BuildContext context;
  List<DropdownOption> _structures = [];
  Map<String, dynamic>? _currentStructure;
  bool _isLoading = false;
  bool _isLoadingStructures = false;
  bool _isLoadingStructureDetails = false;
  String? _selectedStructureId;
// Add these to your provider class
  final TextEditingController rphController = TextEditingController();
  final TextEditingController yphController = TextEditingController();
  final TextEditingController bphController = TextEditingController();
  final TextEditingController neutralController = TextEditingController();
  final TextEditingController totalLoadController = TextEditingController();
  DateTime? selectedDateTime;
  String? selectedLocationType;
  List<DropdownOption> get structures => _structures;
  Map<String, dynamic>? get currentStructure => _currentStructure;
  bool get isLoading => _isLoading;
  bool get isLoadingStructures => _isLoadingStructures;
  bool get isLoadingStructureDetails => _isLoadingStructureDetails;
  String? get selectedStructureId => _selectedStructureId;

  final ApiProvider _apiProvider = ApiProvider(baseUrl: Apis.TONG_TESTER_END_POINT_BASE_URL);
  String? selectedStructureCode;

  OverloadedDtrsProvider(this.context) {
    _fetchStructures();
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        notifyListeners();
      }
    }
  }

  Future<void> _fetchStructures() async {
    if (_isLoadingStructures) return; // Prevent duplicate calls
    _isLoadingStructures = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? "",
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
        throw Exception(responseData['message'] ?? "Request failed with status ${response.statusCode}");
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
        dataList = jsonList.map((json) => DTRStructureEntity.fromJson(json)).toList();
      }

      // Convert to DropdownOption list
      _structures = dataList
          .where((e) => e.structureCode != null)
          .map((e) => DropdownOption(
        optionId: e.structureCode!,
        optionName: e.structureCode!,
      ))
          .toList();

      // Extract the first structureCode from the dataList (or the 'objectJson')
      String firstStructureCode = dataList.isNotEmpty ? dataList[0].structureCode! : "";

      // Debugging: Print first structureCode and the structures list
      print("Fetched ${dataList.length} structures");
      print("First structure code: $firstStructureCode");

      // Set the default selected structure code
      if (firstStructureCode.isNotEmpty) {
        _selectedStructureId = firstStructureCode; // Set default selection
        print("Default selected structure ID set to: $_selectedStructureId");
        print("Calling _loadStructureDetails with $firstStructureCode, isLoadingStructures: $_isLoadingStructures");
        _isLoadingStructures = false; // Reset before calling _loadStructureDetails
        notifyListeners();
        try {
          await _loadStructureDetails(firstStructureCode);
        } catch (e) {
          print("Error during _loadStructureDetails call: $e");
        }
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
    if (_isLoadingStructureDetails) return; // Prevent duplicate calls
    print("Confirmed entry into _loadStructureDetails with $structureCode");
    _isLoadingStructureDetails = true;
    notifyListeners();

    try {
      print("Inside try block of _loadStructureDetails");
      String authToken = await SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ?? '';
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
          .timeout(Duration(seconds: 30), onTimeout: () {
        throw Exception("API call timed out");
      });

      print("API response: $response");
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
        throw Exception(responseData['message'] ?? "Request failed with status ${response.statusCode}");
      }

      if (responseData['tokenValid'] != true) {
        showSessionExpiredDialog(context);
        return;
      }

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? "Operation failed");
      }

      // Process structure details data (check 'objectJson' or 'message')
      dynamic jsonData = responseData['objectJson'] ?? responseData['message'];
      if (jsonData == null) {
        throw Exception("No structure data received");
      }

      print("Structure details data received: $jsonData");

      if (jsonData is String) {
        // Clean and parse JSON string (aligned with _fetchStructures)
        String cleanedJson = jsonData.replaceAll(r'\"', '"').trim();

        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }

        if (!cleanedJson.startsWith('{') && !cleanedJson.startsWith('[')) {
          cleanedJson = '{$cleanedJson}';
        }

        _currentStructure = jsonDecode(cleanedJson);
      } else {
        _currentStructure = jsonData; // Direct assignment if already a map
      }

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

  Future<void> saveTongTesterReading() async {
    if (_currentStructure == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final payload = {
        "authToken": await SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.tokenPrefKey) ?? '',
        "api": await SharedPreferenceHelper.getStringValue(
            LoginSdkPrefs.apiPrefKey) ?? '',
        "structureCode": selectedStructureCode ?? "",
        "readingData": "", // Replace with actual data
      };

      final response = await _apiProvider.postApiCall(context, Apis.SAVE_TONG_TESTER_READING, payload);

      if (response?.statusCode != successResponseCode) {
        showErrorDialog(context, "Failed to save data. Please try again.");
      } else {
        showSuccessDialog(context, "Tong tester reading saved successfully.", isFalse as VoidCallback);
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred while saving the data.");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    rphController.dispose();
    yphController.dispose();
    bphController.dispose();
    neutralController.dispose();
    totalLoadController.dispose();
    super.dispose();
  }
}
