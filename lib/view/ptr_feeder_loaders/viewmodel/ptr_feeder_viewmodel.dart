
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/lc_master_ss_list.dart';

class PtrFeederViewmodel extends ChangeNotifier {
  final BuildContext context;

  PtrFeederViewmodel({required this.context}){
    loadHours.add("Select");
    loadHours.add("00:00");
    loadHours.add("01:00");
    loadHours.add("02:00");
    loadHours.add("03:00");
    loadHours.add("04:00");
    loadHours.add("05:00");
    loadHours.add("06:00");
    loadHours.add("07:00");
    loadHours.add("08:00");
    loadHours.add("09:00");
    loadHours.add("10:00");
    loadHours.add("11:00");
    loadHours.add("12:00");
    loadHours.add("13:00");
    loadHours.add("14:00");
    loadHours.add("15:00");
    loadHours.add("16:00");
    loadHours.add("17:00");
    loadHours.add("18:00");
    loadHours.add("19:00");
    loadHours.add("20:00");
    loadHours.add("21:00");
    loadHours.add("22:00");
    loadHours.add("23:00");
    getSubstation();
  }


  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  String pickedDate='';
  Future<void> pickDateFromDateTimePicker(BuildContext context) async {
    DateTime? selected= await showDatePicker(
        context: context,
        firstDate: DateTime(1900,01,01),
        lastDate:DateTime.now(),
    );
    pickedDate='${selected?.day}/${selected?.month}/${selected?.year}';
    notifyListeners();
  }


  String? selectedSs;
  final List<LcMasterSsList> _subStationList = [];
  List<LcMasterSsList> get subStationList => _subStationList;

  Future<void> getSubstation() async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_SS_OF_SECTION_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
                List<dynamic> jsonList;

                // If dataList is a String, decode it; otherwise, it's already a List
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
                _subStationList.addAll(dataList);
                notifyListeners();
              }
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

  void updateSs(String? value) {
    selectedSs = value;
    notifyListeners();
  }

  List<String> loadHours = [];
  String? selectedLoadHour;
  void updateLoadHour(String? newHour) {
    selectedLoadHour = newHour;
    notifyListeners();
  }


  Future<void> getPtrFeederSS(String ssCode) async {
    _isLoading = isTrue;
    notifyListeners();

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ssCode":ssCode
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL).postApiCall(context, Apis.GET_SS_OF_SECTION_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if(response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if(response.data['dataList'] != null) {
                // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
                List<dynamic> jsonList;

                // If dataList is a String, decode it; otherwise, it's already a List
                if (response.data['dataList'] is String) {
                  jsonList = jsonDecode(response.data['dataList']);
                } else if (response.data['dataList'] is List) {
                  jsonList = response.data['dataList'];
                } else {
                  jsonList = [];  // Fallback to empty list if the type is unexpected
                }
                final List<LcMasterSsList> dataList = jsonList.map((json) => LcMasterSsList.fromJson(json)).toList();
                _subStationList.addAll(dataList);
                notifyListeners();
              }
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