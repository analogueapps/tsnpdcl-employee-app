import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';

class DailyNilViewmodel extends ChangeNotifier {
  DailyNilViewmodel({required this.context}) {
    addToOptionList();
  }

  final BuildContext context;

  final bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  List<EroModel> optionList = [];

  Set<String> selectedCheckboxIds = {};
  List<String> selectedCheckboxList = [];

  bool isSelected(String id) => selectedCheckboxIds.contains(id);

  void selectCheckbox(String id) {
    if (selectedCheckboxIds.contains(id)) {
      selectedCheckboxIds.remove(id); // Deselect
    } else {
      selectedCheckboxIds.add(id); // Select
    }
    selectedCheckboxList = selectedCheckboxIds.toList();
    print("Selected IDs: $selectedCheckboxList");
    notifyListeners();
  }

  void addToOptionList() {
    optionList
        .add(EroModel(optionId: "1", optionName: "DTR Failure reporting"));
    optionList.add(EroModel(optionId: "15", optionName: "Check Readings"));
    optionList.add(
        EroModel(optionId: "16", optionName: "Bill stop & UDC inspection"));
    optionList.add(
        EroModel(optionId: "7", optionName: "33KV Feeder Breakdown reporting"));
    optionList.add(
        EroModel(optionId: "8", optionName: "11KV Feeder Breakdown reporting"));
    optionList.add(
        EroModel(optionId: "9", optionName: "Interruptions Entry (33 KV)"));
    optionList.add(
        EroModel(optionId: "10", optionName: "Interruptions Entry (11KV)"));
    optionList.add(EroModel(
        optionId: "13", optionName: "Pole Delivery Monitoring System(PDMS)"));
    optionList.add(EroModel(optionId: "4", optionName: "Mapping of services"));
    optionList.add(EroModel(optionId: "5", optionName: "Tong Tester Readings"));
    optionList.add(EroModel(
        optionId: "14", optionName: "Pole Tracker (Feeder digitalization)"));
    optionList.add(EroModel(optionId: "2", optionName: "DTR Digitalisation"));
    optionList.add(EroModel(optionId: "6", optionName: "SS Maintenance"));
    optionList.add(EroModel(
        optionId: "33",
        optionName: "Inspection of services(RMD exceeded than CMD)"));
    optionList.add(EroModel(
        optionId: "32", optionName: "Inspection of suspected wrong category"));
    optionList.add(EroModel(
        optionId: "34",
        optionName: "Inspection of unpaid II&III category services"));
    optionList.add(EroModel(
        optionId: "35", optionName: "Inspection of Non-KVAH Services"));

    print("optionList now is : $optionList");
  }

  Future<void> submitNil() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Authenticating please wait...",
    );
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "nilData": jsonEncode(selectedCheckboxList),
      "deviceId": await getDeviceId(),
    };

    var response = await ApiProvider(baseUrl: Apis.DAILY_NIL_URL)
        .postApiCall(context, Apis.DAILY_NIL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
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
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }
}
