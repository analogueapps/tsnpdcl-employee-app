import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/reports/model/bar_graph_data.dart';

class ReportsViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final String path;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<BarGraphData> _barGraphData = [];
  List<BarGraphData> get barGraphData => _barGraphData;

  final int currentYear = DateTime.now().year;
  List<String> yearList = [];
  String? selectedYear;

  // Constructor to initialize the items
  ReportsViewmodel({required this.context, required this.path}) {
    yearList = List.generate(
      currentYear - 2017 + 1, // Number of elements
      (index) => (currentYear - index).toString(),
    );
    selectedYear = yearList[0];
    getReports();
  }

  Future<void> getReports() async {
    _barGraphData.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user =
        jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "y": selectedYear,
      "ofc": npdclUser.ofcCode,
    };

    final payload = {
      "path": "/$path",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                final List<dynamic> jsonList =
                    jsonDecode(response.data['objectJson']);
                final List<BarGraphData> listData = jsonList
                    .map((json) => BarGraphData.fromJson(json))
                    .toList();
                _barGraphData.addAll(listData);
              }
            } else {
              showAlertDialog(context, response.data['message']);
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

  void onListYearSelected(String? value) {
    selectedYear = value;
    notifyListeners();
    getReports();
  }
}
