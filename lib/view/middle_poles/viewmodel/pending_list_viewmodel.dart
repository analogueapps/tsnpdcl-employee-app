import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';

class PendingListViewModel extends ChangeNotifier{
  PendingListViewModel({required this.context, required this.status}) {
    final now = DateTime.now();
    _selectedMonthYear = {
      'month': _getMonthName(now.month),
      'year': now.year,
    };
    fetchData(_selectedMonthYear, status);
  }
  final BuildContext context;
  final String status;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    fetchData(_selectedMonthYear, status);
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

  List<dynamic> _failureReports = [];

  List<dynamic> get failureReports => _failureReports;

  Future<void> fetchData(Map<String, dynamic>? dateMonth,
      String status) async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      'm': dateMonth != null
          ? '${dateMonth['month']}${dateMonth['year']}'
          : DateFormat('MMMyyyy').format(DateTime.now()),
    };

    final payload = {
      "path": status=="p"?"/loadPendingMiddlePoleList":"/loadFinishedMiddlePoleList",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['message'] != "") {
                showErrorDialog(context, responseData['message']);
                if (responseData['objectJson'] != null) {
                  List<
                      dynamic> reportsJson = responseData['objectJson'] is String
                      ? jsonDecode(responseData['objectJson']) as List<dynamic>
                      : responseData['objectJson'] as List<dynamic>;
                  print("data recevied: $reportsJson");

                  // _failureReports = reportsJson.map((reportJson) {
                  //   return FailureReportModel.fromJson(reportJson);
                  // }).toList();
                  notifyListeners();
                } else {
                  _failureReports = []; // Clear list if no data
                  notifyListeners();
                }
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Request failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, responseData['message'] ??
              "Request failed with status ${response.statusCode}");
        }
      } else {
        showAlertDialog(context, "No response received from server");
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred: ${e.toString()}");
    }
  }
}