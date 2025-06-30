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
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_dumped_location_entity.dart';

class ViewPoleDumpedLocationViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String status;
  late NpdclUser npdclUser;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<PoleDumpedLocationEntity> _poleDumpedLocationEntityList = [];
  List<PoleDumpedLocationEntity> get poleDumpedLocationEntityList =>
      _poleDumpedLocationEntityList;

  // Filter list
  final List<FilterLabelModelList> filterLabelModelList = [];

  // Constructor to initialize the items
  ViewPoleDumpedLocationViewmodel(
      {required this.context, required this.status}) {
    _loadUser();
    getDumpLocationsWithStatus();
  }

  void _loadUser() {
    String? prefJson =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user =
        jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
  }

  Future<void> getDumpLocationsWithStatus() async {
    _poleDumpedLocationEntityList.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user =
        jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "circleId": npdclUser.secMasterEntity!.circleId,
      "status": status.toUpperCase()
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_POLE_DUMPED_LOCATION_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
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
              final List<PoleDumpedLocationEntity> dataList = jsonList
                  .map((json) => PoleDumpedLocationEntity.fromJson(json))
                  .toList();
              _poleDumpedLocationEntityList.addAll(dataList);
              notifyListeners();
            }
          }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
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

  void filterFabClicked() {
    if (filterLabelModelList.isNotEmpty) {
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
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "circleId": npdclUser.secMasterEntity!.circleId
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_INDENTS_FILTER_DATA_URL, payload);
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
              final List<FilterLabelModelList> dataList = jsonList
                  .map((json) => FilterLabelModelList.fromJson(json))
                  .toList();
              filterLabelModelList.addAll(dataList);
              notifyListeners();
              moveToFilterScreen();
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

  void moveToFilterScreen() {
    Navigation.instance.navigateTo(Routes.filterScreen,
        args: jsonEncode(filterLabelModelList), onReturn: (result) {
      if (result != null) {
        //getDisWithFilter(result);
      }
    });
  }

  // Future<void> getDisWithFilter(dynamic result) async {
  //   _poleDispatchInstructionList.clear();
  //   _isLoading = isTrue;
  //   notifyListeners();
  //
  //   String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
  //   final List<dynamic> jsonList = jsonDecode(prefJson);
  //   final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
  //   NpdclUser npdclUser = user[0];
  //
  //   final payload = {
  //     "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
  //     "appId": "in.tsnpdcl.npdclemployee",
  //     "query": jsonEncode(result),
  //     "circleId": npdclUser.secMasterEntity!.circleId
  //   };
  //
  //   var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_FILTERED_DIS_DATA_URL, payload);
  //   _isLoading = isFalse;
  //
  //   try {
  //     if (response != null) {
  //       if (response.data is String) {
  //         response.data = jsonDecode(response.data); // Parse string to JSON
  //       }
  //       if (response.statusCode == successResponseCode) {
  //         //if(response.data['sessionValid'] == isTrue) {
  //         if (response.data['taskSuccess'] == isTrue) {
  //           if(response.data['dataList'] != null) {
  //             // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
  //             List<dynamic> jsonList;
  //
  //             // If dataList is a String, decode it; otherwise, it's already a List
  //             if (response.data['dataList'] is String) {
  //               jsonList = jsonDecode(response.data['dataList']);
  //             } else if (response.data['dataList'] is List) {
  //               jsonList = response.data['dataList'];
  //             } else {
  //               jsonList = [];  // Fallback to empty list if the type is unexpected
  //             }
  //             final List<PoleDispatchInstructionsEntity> dataList = jsonList.map((json) => PoleDispatchInstructionsEntity.fromJson(json)).toList();
  //             _poleDispatchInstructionList.addAll(dataList);
  //             notifyListeners();
  //             if(_poleDispatchInstructionList.isEmpty) {
  //               showAlertDialog(context,response.data['message']);
  //             }
  //           }
  //         }
  //         // } else {
  //         //   showSessionExpiredDialog(context);
  //         // }
  //       } else {
  //         showAlertDialog(context,response.data['message']);
  //       }
  //     }
  //   } catch (e) {
  //     showErrorDialog(context,  "An error occurred. Please try again.");
  //     rethrow;
  //   }
  //
  //   notifyListeners();
  // }
}
