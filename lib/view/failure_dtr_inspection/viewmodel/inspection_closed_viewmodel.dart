import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class InspectionClosedViewmodel extends ChangeNotifier{
  InspectionClosedViewmodel( {required this.context, required this.fileStatus}) {
    getDtrFailureReports(fileStatus);
  }

  final BuildContext context;
  final String fileStatus;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  void _filterGisData() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      // _filteredGisData = List.from(_gisData);
      print("dtr failure reports query is empty");
    } else {
      // _filteredGisData = _gisData.where((item) {
      //   return item.gisId.toString().toLowerCase().contains(query) ||
      //       item.regNum!.toLowerCase().contains(query) ||
      //       item.workDescription!.toLowerCase().contains(query) ||
      //       item.empId!.toLowerCase().contains(query);
      // }).toList();
      print("dtr failure reports query is not empty");
    }
    notifyListeners();
  }


  Future<void> getDtrFailureReports(String status) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status": status,
      "sapFailures": "true"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_REPORTS_FR, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == true) {
            if (response.data['taskSuccess'] == true) {
              if (response.data['message'] != null && (response.data['dataList'] == null || response.data['dataList'].isEmpty)) {
                showErrorDialog(context, response.data['message']);
              } else {
                showSuccessDialog(context, response.data['message'] ?? 'Success', () {
                  Navigator.pop(context);
                });
                print("dtr_failure_reports: ${response.data['dataList']}");
              }
            } else {

              showErrorDialog(context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message'] ?? 'Request failed with status: ${response.statusCode}');
        }      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

}