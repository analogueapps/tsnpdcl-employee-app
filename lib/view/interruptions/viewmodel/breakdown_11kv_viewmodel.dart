import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/feeder_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class Breakdown11kvViewmodel extends ChangeNotifier {
  final BuildContext context;
  List<SubstationModel> _substations = [];
  String? selectedOptionId; // Store the selected optionId
  String? selectedSubstation;
  List<FeederModel> _feeders = [];
  String? selectedFeeder;
  bool _isLoading = false;
  String? selectedSupplyOption; // Possible values: "Not Arranged", "Arranged", "Partially Provided", or null
  DateTime? selectedDateTime;
  final TextEditingController substationsController = TextEditingController();
  List<SubstationModel> get substations => _substations; // Updated to return SubstationModel
  List<FeederModel> get feeders => _feeders; // Updated to return FeederModel
  bool get isLoading => _isLoading;

  Breakdown11kvViewmodel({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSubstations();
    });
  }

  // Function to set the selected optionId when a substation is selected
  void setSelectedOptionId(String optionId) {
    selectedOptionId = optionId;
    notifyListeners(); // Notify listeners when the optionId changes
  }

  Future<void> getSubstations() async {
    _substations.clear();
    _isLoading = true; // Set loading state to true
    notifyListeners();
    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };
    var response = await ApiProvider(baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_SUBSTATIONS_OF_SECTION, payload); // Updated endpoint

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == true) {
            if (response.data['taskSuccess'] == true) {
              List<dynamic> jsonList;
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = []; // Fallback to empty list if the type is unexpected
              }
              final List<SubstationModel> dataList =
              jsonList.map((json) => SubstationModel.fromJson(json)).toList();
              _substations.addAll(dataList); // Update _substations list
              notifyListeners();
            }
          }
        } else {
          showAlertDialog(
              context, response.data['message'] ?? "API returned status ${response.statusCode}");
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Modify the setSelectedSubstation to fetch feeders
  void setSelectedSubstation(String? substation) {
    selectedSubstation = substation;
    // Find the selected substation
    final selected = _substations.firstWhere(
          (s) => s.optionName == substation,
      orElse: () => SubstationModel(optionId: null, optionName: null),
    );
    if (selected.optionId != null) {
      selectedOptionId = selected.optionId;
      selectedFeeder = null; // Reset feeder selection
      _feeders.clear(); // Clear previous feeders
      notifyListeners();
      // Now call the API with the selected optionId
      sendOptionIdToApi();
    } else {
      selectedOptionId = null;
      _feeders.clear();
      notifyListeners();
    }
  }

  void setSelectedFeeder(String? feeder) {
    selectedFeeder = feeder;
    notifyListeners();
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
          isTrue);
      selectedDateTime = null; // Reset to null to invalidate the selection
    } else {
      notifyListeners(); // Only notify if the selection is valid
    }
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
  }

  void setSupplyOption(String? option) {
    selectedSupplyOption = option; // Set the selected option, or null to deselect
    notifyListeners();
  }

  // Updated sendOptionIdToApi to handle FeederModel data
  Future<void> sendOptionIdToApi() async {
    if (selectedOptionId == null || selectedOptionId!.isEmpty) {
      return; // Just return silently if no optionId is selected
    }
    _isLoading = true;
    notifyListeners();
    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ssCode": selectedOptionId!,
    };
    try {
      var response = await ApiProvider(baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.GET_FEEDERS_OF_SS, payload); // Updated endpoint
      if (response != null) {
        // Handle response parsing
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode &&
            response.data['sessionValid'] == true &&
            response.data['taskSuccess'] == true) {
          List<dynamic> jsonList = [];
          if (response.data['dataList'] is String) {
            jsonList = jsonDecode(response.data['dataList']);
          } else if (response.data['dataList'] is List) {
            jsonList = response.data['dataList'];
          }
          _feeders = jsonList.map((json) => FeederModel.fromJson(json)).toList();
        } else {
          // Handle error cases
          String errorMessage = response.data['message'] ?? "Failed to load feeders";
        }
      }
    } catch (e) {
      print("Feeder API Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitData() async {
    // Validation for all required fields
    if (selectedSubstation == null) {
      AlertUtils.showSnackBar(context, "Please select a Substation.", isTrue);
      return;
    }
    if (selectedFeeder == null) {
      AlertUtils.showSnackBar(context, "Please select a Feeder.", isTrue);
      return;
    }
    if (selectedDateTime == null) {
      AlertUtils.showSnackBar(
          context, "Please select a Breakdown Start Time.", isTrue);
      return;
    }
    if (selectedSupplyOption == null) {
      AlertUtils.showSnackBar(
          context, "Please select an Alternative Supply option.", isTrue);
      return;
    }
    if (substationsController.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please enter the Number of Villages Affected.", isTrue);
      return;
    }

    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "voltage": "11KV",
      "ssCode": selectedOptionId, // Using the selected substation's optionId
      "ssName": selectedSubstation,
      "fdrCode":
      _feeders.firstWhere((f) => f.optionName == selectedFeeder).optionId,
      "fdrName": selectedFeeder,
      "startDate": DateFormat("dd/MM/yyyy").format(selectedDateTime!),
      "startTime": DateFormat("HH:mm").format(selectedDateTime!),
      "alternative": selectedSupplyOption,
      "noOfVillagesAffected": substationsController.text,
    };

    try {
      var response =
      await ApiProvider(baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.SAVE_BREAKDOWN_REPORT,
          payload); // Replace with your actual API endpoint
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode &&
            response.data['sessionValid'] == true) {
          if (response.data['taskSuccess'] == true) {
            await showAlertDialog(context, response.data['message']);
            Navigator.of(context).pop();
          } else {
            showAlertDialog(
                context, response.data['message'] ?? "Submission failed");
          }
        } else {
          showAlertDialog(context, response.data['message'] ?? "API error");
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}