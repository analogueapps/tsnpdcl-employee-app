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
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/all_lc_request_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/induction_points_of_feeder_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';

class CreatePoleIndentsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<PoleRequestIndentEntity> _createPoleIndentList = [];
  List<PoleRequestIndentEntity> get createPoleIndentList => _createPoleIndentList;

  // Constructor to initialize the items
  CreatePoleIndentsViewmodel({required this.context}) {
    allPoleIndentListFromServer();
  }

  Future<void> allPoleIndentListFromServer() async {
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "circleId": npdclUser.secMasterEntity!.circleId
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_INDENTS_OF_STATUS_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
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
                final List<PoleRequestIndentEntity> dataList = jsonList.map((json) => PoleRequestIndentEntity.fromJson(json)).toList();
                _createPoleIndentList.addAll(dataList);
                notifyListeners();
              }
            }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
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
