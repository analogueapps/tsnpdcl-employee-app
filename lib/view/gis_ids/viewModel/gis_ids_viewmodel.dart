import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_ids_model.dart';

class GISIDsViewModel extends ChangeNotifier {
  GISIDsViewModel({required this.context}){
    getGisIDs();
    _filteredGisData = List.from(_gisData); // Initialize filtered data
    _searchController.addListener(_filterGisData); // Listen to search input
  }

  final BuildContext context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Initial GIS data
  List<GisIdsModel> _gisData = [];
  List<GisIdsModel> _filteredGisData = [];
  final TextEditingController _searchController = TextEditingController();

  List<GisIdsModel> get gisData => _filteredGisData.isNotEmpty ? _filteredGisData : _gisData;
  TextEditingController get searchController => _searchController;

  void _filterGisData() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredGisData = List.from(_gisData);
    } else {
      _filteredGisData = _gisData.where((item) {
        return item.gisId.toString().toLowerCase().contains(query) ||
            item.regNum!.toLowerCase().contains(query) ||
            item.workDescription!.toLowerCase().contains(query) ||
            item.empId!.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }


  Future<void> getGisIDs() async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
    };

    final payload = {
      "path": "/getGisIds",
      "apiVersion": "1.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("Meter response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == isTrue) {
            if (responseData['success'] == isTrue) {
              if (responseData['objectJson'] != null) {
                try {
                  final jsonList = responseData['objectJson'];
                  List<GisIdsModel> dataList = [];

                  if (jsonList is String) {
                    String cleanedJsonString = jsonList
                        .replaceAll(r'\"', '"')
                        .replaceAll(r'\u0026', '&')
                        .trim();
                    if (cleanedJsonString.endsWith(',')) {
                      cleanedJsonString = cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                    }
                    if (!cleanedJsonString.startsWith('[')) {
                      cleanedJsonString = '[$cleanedJsonString]';
                    }
                    final parsedList = jsonDecode(cleanedJsonString) as List;
                    dataList = parsedList.map((json) => GisIdsModel.fromJson(json)).toList();
                  } else if (jsonList is List) {
                    dataList = jsonList.map((json) => GisIdsModel.fromJson(json)).toList();
                  }

                  _filteredGisData.clear();
                  _filteredGisData.addAll(dataList);
                  print("Meters data: ${_filteredGisData.length} items loaded here");
                  notifyListeners();
                } catch (e, stackTrace) {
                  print("Error parsing objectJson: $e");
                  print("Stack trace: $stackTrace");
                  showErrorDialog(context, "Failed to parse meter data. Please contact support.");
                }
              }
            } else {
              showAlertDialog(context, responseData['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        }
      }
    } catch (e) {
      print("Exception caught: $e");
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  Future<void> postGisIDtoSAP(int gisID) async {
    _isLoading = true;
    notifyListeners();

    final requestData = {
      "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "api": Apis.API_KEY,
      "gisId":"$gisID"
    };

    final payload = {
      "path": "/post2sapGis",
      "apiVersion": "1.1",
      "method": "POST",
      "data": jsonEncode(requestData),
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      _isLoading = false;
      notifyListeners();

      print("post2sapGis response: $response");
      if (response != null) {
        var responseData = response.data;
        if (responseData is String) {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            print("Error decoding response data: $e");
            showErrorDialog(context, "Invalid response format. Please try again.");
            return;
          }
        }

        if (response.statusCode == successResponseCode) {
          if (responseData['tokenValid'] == true) {
            if (responseData['success'] == true) {
              if (responseData['message'] != null) {
                try {
                  final jsonMessage = responseData['message'];
                  showSuccessDialog(context, jsonMessage,   () {
                    Navigation.instance.pushBack();
                  },);
                  // List<FeederDisModel> dataList = [];
                  //
                  // if (jsonMessage is String) {
                  //   // Parse the JSON string within message
                  //   final structureJson = jsonDecode(jsonMessage);
                  //   dataList.add(FeederDisModel.fromJson(structureJson));
                  // } else if (jsonMessage is Map<String, dynamic>) {
                  //   // If message is already a parsed object
                  //   dataList.add(FeederDisModel.fromJson(jsonMessage));
                  // }
                  //
                  // _structureData.addAll(dataList);
                  // print(
                  //     "Structure data: ${_structureData.length} items loaded");
                  // print(
                  //     "Structure details: ${_structureData.map((e) =>
                  //         e.toJson())}");
                  // Navigation.instance.navigateTo(
                  //   Routes.dtrStructure,
                  //   args: _structureData,
                  // );
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
      _isLoading = false;
      notifyListeners();
      showErrorDialog(context, "An error occurred. Please try again.");
    }
  }



  // Save for offline (placeholder)
  void saveForOffline(String gisId) {
    // Implement offline save logic here (e.g., local storage)
    print('Saving GIS ID: $gisId for offline');
  }

  // Clean up
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}