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
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrInspectionListViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String type;
  late NpdclUser npdclUser;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<DtrInspectionSheetEntity> _dtrInspectionSheetEntityList = [];
  List<DtrInspectionSheetEntity> get dtrInspectionSheetEntityList => _dtrInspectionSheetEntityList;

  // Filter list
  final List<FilterLabelModelList> filterLabelModelList = [];

  // Constructor to initialize the items
  DtrInspectionListViewmodel({required this.context, required this.type}) {
    _loadUser();
    getDtrInspections();
  }

  void _loadUser() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
  }

  Future<void> getDtrInspections() async {
    _dtrInspectionSheetEntityList.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "type": type
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_INSPECTIONS_URL, payload);
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
              final List<DtrInspectionSheetEntity> dataList = jsonList.map((json) => DtrInspectionSheetEntity.fromJson(json)).toList();
              _dtrInspectionSheetEntityList.addAll(dataList);
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

  void filterFabClicked() {
    if(filterLabelModelList.isNotEmpty) {
      moveToFilterScreen();
    } else {
      getFilterData();
    }
  }

  Future<void> getFilterData() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading available filters...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_INSPECTIONS_FILTER_DATA_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
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
              final List<FilterLabelModelList> dataList = jsonList.map((json) => FilterLabelModelList.fromJson(json)).toList();
              filterLabelModelList.addAll(dataList);
              notifyListeners();
              moveToFilterScreen();
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }
  }

  void moveToFilterScreen() {
    Navigation.instance.navigateTo(Routes.filterScreen, args: jsonEncode(filterLabelModelList),onReturn: (result) {
      if(result != null) {
        getFilteredDtrInspections(result);
      }
    });
  }

  Future<void> getFilteredDtrInspections(dynamic result) async {
    _dtrInspectionSheetEntityList.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "query": jsonEncode(result),
      "type": type
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_FILTERED_DTR_INSPECTIONS_DATA_URL, payload);
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
              final List<DtrInspectionSheetEntity> dataList = jsonList.map((json) => DtrInspectionSheetEntity.fromJson(json)).toList();
              _dtrInspectionSheetEntityList.addAll(dataList);
              notifyListeners();
              if(_dtrInspectionSheetEntityList.isEmpty) {
                showAlertDialog(context,response.data['message']);
              }
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
