import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/overload_dtr_list_model.dart';

class OverloadDtrListViewmodel extends ChangeNotifier {
  OverloadDtrListViewmodel({required this.context}) {
    getOverloadList(
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.sectionCodePrefKey),
        "20f");
  }

  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<OverloadDtrListModel> _overLoadItems = [];
  List<OverloadDtrListModel> get overLoadItems => _overLoadItems;

  Future<void> getOverloadList(String officeCode, String iNCurrent) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "officeCode": officeCode,
      "iNCurrent": iNCurrent
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_TONG_TEST_READINGS, payload);

    _isLoading = isFalse;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                final List<OverloadDtrListModel> dataList = jsonList
                    .map((json) => OverloadDtrListModel.fromJson(json))
                    .toList();
                _overLoadItems.addAll(dataList);
                notifyListeners();
              } else {
                showSuccessDialog(
                    context, response.data['message'] ?? 'Success', () {
                  Navigator.pop(context);
                });
                print("dtr_failure_reports: ${response.data['dataList']}");
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
