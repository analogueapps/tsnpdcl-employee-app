import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dropdown_option.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/dtr_structure_entity.dart';

class RepeatedDTRFailureViewModel extends ChangeNotifier {
  RepeatedDTRFailureViewModel({required this.context}) {
    // _fetchStructures();
  }
  final formKey = GlobalKey<FormState>();
  final sectionCode =
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey);
  final section =
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionPrefKey);
  final BuildContext context;
  final List<DropdownOption> _structures = [];
  DateTime? selectedDateTime;
  Map<String, dynamic>? _currentStructure;
  bool _isLoading = false;
  final bool _isLoadingStructures = false;
  final bool _isLoadingStructureDetails = false;
  String? _selectedStructureId;

  List<DropdownOption> get structures => _structures;
  Map<String, dynamic>? get currentStructure => _currentStructure;
  bool get isLoading => _isLoading;
  bool get isLoadingStructures => _isLoadingStructures;
  bool get isLoadingStructureDetails => _isLoadingStructureDetails;
  String? get selectedStructureId => _selectedStructureId;

  final List<FeederDisModel> _structureData = [];
  List<FeederDisModel> get structureData => _structureData;

  //equipment code :
  final List<String> failedEquipmentList = ["--SELECT--"];
  String? get failedEquipmentCode => _failedEquipmentCode;
  void setFailedEquipmentCode(String? value) {
    _failedEquipmentCode = value;
    notifyListeners();
  }

  // Dropdown selections
  String? _failedEquipmentCode;
  String? _selectedStructureCode;

  String get getEstimateRequired => estimateRequired;
  String? get selectedStructureCode => _selectedStructureCode;

  void setSelectedStructureCode(String? value) {
    _selectedStructureCode = value;
    notifyListeners();
  }

//Date and time
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  void setFailureDate(String date) {
    dateController.text = date;
    notifyListeners();
  }

  void setFailureTime(String time) {
    timeController.text = time;
    notifyListeners();
  }

  Future<void> setSelectedStructure(String? structureId) async {
    failedEquipmentList.clear();
    _failedEquipmentCode = null;
    notifyListeners();
    _selectedStructureId = structureId;
    if (structureId != null) {
      // await _loadStructureDetails(structureId);
      print("stuctureId: $structureId");
    } else {
      _currentStructure = null;
    }
    notifyListeners();
  }

  //Dtr failure reason
  List<String> failureReasons = [];

  void toggleFailureReason(String reason) {
    if (failureReasons.contains(reason)) {
      failureReasons.remove(reason); // Uncheck: Remove from list
    } else {
      failureReasons.add(reason); // Check: Add to list
    }
    notifyListeners();
  }

  List<String> get getFailureReasons => failureReasons;

  //yes or no check box
  String estimateRequired = "";
  void toggleEstimateRequired(String value) {
    if (estimateRequired == value) {
      estimateRequired = "";
    } else {
      estimateRequired = value;
    }
    notifyListeners();
  }

  void save() {
    formKey.currentState!.save();
    notifyListeners();

    if (!validateForm()) {
      return;
    } else {
      saveDTRFailure(failureReasons, getEstimateRequired, dateController.text,
          timeController.text, selectedStructureId!, _failedEquipmentCode!);
      print(
          "${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey)}Section Code");
      print('Equipment Code: $_failedEquipmentCode');
      print('Structure Code: $selectedStructureId');
      print('Date: ${dateController.text}');
      print('Time: ${timeController.text}');
      print('estimateRequiredNo: $getEstimateRequired');
      print('reason: $failureReasons');
    }
  }

  bool validateForm() {
    if ((dateController.text == '') && (timeController.text == "")) {
      AlertUtils.showSnackBar(
          context, "Please select DTR failure date and time", isTrue);
      print("Please select DTR failure date");
      return false;
    } else if (dateController.text.isNotEmpty && timeController.text.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select DTR failure time", isTrue);
      return false;
    } else if (dateController.text.isEmpty && timeController.text.isNotEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select DTR failure date", isTrue);
      return false;
    } else if (failureReasons.isEmpty || failureReasons == []) {
      AlertUtils.showSnackBar(context,
          "Please select at least one reason for the  DTR failure", isTrue);
      return false;
    } else if (getEstimateRequired.isEmpty) {
      AlertUtils.showSnackBar(
          context, "Please select Estimate Required Yes/No", isTrue);
      return false;
    } else if (_failedEquipmentCode == null) {
      AlertUtils.showSnackBar(
          context, "Please select failed equipment code ", isTrue);
      return false;
    }
    return true;
  }

  Future<void> saveDTRFailure(List<String> reasons, String estimateRequired,
      String date, String time, String structCode, String equipmentCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "reasons": reasons,
      "estimateRequired": estimateRequired,
      "failureDate": date,
      "failureTime": time,
      "structureCode": structCode,
      "equipmentCode": equipmentCode,
      "reportedBySap": "Y", //reportedBySap ==false?Y:N
      "sapFailureCount": "INSPECTED",
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL)
        .postApiCall(context, Apis.SAVE_DTR_FAILURE_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == true) {
            if (response.data['taskSuccess'] == true) {
              if (response.data['message'] != null &&
                  (response.data['dataList'] == null ||
                      response.data['dataList'].isEmpty)) {
                showErrorDialog(context, response.data['message']);
              } else {
                showSuccessDialog(
                    context, response.data['message'] ?? 'Success', () {
                  Navigator.pop(context);
                });
              }
            } else {
              showErrorDialog(
                  context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(
              context,
              response.data['message'] ??
                  'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }
}
