import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/view_detailed_lc_response.dart';

class ViewDetailedLcViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String lcId;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  ViewDetailedLcResponse? _getDetailedLcView;
  ViewDetailedLcResponse? get getDetailedLcView => _getDetailedLcView;

  // Constructor to initialize the items
  ViewDetailedLcViewModel({required this.context, required this.lcId}) {
    getLc();
  }

  Future<void> getLc() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "lcId": lcId,
      "deviceId": await getDeviceId(),
    };

    var response = await ApiProvider(baseUrl: Apis.LC_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_DETAILED_LC_URL, payload);
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
                // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
                List<dynamic> jsonList;

                // If dataList is a String, decode it; otherwise, it's already a List
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList =
                      []; // Fallback to empty list if the type is unexpected
                }
                final List<ViewDetailedLcResponse> dataList = jsonList
                    .map((json) => ViewDetailedLcResponse.fromJson(json))
                    .toList();
                _getDetailedLcView = dataList[0];
                notifyListeners();
              }
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
