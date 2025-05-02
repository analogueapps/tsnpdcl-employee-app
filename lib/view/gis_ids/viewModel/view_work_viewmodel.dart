import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';

class WorkDetailsViewModel extends ChangeNotifier {
  WorkDetailsViewModel({required this.context, required this.surId, required this.individualStatus}){
    init();
  }

  final BuildContext context;
  final int surId;
  final String individualStatus;
  bool isLocationGranted = false;
  String? _latitude;
  String? _longitude;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void init(){
    getCurrentLocation();
    print("individualStatus $individualStatus");
    getData();
  }


  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AlertUtils.showSnackBar(context, "Location permission denied", isTrue);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AlertUtils.showSnackBar(
            context, "Location permissions are permanently denied", isTrue);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      isLocationGranted = true;

      print("Geo Current location: $_latitude , $_longitude");

      notifyListeners();
    } catch (e) {
      print("Error fetching location: $e");
      AlertUtils.showSnackBar(context, "Error fetching location", isTrue);
    }
  }


  // Static data
  final List<Map<String, String>> data = [
    {'label': 'Work Description', 'value': 'After Work T230102010101003 Alternate supply @ Captain'},
    {'label': 'Status', 'value': 'PENDING'},
    {'label': 'Substation Code', 'value': ''},
    {'label': '11kV Feeder Name', 'value': '0007-09-11kV ADVOCATESCOLONY'},
    {'label': 'DTR SS No', 'value': ''},
    {'label': 'Pole Type', 'value': 'LOOSE LINE STRINGING'},
    {'label': 'Sanction No.', 'value': '-'},
    {'label': 'Now Proposed Latitude', 'value': '18.0054961'},
  ];


  List<GisSurveyData> _workDetails = [];
  List<GisSurveyData> get workDetails => _workDetails;

  Future<void> getData() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ProcessDialogHelper.showProcessDialog(
          context,
          message: "Loading available data...",
        );
      }
    });

    try {
      final requestData = {
        "authToken": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
        "api": Apis.API_KEY,
        "_id": surId
      };

      final payload = {
        "path": individualStatus == "PENDING"
            ? "/loadMaintenanceReadOnlyPendingForm"
            : "/loadMaintenanceReadOnlyFinishedForm",
        "apiVersion": "1.1",
        "method": "POST",
        "data": jsonEncode(requestData),
      };

      var response = await ApiProvider(baseUrl: Apis.ROOT_URL)
          .postApiCall(context, Apis.NPDCL_EMP_URL, payload);

      print("View Work Details response: $response");
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
          const int successResponseCode = 200;
          const bool isTrue = true;

          if (response.statusCode == successResponseCode) {
            if (responseData['tokenValid'] == isTrue || responseData['tokenValid'] == false) {
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
                        cleanedJsonString =
                            cleanedJsonString.substring(0, cleanedJsonString.length - 1);
                      }
                      if (!cleanedJsonString.startsWith('[')) {
                        cleanedJsonString = '[$cleanedJsonString]';
                      }
                      final parsedList = jsonDecode(cleanedJsonString) as List;
                      dataList = parsedList.map((json) => GisSurveyData.fromJson(json)).toList();
                    } else if (jsonList is List) {
                      dataList = jsonList.map((json) => GisSurveyData.fromJson(json)).toList();
                    }

                    _workDetails.clear();
                    _workDetails.addAll(dataList);
                    print("$_workDetails:workDetails");
                    notifyListeners();
                  } catch (e, stackTrace) {
                    print("Error parsing objectJson: $e");
                    print("Stack trace: $stackTrace");
                    showErrorDialog(context, "Failed to parse GIS data. Please contact support.");
                  }
                } else {
                  print("No objectJson found in response");
                  showAlertDialog(context, "No GIS data available.");
                }
              } else {
                showAlertDialog(context, responseData['message'] ?? "Operation failed");
              }
            } else {
              showSessionExpiredDialog(context);
            }
          } else {
            showErrorDialog(context, "Request failed with status: ${response.statusCode}");
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
    } finally {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ProcessDialogHelper.closeDialog(context);
        }
      });
    }
  }



  // Action handlers
  void close(BuildContext context) {
    Navigator.pop(context);
  }

  void openFolder() {
    print("Folder action triggered");
    // Implement folder logic here
  }

  void edit() {
    print("Edit action triggered");
    // Implement edit logic here
  }


}

//Build Request:: {"path":"\/loadMaintenanceReadOnlyPendingForm","apiVersion":"1.1","method":"POST","data":"{\"authToken\":\"D105ACE3F88684F6F625C1A8B2928107\",\"api\":\"d0bbef01-87c6-4629-9659-d95c59c22a9c\",\"_id\":541865}"}