import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/meeseva/model/days_pending_meeseva_abstract.dart';

class MeeSevaAbstractViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  final Map<String, dynamic> data;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  bool _isLmAbstract = isFalse;
  bool get isLmAbstract => _isLmAbstract;
  List<NpdclUser>? _user;
  List<NpdclUser>? get user => _user;

  DaysPendingMeesevaAbstract? _daysPendingMeesevaAbstract;
  DaysPendingMeesevaAbstract? get daysPendingMeesevaAbstract => _daysPendingMeesevaAbstract;

  Map<String, dynamic> jsonObjects = {};
  List<String> list = [];

  final Map<String, String> shortCuts = {
    "PFC": "PENDING FOR F.C ALLOTMENT BY AE",
    "UFC": "UNDER FEASIBILITY CHECK BY O&M STAFF",
    "LMF": "PENDING FOR FEASIBLE BY AE",
    "LMNF": "PENDING FOR NOT-FEASIBLE BY AE",
    "AENF": "PENDING FOR NOT-FEASIBLE BY ADE",
    "MTI": "METERS TO BE ALLOTTED BY AE",
    "AEF": "METERS TO BE ALLOTTED BY ADE",
    "MIO": "METERS TO BE FIXED BY O&M STAFF",
    "MIN": "METERS INSTALLED TO BE RELEASE BY AE",
    "REL": "RELEASED BY",
    "REJ": "REJECTED LIST",
  };

  Map<String, String> LM_ALLOWED_STATUS = {
    "UFC": "UFC",
    "LMF": "LMF",
    "LMNF": "LMNF",
    "MIO": "A_ALLOT",
    "MIN": "FIXED",
    "REL": "REL",
    "REJ": "REJ",
  };

  Map<String, String> shortCutsToActualStatusCode = {
    "PFC": "VERIFIED",
    "UFC": "F_ALLOT",
    "LMF": "LM_F",
    "LMNF": "LM_NF",
    "AENF": "AE_NF",
    "MTI": "APPROVED",
    "AEF": "AE_F",
    "MIO": "A_ALLOT",
    "MIN": "FIXED",
    "REL": "REL",
    "REJ": "REJ"
  };

  MeeSevaAbstractViewmodel({required this.context, required this.data}) {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    _user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    _isLmAbstract = _user![0].empType == "OM";
    notifyListeners();
    getData();
  }

  Future<void> loadMeesevaAbove5DaysPendingAbstract() async {
    _isLoading = true;
    _daysPendingMeesevaAbstract = null;
    list.clear();
    notifyListeners();
    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "days": data['above'],
    };

    final payload = {
      "path": "/getMeeSevaAbstractAbove5",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              final dynamic jsonObject = response.data['message'];

              // Check if it's a string and decode it
              final decodedObject = jsonObject is String
                  ? jsonDecode(jsonObject)
                  : jsonObject;

              _daysPendingMeesevaAbstract = DaysPendingMeesevaAbstract.fromJson(decodedObject);

              // Convert the JSON string into a Map (like JSONObject in Java)
              jsonObjects = json.decode(response.data['message']);

              // Iterate through the keys of the JSON object
              for (var key in jsonObjects.keys) {
                if (_isLmAbstract) {
                  // Assuming LM_ALLOWED_STATUS is a predefined map to check keys against
                  if (LM_ALLOWED_STATUS.containsKey(key)) {
                    list.add(key);
                  }
                } else {
                  list.add(key);
                }
              }
              print(list);
              notifyListeners();
            } else {
              showAlertDialog(context, response.data['message']);
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

  Future<void> loadMeesevaAbstract() async {
    _isLoading = true;
    _daysPendingMeesevaAbstract = null;
    list.clear();
    notifyListeners();
    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      //"days": days,
    };

    if(data['sc'] != null) {
      requestData['sc'] = data['sc'];
    }

    final payload = {
      "path": "/getMeeSevaAbstract",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
    _isLoading = false;
    notifyListeners();
    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['tokenValid'] == isTrue) {
            if (response.data['success'] == isTrue) {
              final dynamic jsonObject = response.data['message'];

              // Check if it's a string and decode it
              final decodedObject = jsonObject is String
                  ? jsonDecode(jsonObject)
                  : jsonObject;

              _daysPendingMeesevaAbstract = DaysPendingMeesevaAbstract.fromJson(decodedObject);

              // Convert the JSON string into a Map (like JSONObject in Java)
              jsonObjects = json.decode(response.data['message']);

              // Iterate through the keys of the JSON object
              for (var key in jsonObjects.keys) {
                if (_isLmAbstract) {
                  // Assuming LM_ALLOWED_STATUS is a predefined map to check keys against
                  if (LM_ALLOWED_STATUS.containsKey(key)) {
                    list.add(key);
                  }
                } else {
                  list.add(key);
                }
              }
              print(list);
              notifyListeners();
            } else {
              showAlertDialog(context, response.data['message']);
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

  void getData() {
    if(data['above'] != "0") {
      loadMeesevaAbove5DaysPendingAbstract();
    } else {
      loadMeesevaAbstract();
    }
  }

}
