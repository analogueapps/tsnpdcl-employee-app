import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class NameAndAddressChangeListViewmodel extends ChangeNotifier {
  NameAndAddressChangeListViewmodel({required this.context, required this.status}){
    final now = DateTime.now();
    _selectedMonthYear = {
      'month': _getMonthName(now.month),
      'year': now.year,
    };
    getNameAndAddressCorrectionRequests(_selectedMonthYear);
  }

  final BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final String status;

  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    getNameAndAddressCorrectionRequests(_selectedMonthYear);
    print("selectedMonthYear: $selectedMonthYear");
    notifyListeners();
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  Future<void> getNameAndAddressCorrectionRequests(Map<String, dynamic>? dateMonth)async{
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "monthYear":dateMonth != null
    ? '${dateMonth['month']}${dateMonth['year']}'
        : DateFormat('MMMyyyy').format(DateTime.now()),
      "status":status
    };

    var response = await ApiProvider(baseUrl: Apis.ERO_CORRESPONDENCE_URL)
        .postApiCall(context, Apis.NAME_AND_ADDRESS_CORRECTION_REQUEST, payload);
    _isLoading = false;
    notifyListeners();
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
               if (response.data['dataList'] is List||response.data['dataList'] ==null ) {
                  // jsonList = response.data['dataList'];
                  showAlertDialog(context, response.data['message']);
                // else {
                //   jsonList = [];
                // }

                // final List<ConsumerUscnoModel> dataList =
                // jsonList.map((json) => ConsumerUscnoModel.fromJson(json)).toList();
                //
                // _consumerUSCNOData.addAll(dataList);
                // storeConsumerDetails();
                // notifyListeners();
                // print("data is there in getConsumerWithUscNo");
              }else{
                showAlertDialog(context, response.data['message']);
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
  }

}