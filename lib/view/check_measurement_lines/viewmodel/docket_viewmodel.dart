import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/check_measurement_lines/model/docket_model.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/spinner_list.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/new_sketch_prop_entity.dart';

class DocketViewmodel extends ChangeNotifier {
  DocketViewmodel({required this.context, required this.sectionID}){
    getCheckMeasureSessions(sectionID);
  }

  final String sectionID;

  // Current View Context
  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  List<DocketEntity> docketList = [];
  String? selectedDocket;

  final Set<int> expandedIndexes = {};

  Future<void> getCheckMeasureSessions(String ss) async {
    // if (!context.mounted) return;
    //
    // ProcessDialogHelper.showProcessDialog(context, message: "Loading...");

    _isLoading = isTrue;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": ss,
    };

    final payload = {
      "path": "/getCheckMeasureSessions",
      "apiVersion": "1.0.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
        .postApiCall(context, Apis.NPDCL_EMP_URL, payload);


    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              if (response.data['objectJson'] != null) {
                List<dynamic> jsonList;
                if (response.data['objectJson'] is String) {
                  jsonList = jsonDecode(response.data['objectJson']);
                } else if (response.data['objectJson'] is List) {
                  jsonList = response.data['objectJson'];
                } else {
                  jsonList = [];
                }
                final List<DocketEntity> objectJson = jsonList.map((json) => DocketEntity.fromJson(json)).toList();
                docketList.addAll(objectJson);
                print("data added in docketList");
                notifyListeners();
              }
            } else {
              showAlertDialog(context, "response.data['message']");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context," response.data['message']");
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, "An error occurred. Please try again.");
      });
      rethrow;
    }finally{
      _isLoading=false;
      notifyListeners();
    }

    notifyListeners();
  }

}


//{"path":"\/getCheckMeasureSessions","apiVersion":"1.0.1","method":"POST","data":"{\"authToken\":\"9BA4C2FF60D1B5D78FA44A4EC4AE24E4\",\"api\":\"d0bbef01-87c6-4629-9659-d95c59c22a9c\",\"ssc\":\"0162-132KV POCHAMPAD\"}"}