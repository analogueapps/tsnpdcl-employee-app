import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import '../../../utils/app_constants.dart';

class View11kvOpenRestoreDetailsViewmodel extends ChangeNotifier {
  late String substation;
  late String feeder;
  late String breakdownStartTime;
  late int noOfVillagesAffected;
  late int reportId;

  String selectedSupplyPosition = "Not Restored";
  bool isRestored = false;
  String supplyRestoredDate = "";
  bool isLoading = false;

  List<String> breakdownReasons = [
    "GALE AND WIND",
    "TREE FALLEN",
    "VEHICLE HIT",
    "INSULATOR FAILED",
    "OTHERS"
  ];
  String selectedBreakdownReason = "";

  bool showOtherReasonField = false;
  TextEditingController otherReasonController = TextEditingController();
  TextEditingController polesDamagedController = TextEditingController();
  TextEditingController towersDamagedController = TextEditingController();
  TextEditingController conductorDamagedController = TextEditingController();

  View11kvOpenRestoreDetailsViewmodel(Map<String, dynamic> data) {
    substation = data['ssName'];
    feeder = data['feederName'];
    breakdownStartTime = "${data['startDate']}, ${data['startTime']}";
    noOfVillagesAffected = data['noOfVillagesAffected'];
    reportId = data['reportId'];
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    DateTime selectedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (selectedDateTime.isAfter(DateTime.now())) {
      AlertUtils.showSnackBar(
          context, "Future date or time is not allowed.", true);
      return;
    }

    supplyRestoredDate = DateFormat("dd/MM/yyyy HH:mm").format(selectedDateTime);
    notifyListeners();
  }

  void setSupplyPosition(String value) {
    selectedSupplyPosition = value;
    isRestored = value == "Restored";
    notifyListeners();
  }

  void setBreakdownReason(String? value) {
    if (value != null) {
      selectedBreakdownReason = value;
      showOtherReasonField = value == "OTHERS";
      notifyListeners();
    }
  }

  Future<void> submitData(BuildContext context) async {
    // Field Validations
    if (supplyRestoredDate.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select a Restore Date & Time.", true);
      return;
    }
    if (polesDamagedController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter Poles Damaged.", true);
      return;
    }
    if (towersDamagedController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter Towers Damaged.", true);
      return;
    }
    if (conductorDamagedController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter Conductor Damaged.", true);
      return;
    }
    if (selectedBreakdownReason.isEmpty) {
      AlertUtils.showSnackBar(context, "Please select a Breakdown Reason.", true);
      return;
    }
    if (showOtherReasonField && otherReasonController.text.isEmpty) {
      AlertUtils.showSnackBar(context, "Please enter Other Reason.", true);
      return;
    }

    isLoading = true;
    notifyListeners();

    // Splitting date and time
    List<String> dateTimeParts = supplyRestoredDate.split(" ");
    String endDate = dateTimeParts[0]; // Format: dd/MM/yyyy
    String endTime = dateTimeParts[1]; // Format: HH:mm

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "voltage": "11KV",
      "restored": true,
      "endDate": endDate,
      "endTime": endTime,
      "polesDamaged": int.parse(polesDamagedController.text),
      "towersDamaged": int.parse(towersDamagedController.text),
      "conductorDamaged": double.parse(conductorDamagedController.text),
      "breakDownReason": selectedBreakdownReason,
      "otherReason": showOtherReasonField ? otherReasonController.text : "",
      "id": reportId,
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.INTERRUPTIONS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.SAVE_BREAKDOWN_REPORT, payload);

      print("yesssssssssss: $response");
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode &&
            response.data['sessionValid'] == true) {
          if (response.data['taskSuccess'] == true) {
            await AlertUtils.showSnackBar(context, "Report submitted successfully.", false);
            Navigator.of(context).pop();
          } else {
            AlertUtils.showSnackBar(context, response.data['message'] ?? "Submission failed.", true);
          }
        } else {
          AlertUtils.showSnackBar(context, response.data['message'] ?? "API error.", true);
        }
      }
    } catch (e) {
      AlertUtils.showSnackBar(context, "An error occurred: $e", true);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    polesDamagedController.dispose();
    towersDamagedController.dispose();
    conductorDamagedController.dispose();
    otherReasonController.dispose();
    super.dispose();
  }
}
