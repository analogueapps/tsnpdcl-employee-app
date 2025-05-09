import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/view/schedules/models/ss_data_model.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';

import '../../interruptions/model/substation_model.dart';

class ScheduleLineViewmodel extends ChangeNotifier{
  ScheduleLineViewmodel({required this.context, required this.monthYear}){
    ssInfo(context);
  }

  final BuildContext context;
  final Map<String, dynamic>? monthYear;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DateTime? selectedDate;

  String? selectedSS="Select" ; // Currently selected value
  final List<String> ssOptions = [];

  String ssCode="";
  String ssName="";
  String section="";

  final formKey = GlobalKey<FormState>();

  List<Map<String, String>> selectedFeeders = [];


  String _getMonthNumeric(Map<String, dynamic> selectedMonthYear) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    int monthIndex = monthNames.indexOf(selectedMonthYear['month']);
    return (monthIndex + 1).toString().padLeft(2, '0'); // Converts index to month number with leading zero
  }

  final List<SsDataModel> ssDataList = [];
  Future<void> ssInfo(context) async {
    _isLoading = true;
    notifyListeners();
    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployees"
    };
    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.SS_URL, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                var rawDataList = response.data['dataList'];
                print("Raw dataList: $rawDataList");

                List<dynamic> jsonList;
                if (rawDataList is String) {
                  jsonList = jsonDecode(rawDataList);
                } else if (rawDataList is List) {
                  jsonList = rawDataList;
                } else {
                  print("Unexpected type: ${rawDataList.runtimeType}");
                  jsonList = [];
                }

                final List<SsDataModel> dataList = jsonList.map((json) {
                  return SsDataModel.fromJson(json);
                }).toList();

                ssDataList.addAll(dataList);
                feeders11kv(ssDataList.first.ssCode!);
                if (ssDataList.isNotEmpty) {
                  selectedSS = ssDataList.first.ssName!;
                  ssCode = ssDataList.first.ssCode!;
                  ssName = ssDataList.first.ssName!;
                  section = ssDataList.first.sectionName!;
                  ssOptions.clear();
                  ssOptions.addAll(ssDataList.map((e) => e.ssName!).toList());
                  notifyListeners();
                }
              }
            }else {
                showSessionExpiredDialog(context);
              }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //feders
  final List<SubstationModel> feederList = [];
  Future<void> feeders11kv( String code) async {
    _isLoading = true;
    notifyListeners();
    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployees",
      "ssCode":code
    };
    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.LINE_FEEDERS, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                var rawDataList = response.data['dataList'];
                print("Raw dataList: $rawDataList");

                List<dynamic> jsonList;
                if (rawDataList is String) {
                  jsonList = jsonDecode(rawDataList);
                } else if (rawDataList is List) {
                  jsonList = rawDataList;
                } else {
                  print("Unexpected type: ${rawDataList.runtimeType}");
                  jsonList = [];
                }

                final List<SubstationModel> dataList = jsonList.map((json) {
                  return SubstationModel.fromJson(json);
                }).toList();

                feederList.addAll(dataList);
              }
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> submitForm(BuildContext outerContext) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (!validateForm(outerContext)) {
        return;
      } else {
        print("inelse block");
        scheduleLine(context);
      }
    }
  }

  bool validateForm(BuildContext outerContext) {
    if ( selectedDate == null) {
      showAlertDialog(context, "Please select schedule date of maintenance");
      return false;
    }else if(selectedFeeders==[]){
      showAlertDialog(context, "Please choose 11KV Feeders");
    }
    return true;
  }

  Future<void> scheduleLine(context) async {
    _isLoading = true;
    notifyListeners();
    String feedersPayload = jsonEncode(selectedFeeders);

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployees",
      "ssCode": ssCode,
      "ssName":ssName,
      "scheduledDate":DateFormat('dd/MM/yyyy')
          .format(selectedDate!),
      "scheduledMonth":monthYear != null
          ? '${_getMonthNumeric(monthYear!)}${monthYear!['year']}'
          : DateFormat('MM/yyyy').format(DateTime.now()),
      "voltage":"11KV",
      "feeders":feedersPayload,
    };
    print("ScheduleSs: $payload");
    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.SCHEDULE_LINE, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid']==isTrue){
            if (response.data['taskSuccess'] == isTrue||response.data['taskSuccess'] == isFalse) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      _isLoading = true;
      notifyListeners();
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}