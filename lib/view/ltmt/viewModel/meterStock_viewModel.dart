import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/ltmt/model/meter_stock_entity.dart';

import '../../../utils/app_constants.dart';

class MeterStockViewmodel extends ChangeNotifier {
  MeterStockViewmodel({required this.context}) {
    getLoaderLoadMetersStock();
  }

  // Current View Context
  final BuildContext context;

  bool _checkBox = isFalse; // Controls Check Box
  bool get isBoxChecked => _checkBox;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<MeterStockEntity> _meterStockEntityList = [];

  List<MeterStockEntity> get meterStockEntityList => _meterStockEntityList;

  Future<void> getLoaderLoadMetersStock() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/load/metersStock",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };


    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
          context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("Meter response: $response");
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
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<MeterStockEntity> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')  // Unescape quotes
                        .replaceAll(r'\u0026', '&')  // Handle Unicode characters
                        .trim();

                    // Remove trailing comma if present
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                    }

                    // Ensure the string is properly formatted JSON array
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }

                    // Parse the cleaned JSON string
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList.map((json) => MeterStockEntity.fromJson(json)).toList();
                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => MeterStockEntity.fromJson(json)).toList();
                  }

                  _meterStockEntityList.addAll(dataList);
                  print("Meters data: ${_meterStockEntityList.length} items loaded");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse meter data. Please contact support.");
                }
              }            }
          } else {
            showAlertDialog(context, responseData['message']);
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


// Future<void> getLoaderLoadMetersStock() async {
  //   _isLoading = isTrue;
  //   notifyListeners();
  //
  //   final requestData = {
  //     "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
  //     "api": Apis.API_KEY,
  //   };
  //
  //   final payload = {
  //     "path": "/load/metersStock",
  //     "apiVersion": "1.0",
  //     "method": "POST",
  //     "data": jsonEncode(requestData),
  //   };
  //
  //   var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(context, Apis.NPDCL_EMP_URL, payload);
  //   _isLoading = isFalse;
  //   print(" meter response $response");
  //   notifyListeners();
  //
  //   try {
  //     if (response != null) {
  //       if (response.data is String) {
  //         response.data = jsonDecode(response.data); // Parse string to JSON
  //       }
  //       if (response.statusCode == successResponseCode) {
  //         if(response.data['tokenValid'] == isTrue) {
  //           if (response.data['success'] == isTrue) {
  //             if(response.data['objectJson'] != null) {
  //               final List<dynamic> jsonList = jsonDecode(response.data['objectJson']);
  //               final List<MeterStockEntity> dataList = jsonList.map((json) => MeterStockEntity.fromJson(json)).toList();
  //               _meterStockEntityList.addAll(dataList);
  //               print("Meters data : $_meterStockEntityList");
  //               notifyListeners();
  //             }
  //           } else {
  //             showAlertDialog(context,response.data['message']);
  //           }
  //         } else {
  //           showSessionExpiredDialog(context);
  //         }
  //       } else {
  //         showAlertDialog(context,response.data['message']);
  //       }
  //     }
  //   } catch (e) {
  //     showErrorDialog(context,  "An error occurred. Please try again.");
  //     rethrow;
  //   }
  //
  //   notifyListeners();
  // }