import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'dart:convert';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import '../../../utils/app_constants.dart';

class InterruptionsModel {
  final String optionCode;
  final String optionName;

  InterruptionsModel({
    required this.optionCode,
    required this.optionName,
  });

  factory InterruptionsModel.fromJson(Map<String, dynamic> json) {
    return InterruptionsModel(
      optionCode: json['optionCode'] as String? ?? '',
      optionName: json['optionName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'optionCode': optionCode,
        'optionName': optionName,
      };
}

class InterruptionsEntryViewmodel extends ChangeNotifier {
  final TextEditingController substationsController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? selectedOption = "Feeder";
  String? selectedSupplyPosition = "Restored";
  String? selectedLV;
  String? selectedCircle;
  String? selectedSubstation;
  String? selectedInterruptionType;

  List<InterruptionsModel> circles = [
    InterruptionsModel(optionCode: "000", optionName: "SELECT"),
    InterruptionsModel(optionCode: "401", optionName: "KHAMMAM"),
    InterruptionsModel(optionCode: "402", optionName: "HANAMKONDA"),
    InterruptionsModel(optionCode: "407", optionName: "WARANGAL"),
    InterruptionsModel(optionCode: "403", optionName: "KARIMNAGAR"),
    InterruptionsModel(optionCode: "405", optionName: "ADILABAD"),
    InterruptionsModel(optionCode: "404", optionName: "NIZAMABAD"),
    InterruptionsModel(optionCode: "406", optionName: "BHADRADRI KOTHAGUDEM"),
    InterruptionsModel(optionCode: "408", optionName: "JANGAON"),
    InterruptionsModel(optionCode: "409", optionName: "BHOOPALAPALLY"),
    InterruptionsModel(optionCode: "410", optionName: "MAHABUBABAD"),
    InterruptionsModel(optionCode: "411", optionName: "JAGITYAL"),
    InterruptionsModel(optionCode: "412", optionName: "PEDDAPALLY"),
    InterruptionsModel(optionCode: "413", optionName: "KAMAREDDY"),
    InterruptionsModel(optionCode: "414", optionName: "NIRMAL"),
    InterruptionsModel(optionCode: "415", optionName: "ASIFABAD"),
    InterruptionsModel(optionCode: "416", optionName: "MANCHERIAL"),
  ];

  List<InterruptionsModel> substations = [];
  List<InterruptionsModel> feeders = [];
  List<String> selectedFeeders = [];

  final List<String> interruptionTypes = [
    "Select",
    "Hand Trippings",
    "EL",
    "OL",
    "LR",
    "LC",
    "EL and OL"
  ];

  DateTime? fromDateTime;
  DateTime? toDateTime;

  String? _selectedStation;

  String? get selectedStation => _selectedStation;

  final List<InterruptionsModel> _stations = [];

  List<InterruptionsModel> get stations => _stations;

  void onStationSelected(String? value) {
    _selectedStation = value;
    notifyListeners();
  }

  void setSelectedCircle(String? code, BuildContext context) {
    selectedCircle = code;
    if (code != "000") {
      loadSubstations(code!, context);
    } else {
      substations.clear();
      feeders.clear();
      selectedFeeders.clear();
      selectedSubstation = null;
    }
    notifyListeners();
  }

  void setSelectedSubstation(String? code, BuildContext context) {
    selectedSubstation = code;
    if (code != null && code != "000") {
      loadFeeders(code, context);
    } else {
      feeders.clear();
      selectedFeeders.clear();
    }
    notifyListeners();
  }

  void setSelectedLV(String? lv) {
    selectedLV = lv;
    notifyListeners();
  }

  void setSelectedInterruptionType(String? type) {
    selectedInterruptionType = type;
    notifyListeners();
  }

  void toggleOption(String value) {
    selectedOption = value;
    if (value == "ISF") {
      selectedFeeders = feeders.map((f) => f.optionCode).toList();
    } else {
      selectedFeeders.clear();
    }
    notifyListeners();
  }

  void setSupplyPosition(String? position) {
    selectedSupplyPosition = position;
    if (position == "Not Restored") {
      toDateTime = null;
    }
    notifyListeners();
  }

  void toggleFeederSelection(String feederCode) {
    if (selectedFeeders.contains(feederCode)) {
      selectedFeeders.remove(feederCode);
    } else {
      selectedFeeders.add(feederCode);
    }
    notifyListeners();
  }

  Future<void> selectFromDateTime(BuildContext context) async {
    final now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: fromDateTime ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: fromDateTime != null
          ? TimeOfDay(hour: fromDateTime!.hour, minute: fromDateTime!.minute)
          : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    fromDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    notifyListeners();
  }

  Future<void> selectToDateTime(BuildContext context) async {
    final now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: toDateTime ?? (fromDateTime ?? now),
      firstDate: fromDateTime ?? DateTime(2000),
      lastDate: now,
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: toDateTime != null
          ? TimeOfDay(hour: toDateTime!.hour, minute: toDateTime!.minute)
          : TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    toDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (toDateTime!.isBefore(fromDateTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(AlertUtils.showSnackBar(
          context, "End time cannot be before start time", isTrue));
      toDateTime = null;
    }

    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
  }

  String getDuration() {
    if (fromDateTime == null || toDateTime == null) return "00:00";
    final difference = toDateTime!.difference(fromDateTime!);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  bool shouldShowReason() {
    if (selectedOption == "LV" || selectedOption == "ISF") return true;
    if (selectedInterruptionType == null ||
        selectedInterruptionType == "Select") {
      return false;
    }
    final index = interruptionTypes.indexOf(selectedInterruptionType!);
    return index == 1 || index == 2 || index == 5 || index == 6;
  }

  Future<void> loadSubstations(String circleCode, BuildContext context) async {
    if (_isLoading) return;

    _isLoading = true;
    _stations.clear();
    substations.clear();
    notifyListeners();

    try {
      final requestData = {
        "authToken":
            SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "circleCode": circleCode
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
        throw Exception("No station data received");
      }

      final jsonList = responseData['objectJson'];
      List<InterruptionsModel> dataList = [];

      if (jsonList is String) {
        String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();
        if (cleanedJson.endsWith(',')) {
          cleanedJson = cleanedJson.substring(0, cleanedJson.length - 1);
        }
        if (!cleanedJson.startsWith('[')) {
          cleanedJson = '[$cleanedJson]';
        }
        dataList = (jsonDecode(cleanedJson) as List)
            .map((json) => InterruptionsModel.fromJson(json))
            .toList();
      } else if (jsonList is List) {
        dataList =
            jsonList.map((json) => InterruptionsModel.fromJson(json)).toList();
      }

      _stations.addAll(dataList);
      // Ensure unique substations by filtering duplicates based on optionCode
      final uniqueStations = <String, InterruptionsModel>{};
      for (var station in dataList) {
        uniqueStations[station.optionCode] = station; // Last occurrence wins
      }
      substations = [
            InterruptionsModel(optionCode: "000", optionName: "SELECT")
          ] +
          uniqueStations.values.toList();
      print("Successfully loaded ${_stations.length} stations");
      print("Substations list size: ${substations.length}");
    } catch (e, stackTrace) {
      print("Error fetching stations: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load stations: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFeeders(String substationCode, BuildContext context) async {
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    feeders.clear();
    selectedFeeders.clear();
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ss": substationCode
    };

    final payload = {
      "path": "/load/feeders",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final jsonList = jsonDecode(response.data['objectJson']);
                List<InterruptionsModel> dataList = [];

                if (jsonList is String) {
                  // Clean and parse JSON string
                  String cleanedJson = jsonList.replaceAll(r'\"', '"').trim();

                  if (cleanedJson.endsWith(',')) {
                    cleanedJson =
                        cleanedJson.substring(0, cleanedJson.length - 1);
                  }

                  if (!cleanedJson.startsWith('[')) {
                    cleanedJson = '[$cleanedJson]';
                  }

                  dataList = (jsonDecode(cleanedJson) as List)
                      .map((json) => InterruptionsModel.fromJson(json))
                      .toList();
                } else if (jsonList is List) {
                  dataList = jsonList
                      .map((json) => InterruptionsModel.fromJson(json))
                      .toList();
                }

                feeders.addAll(dataList);
                print("Successfully loaded ${feeders.length} feeders");

                // If ISF is selected, automatically select all feeders
                if (selectedOption == "ISF") {
                  selectedFeeders = feeders.map((f) => f.optionCode).toList();
                }
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e, stackTrace) {
      print("Error fetching feeders: $e\n$stackTrace");
      showErrorDialog(context, "Failed to load feeders: ${e.toString()}");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool validate(BuildContext context) {
    if (selectedCircle == null || selectedCircle == "000") {
      AlertUtils.showSnackBar(context, "Please select circle", isTrue);
      return false;
    }
    if (selectedSubstation == null || selectedSubstation == "000") {
      AlertUtils.showSnackBar(context, "Please select substation", isTrue);
      return false;
    }
    if (selectedOption == "LV" &&
        (selectedLV == null || selectedLV == "SELECT")) {
      AlertUtils.showSnackBar(context, "Please select LV", isTrue);
      return false;
    }
    if (selectedFeeders.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select at least one feeder", isTrue);
      return false;
    }
    if (fromDateTime == null) {
      AlertUtils.showSnackBar(context, "Please select start time", isTrue);
      return false;
    }
    if (selectedSupplyPosition == "Restored" && toDateTime == null) {
      AlertUtils.showSnackBar(context, "Please select end time", isTrue);
      return false;
    }
    if (selectedOption != "ISF" &&
        (selectedInterruptionType == null ||
            selectedInterruptionType == "Select")) {
      AlertUtils.showSnackBar(
          context, "Please select interruption type", isTrue);
      return false;
    }
    if (shouldShowReason() && reasonController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter reason", isTrue);
      return false;
    }
    return true;
  }

  String generateRequestPayload() {
    // Core required fields
    final data = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "sscode": selectedSubstation,
      "feedercode": selectedFeeders,
      "fromTime": fromDateTime!.millisecondsSinceEpoch,
      "interruptionLevel": selectedOption == "Feeder" ? "F" : selectedOption,
    };

    // Conditional fields
    if (selectedOption == "LV") {
      data["lvType"] = selectedLV;
    }

    if (selectedSupplyPosition == "Restored") {
      data["toTime"] = toDateTime!.millisecondsSinceEpoch;
      data["duration"] = getDuration();
    }

    if (selectedOption != "ISF") {
      data["type"] = selectedInterruptionType;
    }

    if (shouldShowReason()) {
      data["reason"] = reasonController.text;
    }

    // Stringify the complete payload
    return jsonEncode({
      "path": "/saveInterruption",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(data), // Double stringify as per your API structure
    });
  }

  Future<void> submit(BuildContext context) async {
    if (!validate(context)) return;

    _isLoading = true;
    notifyListeners();

    try {
      final payload = generateRequestPayload();
      print("Final payload: $payload"); // Debug log

      final response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, jsonDecode(payload));
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

      AlertUtils.showSnackBar(context, responseData['message'], isFalse);
    } catch (e) {
      //     print("Error submitting interruption: $e\n$stackTrace");
      showErrorDialog(
          context, "Failed to submit interruption: ${e.toString()}");
      // Handle errors
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetForm() {
    selectedCircle = "000";
    selectedSubstation = null;
    selectedOption = "Feeder";
    selectedSupplyPosition = "Restored";
    selectedLV = null;
    selectedInterruptionType = null;
    fromDateTime = null;
    toDateTime = null;
    selectedFeeders.clear();
    substations.clear();
    feeders.clear();
    reasonController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    substationsController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
