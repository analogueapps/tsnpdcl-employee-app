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
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';

class NewProposalViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String ssc;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<NewSketchPropEntity> _allProposalList = [];
  List<NewSketchPropEntity> get allProposalList => _allProposalList;

  // Constructor to initialize the items
  NewProposalViewmodel({required this.context, required this.ssc}) {
    allProposalListFromServer();
  }

  Future<void> allProposalListFromServer() async {
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": ssc,
    };

    final payload = {
      "path": "/getNewProposals",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if(response.data['objectJson'] != null) {
                final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
                final List<NewSketchPropEntity> listData = jsonList.map((json) => NewSketchPropEntity.fromJson(json)).toList();
                _allProposalList.addAll(listData);
              }
            } else {
              showAlertDialog(context,response.data['message']);
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
