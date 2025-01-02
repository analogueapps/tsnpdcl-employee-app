import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/all_lc_request_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/induction_points_of_feeder_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';

class AllLcRequestListViewModel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String status;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<AllLcRequestList> _allLcRequestList = [];
  List<AllLcRequestList> get allLcRequestList => _allLcRequestList;

  // Constructor to initialize the items
  AllLcRequestListViewModel({required this.context, required this.status}) {
    allLcRequestListFromServer();
  }

  Future<void> allLcRequestListFromServer() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status": status,
      "deviceId": await getDeviceId(),
    };

    var response = await ApiProvider(baseUrl: Apis.LC_END_POINT_BASE_URL).postApiCall(context, Apis.GET_ALL_LC_REQUEST_LIST_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
                List<dynamic> jsonList;

                // If dataList is a String, decode it; otherwise, it's already a List
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                final List<AllLcRequestList> dataList = jsonList.map((json) => AllLcRequestList.fromJson(json)).toList();
                _allLcRequestList.addAll(dataList);
                notifyListeners();
              }
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

}
