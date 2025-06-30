import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/gruha_jyothi/model/gruha_jyothi_status.dart';

class GruhaJyothiViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  TextEditingController uscNoController = TextEditingController();
  TextEditingController rationNoController = TextEditingController();

  // GruhaJyothiStatus model
  GruhaJyothiStatus? gruhaJyothiStatus;

  GruhaJyothiViewModel({required this.context});

  bool validateInputs() {
    String uscNo = uscNoController.text.trim();
    String rationNo = rationNoController.text.trim();

    if (uscNo.isNotEmpty && rationNo.isNotEmpty) {
      showAlertDialog(context, "Please provide only USCNO or RATION NO");
      return false;
    } else if (uscNo.isEmpty && rationNo.isEmpty) {
      showAlertDialog(context, "Please provide USCNO or RATION NO");
      return false;
    } else if (uscNo.isNotEmpty && uscNo.length < 8) {
      showAlertDialog(context, "Please enter valid USCNO");
      return false;
    } else if (rationNo.isNotEmpty && rationNo.length < 12) {
      showAlertDialog(context, "Please enter valid RATION NO");
      return false;
    }

    return true;
  }

  clearDetails() {
    formKey.currentState!.reset();
    uscNoController.clear();
    rationNoController.clear();
    gruhaJyothiStatus = null;
    notifyListeners();
  }

  Future<void> fetchDetails() async {
    if (validateInputs()) {
      formKey.currentState!.save();
      notifyListeners();

      ProcessDialogHelper.showProcessDialog(
        context,
        message: "Loading...",
      );

      final requestData = {
        "authToken":
            SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "input": uscNoController.text.isNotEmpty
            ? uscNoController.text.trim()
            : rationNoController.text.trim(),
        "flag": uscNoController.text.isNotEmpty ? "U" : "R",
      };

      final payload = {
        "path": "/getGjStatus",
        "apiVersion": "1.0",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
      if (context.mounted) {
        ProcessDialogHelper.closeDialog(context);
      }

      try {
        if (response != null) {
          if (response.data is String) {
            response.data = jsonDecode(response.data); // Parse string to JSON
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['tokenValid'] == isTrue) {
              if (response.data['success'] == isTrue) {
                if (response.data['message'] != null) {
                  final jsonObject = jsonDecode(response.data['message']);
                  final statusData = GruhaJyothiStatus.fromJson(jsonObject);
                  gruhaJyothiStatus = statusData;
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
}
