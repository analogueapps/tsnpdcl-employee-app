import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/schedules/models/inspection_by_id_model.dart';
import 'package:tsnpdcl_employee/view/tong_tester_readings/model/overload_dtr_list_model.dart';

class ViewDetailScheduleViewmodel extends ChangeNotifier {
  ViewDetailScheduleViewmodel({required this.context});

  final BuildContext context;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  // final List<ViewScheduleModel> _overLoadItems = [];
  // List<ViewScheduleModel> get overLoadItems => _overLoadItems;

  Future<void> attend(String status, int scheID ) async {
    _isLoading = isTrue;
    notifyListeners();


    final payload = {
      "token": SharedPreferenceHelper.getStringValue(
          LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status": status,
      "tre": false,
      "scheduleId":"$scheID"
    };

    var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_SS_INSPECTION_BY_ID, payload);

    _isLoading = isFalse;
    notifyListeners();

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['dataList'] != null) {
                List<MaintenanceItem> jsonList = (response.data['dataList'] as List)
                    .map((e) => MaintenanceItem.fromJson(e))
                    .toList();
                if(jsonList.first.ssMaintenanceAttributesEntitiesByMid==null){
                  print("VIEW DETAIL SCHEDULE STATUS IS NOT PRESENT");

                  // Intent intent= new Intent(context, SSMaintenanceInspectionActivity.class);
                  // intent.putExtra("ssCode",maintenanceTourDairyEntity.getItemCode());
                  // intent.putExtra("ssName",maintenanceTourDairyEntity.getItemName());
                  // intent.putExtra("scheduleId",maintenanceTourDairyEntity.getTourId());
                  // startActivity(intent);

                }else {
                  if(jsonList.first.status=="INSPECTED"){
                    print("VIEW DETAIL SCHEDULE STATUS IS INSPECTED");

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Choose Option"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                ListTile(
                                  title: const Text("Update Maintenance Data"),
                                  onTap: () {
                                    Navigator.of(context).pop(); // Close the dialog first

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => SSMaintenanceAfterActivity(
                                    //       ssCode: ssMaintenanceEntity.ssCode,
                                    //       ssName: ssMaintenanceEntity.ssName,
                                    //       id: ssMaintenanceEntity.maintenanceId.toString(),
                                    //       type: ssMaintenanceEntity.status,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ),
                                ListTile(
                                  title: const Text("View Inspection Report"),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    _isLoading = isTrue;
                                    notifyListeners();

                                    await Future.delayed(const Duration(seconds: 1));

                                    if (jsonList.first.ssMaintenanceAttributesEntitiesByMid.isNotEmpty) {
                                      String maintenanceId = jsonList
                                          .first
                                          .ssMaintenanceAttributesEntitiesByMid
                                          .first
                                          .maintenanceId
                                          .toString();
                                      String encodedId = base64.encode(utf8.encode(maintenanceId));

                                      var argument = {
                                        'title': "SS MAINTENANCE",
                                        'url': "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
                                      };

                                      Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
                                    } else {
                                      print("No maintenance attributes available.");
                                      showErrorDialog(context, "No inspection report found.");
                                    }

                                    _isLoading=isFalse;
                                    notifyListeners();
                                  },
                                ),
                                ListTile(
                                  title: const Text("Cancel"),
                                  onTap: () {
                                    Navigator.of(context).pop(); // Just close the dialog
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );


                  }else if (jsonList.first.status == "FINISHED") {
                    print("VIEW DETAIL SCHEDULE STATUS IS FINISHED");

                    if (jsonList.first.ssMaintenanceAttributesEntitiesByMid.isNotEmpty) {
                      String maintenanceId = jsonList
                          .first
                          .ssMaintenanceAttributesEntitiesByMid
                          .first
                          .maintenanceId
                          .toString();
                      String encodedId = base64.encode(utf8.encode(maintenanceId));

                      var argument = {
                        'title': "SS MAINTENANCE",
                        'url': "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
                      };

                      Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
                    } else {
                      print("No maintenance attributes available.");
                      showErrorDialog(context, "No inspection report found.");
                    }
                  }

                }
              } else {
                print("VIEW DETAIL SCHEDULE STATUS IS NOT PRESENT");
                // showSuccessDialog(
                //     context, response.data['message'] ?? 'Success', () {
                //   Navigator.pop(context);
                // });
                // print("dtr_failure_reports: ${response.data['dataList']}");
              }
            } else {
              showErrorDialog(
                  context, response.data['message'] ?? 'Operation failed');
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message'] ??
              'Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}