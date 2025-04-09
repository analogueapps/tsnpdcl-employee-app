import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/model/failure_report.dart';

class FailureReportedListViewModel extends ChangeNotifier {
  FailureReportedListViewModel({required this.context}){
    fetchCtPtReports();
  }
  final BuildContext context;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _selectedMonthYear;

  Map<String, dynamic>? get selectedMonthYear => _selectedMonthYear;

  void setSelectedMonthYear(String month, int year, BuildContext context) {
    _selectedMonthYear = {
      'month': month,
      'year': year,
    };
    notifyListeners();
  }
  List<FailureReportModel> _failureReports = [];
  List<FailureReportModel> get failureReports => _failureReports;


  Future<void> fetchCtPtReports() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      'm': selectedMonthYear ?? DateFormat('MMMyyyy').format(DateTime.now()),
      's': "",
    };

    final payload = {
      "path": "/getCtPtReports",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("Meter response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<FailureReportModel> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')
                        .replaceAll(r'\u0026', '&')
                        .trim();
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                    }
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList.map((json) => FailureReportModel.fromJson(json)).toList();
                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => FailureReportModel.fromJson(json)).toList();
                  }

                  _failureReports.clear();
                  _failureReports.addAll(dataList);
                  print("Meters data: ${_failureReports.length} items loaded here");
                  if(_failureReports.isEmpty){
                    showErrorDialog(context,  "No data found");
                  }
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse meter data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(context, responseData['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }


  void navigateToIndividualReport() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const IndividualFailureReport()),
    // );
    Navigation.instance.navigateTo( Routes.failureIndividual);
  }
}

class FailureReport {
  final String regNo;
  final String village;
  final String scNo;
  final String date;
  final String status;

  FailureReport({
    required this.regNo,
    required this.village,
    required this.scNo,
    required this.date,
    required this.status,
  });
}