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
import 'package:tsnpdcl_employee/view/line_clearance/model/induction_points_of_feeder_list.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';

class LcMasterViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String entry;
  final String ssCode;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<LcMasterSsList> _lcMasterSsList = [];
  List<LcMasterSsList> get lcMasterSsList => _lcMasterSsList;

  final List<LcMasterSsList> _lcMasterFeederList = [];
  List<LcMasterSsList> get lcMasterFeederList => _lcMasterFeederList;

  final List<InductionPointsOfFeederList> _inductionPointsOfFeederList = [];
  List<InductionPointsOfFeederList> get inductionPointsOfFeederList => _inductionPointsOfFeederList;

  // Constructor to initialize the items
  LcMasterViewmodel({required this.context, required this.entry, required this.ssCode}) {
    if(entry == "LcMasterSsListScreen") {
      getLcMasterSsList();
    } else if(entry == "LcMasterFeederListScreen") {
      getLcMasterFeederList();
    } else if(entry == "FeederInductionListScreen") {
      getInductionPointsFeederList();
    }
  }

  Future<void> getLcMasterSsList() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_SS_OF_SECTION_URL, payload);
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
                final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
                _lcMasterSsList.addAll(dataList);
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showOkDialog(context, "Alert!", response.data['message'], "OK");
        }
      }
    } catch (e) {
      showOkDialog(context, "Error", "An error occurred. Please try again.", "OK");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> getLcMasterFeederList() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ssCode": ssCode
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_11KV_FEEDER_OF_33KV_SS_URL, payload);
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
                final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
                _lcMasterFeederList.addAll(dataList);
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showOkDialog(context, "Alert!", response.data['message'], "OK");
        }
      }
    } catch (e) {
      showOkDialog(context, "Error", "An error occurred. Please try again.", "OK");
      rethrow;
    }

    notifyListeners();
  }

  Future<void> getInductionPointsFeederList() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "fdrCode": ssCode
    };

    var response = await ApiProvider(baseUrl: Apis.LC_END_POINT_BASE_URL).postApiCall(context, Apis.GET_INDUCTION_POINTS_OF_FEEDER_URL, payload);
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
                final List<InductionPointsOfFeederList> dataList = jsonList.map((json) => InductionPointsOfFeederList.fromJson(json)).toList();
                _inductionPointsOfFeederList.addAll(dataList);
                notifyListeners();
              }
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showOkDialog(context, "Alert!", response.data['message'], "OK");
        }
      }
    } catch (e) {
      showOkDialog(context, "Error", "An error occurred. Please try again.", "OK");
      rethrow;
    }

    notifyListeners();
  }

}
