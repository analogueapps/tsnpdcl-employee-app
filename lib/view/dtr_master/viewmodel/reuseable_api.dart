// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
// import 'package:tsnpdcl_employee/network/api_provider.dart';
// import 'package:tsnpdcl_employee/network/api_urls.dart';
// import 'package:tsnpdcl_employee/preference/shared_preference.dart';
// import 'package:tsnpdcl_employee/utils/alerts.dart';
// import 'package:tsnpdcl_employee/utils/app_constants.dart';
// import 'package:tsnpdcl_employee/utils/app_helper.dart';
//
// class ReuseableApi extends ChangeNotifier{
//   ReuseableApi({required this.context})
//   final BuildContext context;
//
//   bool _isLoading = true;
//   bool get isLoading => _isLoading;
//
//   Future<void> getLoaderLoadMetersStock() async {
//     _isLoading = true;
//     notifyListeners();
//
//     final requestData = {
//       "authToken": SharedPreferenceHelper.getStringValue(
//           LoginSdkPrefs.tokenPrefKey),
//       "api": Apis.API_KEY,
//     };
//
//     final payload = {
//       "path": "/load/metersStock",
//       "apiVersion": "1.0",
//       "method": "POST",
//       "data": jsonEncode(requestData), //"data": "{\"authToken\":\"{{TOKEN}}\",\"api\":\"{{API_KEY}}\", \"empId\":\"70000000\"}"
//     };
//
//
//     try {
//       var response = await ApiProvider(baseUrl: Apis.ROOT_URL).postApiCall(
//           context, Apis.NPDCL_EMP_URL, payload);
//
//       _isLoading = false;
//       notifyListeners();
//
//       print("Meter response: $response");
//       if (response != null) {
//         var responseData = response.data;
//         // Ensure response.data is properly parsed
//         if (responseData is String) {
//           try {
//             responseData = jsonDecode(responseData);
//           } catch (e) {
//             print("Error decoding response data: $e");
//             showErrorDialog(
//                 context, "Invalid response format. Please try again.");
//             return;
//           }
//         }
//
//         // Check status code
//         if (response.statusCode == successResponseCode) {
//           if (responseData['tokenValid'] == isTrue) {
//             if (responseData['success'] == isTrue) {
//               if (responseData['objectJson'] != null) {
//                 try {
//                   final jsonList = responseData['objectJson'];
//                   List<MeterStockEntity> dataList = [];
//
//                   if (jsonList is String) {
//                     String cleanedJsonString = jsonList
//                         .replaceAll(r'\"', '"')  // Unescape quotes
//                         .replaceAll(r'\u0026', '&')  // Handle Unicode characters
//                         .trim();
//
//                     // Remove trailing comma if present
//                     if (cleanedJsonString.endsWith(',')) {
//                       cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
//                     }
//
//                     // Ensure the string is properly formatted JSON array
//                     if (!cleanedJsonString.startsWith('[')) {
//                       cleanedJsonString = '[$cleanedJsonString]';
//                     }
//
//                     // Parse the cleaned JSON string
//                     final parsedList = jsonDecode(cleanedJsonString) as List;
//                     dataList = parsedList.map((json) => MeterStockEntity.fromJson(json)).toList();
//                   } else if (jsonList is List) {
//                     dataList = jsonList.map((json) => MeterStockEntity.fromJson(json)).toList();
//                   }
//
//                   _meterStockEntityList.addAll(dataList);
//                   print("Meters data: ${_meterStockEntityList.length} items loaded");
//                   notifyListeners();
//                 } catch (e, stackTrace) {
//                   print("Error parsing objectJson: $e");
//                   print("Stack trace: $stackTrace");
//                   showErrorDialog(context, "Failed to parse meter data. Please contact support.");
//                 }
//               }            }
//           } else {
//             showAlertDialog(context, responseData['message']);
//           }
//         } else {
//           showSessionExpiredDialog(context);
//         }
//       }
//     } catch (e) {
//       print("Exception caught: $e");
//       showErrorDialog(context, "An error occurred. Please try again.");
//     }
//   }
//
// }