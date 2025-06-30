import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/dtr_master/model/mis_matched_model.dart';

class MisMatchedViewModel extends ChangeNotifier {
  MisMatchedViewModel({required this.context}) {
    getMisMatched();
  }

  final BuildContext context;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final List<MisMatchedModel> _misMatchedEntity = [];
  List<MisMatchedModel> get misMatchedStockEntityList => _misMatchedEntity;

  Future<void> getMisMatched() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/getMisMatchDtrList",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("MisMatched response: $response");
      if (response != null) {
        var responseData = response.data;
        // Ensure response.data is properly parsed
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

        // Check status code
        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isFalse) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<MisMatchedModel> dataList = [];

                  if (jsonList is String) {
                    // Clean the string JSON format by replacing escaped quotes
                    String cleanedJsonString =
                        jsonList.replaceAll(r'\"', '"').trim();

                    // Ensure it ends with a correct JSON format (either array or object)
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(
                          0, cleanedJsonString.length - 1);
                    }

                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }

                    // Now decode the cleaned string into JSON
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList
                        .map((json) => MisMatchedModel.fromJson(json))
                        .toList();
                  } else if (jsonList is List) {
                    // If the response is already a List, just decode it
                    dataList = jsonList
                        .map((json) => MisMatchedModel.fromJson(json))
                        .toList();
                  } else {
                    throw Exception('Unexpected format for objectJson.');
                  }

                  _misMatchedEntity.addAll(dataList);
                  print(
                      "MisMatcheds data: ${_misMatchedEntity.length} items loaded");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context,
                      "Failed to parse MisMatched data. Please contact support.");
                }
              } else {
                print("objectJson is null");
              }
            } else {
              showAlertDialog(context, responseData['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showSessionExpiredDialog(context);
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }
}
