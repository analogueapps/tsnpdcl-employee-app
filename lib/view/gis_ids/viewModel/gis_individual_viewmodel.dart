import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/gis_ids/database/pending_offline_list_db.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';

class GisIndividualIdViewModel extends ChangeNotifier {
  GisIndividualIdViewModel({required this.context, required this.gisID}) {
    getGisIDs();
  }

  final int? gisID;
  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<GisSurveyData> _gisData = [];
  List<GisSurveyData> get gisData => _gisData;

  Future<void> getGisIDs() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "m": "$gisID",
      "gis": "true"
    };

    final payload = {
      "path": "/loadPendingMaintenanceList",
      "apiVersion": "1.0",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("GIS response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(context, "Invalid data. Please try again.");
            return;
          }
        }

        if (responseData is Map<String, dynamic>) {
          const int successResponseCode =
              200; // Replace with your actual success code
          const bool isTrue = true; // Define isTrue if not already defined

          if (response.statusCode == successResponseCode) {
            if (responseData['tokenValid'] == isTrue ||
                responseData['tokenValid'] == isFalse) {
              if (responseData['success'] == isTrue) {
                if (responseData['objectJson'] != null) {
                  try {
                    final jsonList = responseData['objectJson'];
                    List<GisSurveyData> dataList = [];

                    if (jsonList is String) {
                      String cleanedJsonString = jsonList
                          .replaceAll(r'\"', '"')
                          .replaceAll(r'\u0026', '&')
                          .trim();
                      if (cleanedJsonString.endsWith(',')) {
                        cleanedJsonString = cleanedJsonString.substring(
                            0, cleanedJsonString.length - 1);
                      }
                      if (!cleanedJsonString.startsWith('[')) {
                        cleanedJsonString = '[$cleanedJsonString]';
                      }
                      final parsedList = jsonDecode(cleanedJsonString) as List;
                      dataList = parsedList
                          .map((json) => GisSurveyData.fromJson(json))
                          .toList();
                    } else if (jsonList is List) {
                      dataList = jsonList
                          .map((json) => GisSurveyData.fromJson(json))
                          .toList();
                    }

                    _gisData.clear();
                    _gisData.addAll(dataList);
                    print("GIS data: ${_gisData.length} items loaded here");
                    notifyListeners();
                  } catch (e, stackTrace) {
                    print("Error parsing objectJson: $e");
                    print("Stack trace: $stackTrace");
                    showErrorDialog(context,
                        "Failed to parse GIS data. Please contact support.");
                  }
                } else {
                  print("No objectJson found in response");
                  showAlertDialog(context, "No GIS data available.");
                }
              } else {
                showAlertDialog(
                    context, responseData['message'] ?? "Operation failed");
              }
            } else {
              showSessionExpiredDialog(context);
            }
          } else {
            showErrorDialog(
                context, "Request failed with status: ${response.statusCode}");
          }
        } else {
          showErrorDialog(context, "Unexpected response format.");
        }
      } else {
        showErrorDialog(context, "No response received from server.");
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  //save for offline
  Future<void> saveForOffline(int regNum) async {
    try {
      final data = gisData.firstWhere((item) => item.gisId == regNum);
      await DatabaseHelper.instance.insertGisSurveyData(data);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('GIS ID $regNum saved offline')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save GIS ID $regNum: $e')),
      );
    }
  }
}
