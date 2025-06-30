import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dlist/model/dlist_meta_data.dart';
import 'package:tsnpdcl_employee/widget/month_year_selector.dart';

class DlistMenuViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  String currentMonthYear = getCurrentMonthYear();

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  List<DlistMetaData> _dlistMetaData = [];

  List<DlistMetaData> get dlistMetaData => _dlistMetaData;

  // Constructor to initialize the items
  DlistMenuViewmodel({required this.context}) {
    dlistMetaDataListFromServer(getCurrentMonthYear());
  }

  Future<void> dlistMetaDataListFromServer(String currentMonthYear) async {
    _dlistMetaData.clear();
    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "my": currentMonthYear,
    };

    final payload = {
      "path": "/getRangeDlistGraph",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = isFalse;

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
                final List<DlistMetaData> listData = jsonList
                    .map((json) => DlistMetaData.fromJson(json))
                    .toList();
                _dlistMetaData = listData;
                notifyListeners();
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

  Future<void> monthYearClicked() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MonthYearSelector(),
      ),
    );
    if (result != null && result is Map) {
      String month = result['month']!;
      String year = result['year'].toString().substring(2); // Get last 2 digits
      currentMonthYear = '$month$year';
      dlistMetaDataListFromServer(currentMonthYear);
      notifyListeners();
    }
  }
}

String getCurrentMonthYear() {
  final now = DateTime.now();
  final formatter = DateFormat('MMMyy'); // Example: Apr25
  return formatter.format(now);
}
