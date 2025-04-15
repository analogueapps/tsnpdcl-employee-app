import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/model/maintenance_finished_model.dart';

class MaintenanceFinishedViewmodel extends ChangeNotifier {
  final BuildContext context;
  final List<MaintenanceFinishedModel> _maintenanceItems = [
  ];
  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<MaintenanceFinishedModel> _filteredItems = [];

  List<MaintenanceFinishedModel> get maintenanceItems => _maintenanceItems;

  String _searchQuery = '';

  MaintenanceFinishedViewmodel({required this.context}) {
    getFinishedMaintenanceList();
    _filteredItems = List.from(_maintenanceItems);
    print("Initial items: ${_filteredItems.length}");
    notifyListeners();
  }

  void filterItems(String query) {
    _searchQuery = query.trim().toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredItems = List.from(_maintenanceItems);
    } else {
      _filteredItems = _maintenanceItems.where((item) {
        return (item.maintenanceId?.toString().toLowerCase().contains(_searchQuery) ?? false) ||
            (item.ssName?.toLowerCase().contains(_searchQuery) ?? false) ||
            (item.maintenanceDate?.toIso8601String().toLowerCase().contains(_searchQuery) ?? false);
      }).toList();
    }
    print("Filtered items: ${_filteredItems.length}, Query: $_searchQuery");
    notifyListeners();
  }

  Future<void> getFinishedMaintenanceList() async {
    _isLoading = isTrue;
    notifyListeners();



    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status": "FINISHED",
      "tre":"false"
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_SS_MAINTENANCE, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                final List<MaintenanceFinishedModel> dataList = jsonList.map((json) => MaintenanceFinishedModel.fromJson(json)).toList();
                _maintenanceItems.addAll(dataList);
                notifyListeners();
              }
            }else {
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