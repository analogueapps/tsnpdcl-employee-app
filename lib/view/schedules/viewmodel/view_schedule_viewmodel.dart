import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/schedules/models/view_schedule_model.dart';

class ViewScheduleViewmodel extends ChangeNotifier {
  ViewScheduleViewmodel({required this.context, required this.selectedDate, required this.type}) {
    // schedulesList(selectedDate, type);
    print(" Date and type $selectedDate, $type");
  }

  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  final DateTime selectedDate;
  final String type;

final List<ViewScheduleModel> _scheduleItems = [];
List<ViewScheduleModel> get scheduleItems => _scheduleItems;
  Future<void> schedulesList(DateTime date, String type ) async {
    _isLoading = isTrue;
    notifyListeners();


    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "date":"10/03/2025",
      "type":"DTR"
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.VIEW_SCHEDULE, payload);

    _isLoading = isFalse;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                List<dynamic> jsonList;
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];
                }
                final List<ViewScheduleModel> dataList = jsonList.map((json) => ViewScheduleModel.fromJson(json)).toList();
                _scheduleItems.addAll(dataList);
                notifyListeners();
              } else {
                showSuccessDialog(
                    context, response.data['message'] ?? 'Success', () {
                  Navigator.pop(context);
                });
                print("dtr_failure_reports: ${response.data['dataList']}");
              }
            } else {
              showErrorDialog(
                  context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message'] ??
              'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}