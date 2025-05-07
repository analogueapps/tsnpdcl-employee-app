import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dtr_structure_entity.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dropdown_option.dart';

class OverloadedFloatingButtonProvider with ChangeNotifier {
  final sectionCode =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final section =
  SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionPrefKey);
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

  String? selectedStructureCode;

  OverloadedFloatingButtonProvider(this.context) {
    fetchStructures();
  }

  Future<void> selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    // Determine if the selected date is today
    final now = DateTime.now();
    final isToday = pickedDate.year == now.year &&
        pickedDate.month == now.month &&
        pickedDate.day == now.day;

    // Set initial time for the time picker
    TimeOfDay initialTime =
    isToday ? TimeOfDay.now() : const TimeOfDay(hour: 23, minute: 59);

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime == null) return;

    selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Check if the selected date and time is in the future
    if (selectedDateTime!.isAfter(now)) {
      AlertUtils.showSnackBar(
          context,
          "Future date or time is not allowed. Please select a valid date and time.",
          true);
      selectedDateTime = null; // Reset to null to invalidate the selection
    } else {
      notifyListeners(); // Only notify if the selection is valid
    }
  }

  // Add this method to format DateTime as "DD/MM/YYYY HH:MM"
  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> fetchStructures() async {
    if (_isLoadingStructures) return; // Prevent duplicate calls
    _isLoadingStructures = true;
    notifyListeners();

    try {
      final requestData = {
        "authToken":
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ??
            "",
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

      // Convert to DropdownOption list
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

      // Debugging: Print first structureCode and the structures list
      print("Fetched ${dataList.length} structures");
      print("First structure code: $firstStructureCode");

      // Set the default selected structure code
      if (firstStructureCode.isNotEmpty) {
        _selectedStructureId = firstStructureCode; // Set default selection
        print("Default selected structure ID set to: $_selectedStructureId");
        print(
            "Calling _loadStructureDetails with $firstStructureCode, isLoadingStructures: $_isLoadingStructures");
        _isLoadingStructures =
        false; // Reset before calling _loadStructureDetails
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
      String authToken = await SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey) ??
          '';
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
        showErrorDialog(
            context, "Failed to load structure details: ${e.toString()}");
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

    // Show loader dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing while loading
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      print("Confirmed entry into saveTongTesterReading");

      // Retrieve auth token and API key from SharedPreferences
      String authToken = await SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey) ?? '';
      String apiKey = Apis.API_KEY;

      // Validate required fields
      if (rphController.text.isEmpty ||
          yphController.text.isEmpty ||
          bphController.text.isEmpty ||
          neutralController.text.isEmpty ||
          totalLoadController.text.isEmpty ||
          selectedDateTime == null ||
          selectedLocationType == null) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("All tong tester reading fields must be filled"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        _isLoading = false;
        notifyListeners();
        return; // Exit early if fields are empty
      }

      // Format date and time from selectedDateTime
      String readingDate =
          "${selectedDateTime!.day.toString().padLeft(2, '0')}/${selectedDateTime!.month.toString().padLeft(2, '0')}/${selectedDateTime!.year}";
      String readingTime =
          "${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}";

      // Get equipmentCode from the first DTR in currentStructure
      List<dynamic> dtrs = _currentStructure!['dtrs'] ?? [];
      if (dtrs.isEmpty) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("No DTRs found in the selected structure"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        _isLoading = false;
        notifyListeners();
        return; // Exit early if no DTRs
      }
      String equipmentCode = dtrs[0]['equipmentCode'] ?? '';

      // Prepare the DTR data with tong tester readings
      final dtrData = {
        "equipmentCode": equipmentCode,
        "irPh": rphController.text,
        "iYPh": yphController.text,
        "ibPh": bphController.text,
        "inPh": neutralController.text,
        "loadInKva": totalLoadController.text,
        "readingDate": readingDate,
        "readingTime": readingTime,
        "locationType": selectedLocationType,
      };

      // Prepare the request data (inner JSON)
      final requestData = {
        "authToken": authToken,
        "api": apiKey,
        "data": {
          "structureCode": _selectedStructureId ?? "",
          "dtrs": [dtrData], // Single DTR with readings
        },
        "sectionCode": sectionCode ?? "",
      };

      // Prepare the full payload
      final payload = {
        "path": "/savedTongTesterReading",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData), // Stringify the inner request data
      };

      print("Request payload: $payload");

      // Make the API call with timeout
      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload)
          .timeout(Duration(seconds: 30), onTimeout: () {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("API call timed out"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        throw Exception("API call timed out"); // Keep the throw for catch block
      });

      print("API response: $response");
      if (response == null) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("No response received from server"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        _isLoading = false;
        notifyListeners();
        return; // Exit early if no response
      }

      // Process response data
      dynamic responseData = response.data;
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }

      // Validate response
      if (response.statusCode != successResponseCode) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(
                  responseData['message'] ??
                      "Request failed with status ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      if (responseData['tokenValid'] != true) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Session Expired"),
              content: const Text("Your session has expired. Please log in again."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      if (responseData['success'] != true) {
        Navigator.pop(context); // Dismiss loader
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(responseData['message'] ?? "Operation failed"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }

      print("Tong tester reading saved successfully");
      Navigator.pop(context); // Dismiss loader
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Tong tester reading saved successfully"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e, stackTrace) {
      print("Error saving tong tester reading: $e\n$stackTrace");
      Navigator.pop(context); // Dismiss loader
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text("Failed to save tong tester reading: ${e.toString()}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
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