
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/database/save_offline_feeder.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';

class ViewOfflineFeedersViewmodel extends ChangeNotifier {
  ViewOfflineFeedersViewmodel({required this.context});

  final BuildContext context;

  bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  List<OffLineFeeder> trackerOfflineFeeder = [];

  Future<List<OffLineFeeder>> fetchFeeders() async {
    trackerOfflineFeeder =
    await OFDatabaseHelper.instance.getAllOfflineFeeders();
    print("Database feeder data: $trackerOfflineFeeder");
    return await OFDatabaseHelper.instance.getAllOfflineFeeders();
  }

  List<DigitalFeederEntity> dBPoleData = [];

  void OfflinePole(String voltage, String feederCode, String feederName,
      String ssCode, String ssName) {
    dBPoleData = trackerOfflineFeeder[0].poleList;
    if (voltage == "33KV") {

    } else {
      var arguments = {
        "p": false,
        "fn": feederName,
        "ssc": ssCode,
        "ssn": ssName,
        "fc": feederCode,
      };
    }
  }

Future<void> uploadOfflinePoles(
    List<DigitalFeederEntity> digitalFeederOfflineEntities) async {
  _isLoading = isTrue;
  notifyListeners();

  for (var dfe in digitalFeederOfflineEntities) {
    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "ssc": dfe.ssCode,
      "fc": dfe.ssCode,
      "ssv": dfe.ssVolt,
      "not": false,
      "origin": dfe.sourceType != null && dfe.sourceType == "SS",
      "tap": "s",
      "pt": dfe.poleType,
      "ph": dfe.poleHeight,
      "nockt": dfe.noOfCkts,
      "formation": dfe.formation,
      "typeOfPoint": dfe.typeOfPoint,
      "polenum": dfe.poleNum,
      "crossingText": dfe.crossing,
      "connLoad": "N",
      "cs": dfe.condSize,
      "lat": dfe.lat,
      "lon": dfe.lon,
    };

    if (dfe.feederVolt == "33KV") {
      final payload = {
        "path": "/saveDigitalFeederPoleForExistingFeeder",
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
            response.data = jsonDecode(response.data);
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['tokenValid'] == isTrue) {

            } else {
              showSessionExpiredDialog(context);
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        }
      } catch (e) {
        showErrorDialog(context, "$e");
        print(" error msg is : $e");
        rethrow;
      }
      notifyListeners();
    } else {
      final payload = {
        "path": "/save11KvDigitalFeederPoleForExistingFeeder",
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
            response.data = jsonDecode(response.data);
          }
          if (response.statusCode == successResponseCode) {
            if (response.data['tokenValid'] == isTrue) {
              if (response.data['success'] == isTrue) {
                if (response.data['objectJson'] != null) {

                }
              }
            } else {
              showSessionExpiredDialog(context);
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        }
      } catch (e) {
        showErrorDialog(context, "$e");
        print(" error msg is : $e");
        rethrow;
      }
      notifyListeners();
    }
  }
}
}
