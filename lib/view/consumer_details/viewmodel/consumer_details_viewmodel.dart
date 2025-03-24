import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/consumer_details/model/dlist_form_response.dart';

class ConsumerDetailsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLTServiceSelected = isFalse;
  bool _isHTServiceSelected = isFalse;

  bool get isLTServiceSelected => _isLTServiceSelected;
  bool get isHTServiceSelected => _isHTServiceSelected;

  // Form Keys
  final formKey = GlobalKey<FormState>();
  final TextEditingController uscNoController = TextEditingController();

  DlistFormResponse? dlistFormResponse;

  ConsumerDetailsViewmodel({required this.context});

  void selectLTService() {
    _isLTServiceSelected = isTrue;
    _isHTServiceSelected = isFalse;
    notifyListeners();
  }

  void selectHTService() {
    _isHTServiceSelected = isTrue;
    _isLTServiceSelected = isFalse;
    notifyListeners();
  }

  Future<void> fetchDetails() async {
    if(_isLTServiceSelected || _isHTServiceSelected) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        notifyListeners();

        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading...",
        );

        final requestData = {
          "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
          "api": Apis.API_KEY,
          "sc": uscNoController.text.trim(),
          "lt": _isLTServiceSelected,
        };

        final payload = {
          "path": "/getLTServiceDList",
          "apiVersion": "1.1",
          "method": "POST",
          "data": jsonEncode(requestData),
        };

        var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
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
                  if (response.data['objectJson'] != null) {
                    final List<dynamic> jsonList = jsonDecode(
                        response.data['objectJson']);
                    final List<DlistFormResponse> listData = jsonList.map((
                        json) => DlistFormResponse.fromJson(json)).toList();
                    dlistFormResponse = listData[0];
                    Navigation.instance.navigateTo(Routes.dListFormScreen,
                        args: jsonEncode(dlistFormResponse));
                    notifyListeners();
                  }
                } else {
                  showAlertDialog(context, response.data['message']);
                }
              } else {
                showSessionExpiredDialog(context);
              }
            } else {
              showAlertDialog(context,response.data['message']);
            }
          }
        } catch (e) {
          showErrorDialog(context,  "An error occurred. Please try again.");
          rethrow;
        }

        notifyListeners();
      } else {
        showAlertDialog(context, "Enter unique service number");
      }
    } else {
      showAlertDialog(context, "Please check the type of service");
    }
  }
}
