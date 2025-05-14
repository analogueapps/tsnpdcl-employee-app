import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart' show DialogTextField, showTextInputDialog;
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class SectionViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<NpdclUser>? _user;
  List<NpdclUser>? get user => _user;

  List<OptionList> _sectionList = [];
  List<OptionList> get sectionList => _sectionList;

  // Constructor to initialize the items
  SectionViewmodel({required this.context}) {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    _user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    getSections();
  }

  Future<void> getSections() async {
    _isLoading = true;
    _sectionList.clear();
    notifyListeners();
    final requestData = {
      "sdc": _user![0].sectionCode,
    };

    final payload = {
      "path": "/loadSections",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<OptionList> dataList = jsonList.map((json) => OptionList.fromJson(json)).toList();
                _sectionList = dataList;
                notifyListeners();
              } else {
                showAlertDialog(context, response.data['message']);
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
  }

  Future<void> sectionListClicked(OptionList sectionList) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Enter Np. Of Days',
      message: 'Enter no. of days from date of registration/repayment Enter zero (0) to get regular abstract',
      okLabel: 'LOAD ABSTRACT',
      cancelLabel: 'CANCEL',
      isDestructiveAction: true,
      barrierDismissible: false,
      textFields: [
        const DialogTextField(
          keyboardType: TextInputType.number,
          initialText: "0",
        ),
      ],
    );

    if (result != null &&
        result[0] != null &&
        result[0] is String) {
      // Get the service number from the dialog result
      String serviceNumber = result[0];

      var argument = {
        "above": serviceNumber,
        "sc": sectionList.optionId,
      };

      Navigation.instance.navigateTo(
          Routes.meeSevaAbstractScreen, args: argument);
    }
  }

}
