import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/dtr_feedet_distribution_model.dart';


class MappedDtrViewmodel extends ChangeNotifier {
  MappedDtrViewmodel({required this.context});

  // Current View Context
  final BuildContext context;


  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<FeederDisModel> _structureData = [];

  List<FeederDisModel> get structureData => _structureData;

  Future<void> getStructureData(String structCode) async {
    _isLoading = true;
    _structureData.clear();
    notifyListeners();



    final requestData = {
      "authToken":
      SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey) ??
          "",
      "api": Apis.API_KEY,
      "structureCode": structCode,
    };

    final payload = {
      "path": "/getDtrsOfStructure",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("load structure response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(
                context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              if (responseData['message'] != null) {
                try {
                  final jsonMessage = responseData['message'];
                  List<FeederDisModel> dataList = [];

                  if (jsonMessage is String) {
                    // Parse the JSON string within message
                    final structureJson = jsonDecode(jsonMessage);
                    dataList.add(FeederDisModel.fromJson(structureJson));
                  } else if (jsonMessage is Map<String, dynamic>) {
                    // If message is already a parsed object
                    dataList.add(FeederDisModel.fromJson(jsonMessage));
                  }

                  _structureData.addAll(dataList);
                  print(
                      "Structure data: ${_structureData.length} items loaded");
                  print(
                      "Structure details: ${_structureData.map((e) =>
                          e.toJson())}");
                  Navigation.instance.navigateTo(
                    Routes.dtrStructure,
                    args: _structureData,
                  );
                } catch (e, stackTrace) {
                  print("Error parsing message: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse structure data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(
                  context, responseData['message'] ?? "Operation failed");
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showErrorDialog(context,
              "Request failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }
}