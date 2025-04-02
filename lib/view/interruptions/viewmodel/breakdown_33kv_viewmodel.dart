import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/feeder_model.dart';
import 'package:tsnpdcl_employee/view/interruptions/model/substation_model.dart';

class Breakdown33kvViewmodel extends ChangeNotifier {
  final BuildContext context;
  String? selectedOptionId; // Store the selected optionId

  List<SubstationModel> _substations = [];
  String? selectedSubstation;

  // Change _feeders to List<FeederModel> as you're working with feeders
  List<FeederModel> _feeders = [];
  String? selectedFeeder;

  bool _isLoading = false;
  final List<SubstationModel> _subStationList = [];

  List<SubstationModel> get dtrStructureIndexList => _subStationList;

  String? selectedSupplyOption;
  DateTime? selectedDateTime;
  final TextEditingController substationsController = TextEditingController();

  List<SubstationModel> get substations => _substations;

  List<FeederModel> get feeders => _feeders; // Change this to List<FeederModel>
  bool get isLoading => _isLoading;

  Breakdown33kvViewmodel({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSubstations();
      // sendOptionIdToApi();
    });
  }

  // Function to set the selected optionId when a substation is selected
  void setSelectedOptionId(String optionId) {
    selectedOptionId = optionId;
    print("selectedOptionIddddddddddd $selectedOptionId");
    notifyListeners(); // Notify listeners when the optionId changes
  }

  Future<void> getSubstations() async {
    _substations.clear();
    _isLoading = true; // Set loading state to true
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    var response = await ApiProvider(
            baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_132KV_SUBSTATIONS_OF_SECTION, payload);

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
                jsonList =
                    []; // Fallback to empty list if the type is unexpected
              }
              final List<SubstationModel> dataList = jsonList
                  .map((json) => SubstationModel.fromJson(json))
                  .toList();
              _substations.addAll(dataList); // Update _substations list
              notifyListeners();
            }
          }
        } else {
          showAlertDialog(
              context,
              response.data['message'] ??
                  "API returned status ${response.statusCode}");
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
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateTime);
  }

  void setSupplyOption(String? option) {
    selectedSupplyOption = option;
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
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ssCode": selectedOptionId!,
    };

    try {
      var response =
          await ApiProvider(baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
              .postApiCall(context, Apis.GET_FEEDERS_OF_132KV_SS, payload);

      print('Feeder API Response: ${response?.data}');

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
          _feeders =
              jsonList.map((json) => FeederModel.fromJson(json)).toList();
        } else {
          // Handle error cases
          String errorMessage =
              response.data['message'] ?? "Failed to load feeders";
          print("Feeder API Error: $errorMessage");
        }
      }
    } catch (e) {
      print("Feeder API Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
