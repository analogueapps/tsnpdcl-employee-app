import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/schedules/models/view_schedule_model.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/schedules/models/inspection_by_id_model.dart';

class ViewDetailScheduleViewmodel extends ChangeNotifier {
  ViewDetailScheduleViewmodel({required this.context, required this.data});

  final BuildContext context;
  final ViewScheduleModel data;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<MaintenanceItem> _overLoadItems = [];

  Future<void> attend(String status, int scheID) async {
    _isLoading = true;
    notifyListeners();

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "status": status,
      "tre": false,
      "scheduleId": "$scheID",
    };

    try {
      var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
          .postApiCall(context, Apis.GET_SS_INSPECTION_BY_ID, payload);

      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data);
        }

        print("API response: ${response.data}");

        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              dynamic rawDataList = response.data['dataList'];

              List<dynamic> jsonList;
              if (rawDataList == null) {
                // No inspection exists, navigate to inspection screen
                Navigation.instance.navigateTo(Routes.ssInspect, args: {
                  'ssCode': data.itemCode,
                  'ssName': data.itemName,
                  'scheduleId': data.tourId,
                });
                return;
              } else if (rawDataList is String) {
                jsonList = jsonDecode(rawDataList);
              } else if (rawDataList is List) {
                jsonList = rawDataList;
              } else {
                showErrorDialog(context, "Unexpected format for dataList");
                return;
              }

              if (jsonList.isEmpty) {
                Navigation.instance.navigateTo(Routes.ssInspect, args: {
                  'ssCode': data.itemCode,
                  'ssName': data.itemName,
                  'scheduleId': data.tourId,
                });
                return;
              }

              final List<MaintenanceItem> dataList = jsonList
                  .map((json) => MaintenanceItem.fromJson(json))
                  .toList();

              _overLoadItems.addAll(dataList);
              final firstItem = dataList.first;

              if (firstItem.status == "INSPECTED") {
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
                                Navigator.of(context).pop();
                                Navigation.instance.navigateTo(
                                  Routes.kv33Screen,
                                  args: {
                                    'ssCode': firstItem.ssCode,
                                    'ssName': firstItem.ssName ?? "",
                                    'id': firstItem.maintenanceId,
                                    'type': firstItem.status,
                                  },
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("View Inspection Report"),
                              onTap: () async {
                                Navigator.of(context).pop();
                                _isLoading = true;
                                notifyListeners();

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                if (firstItem
                                        .ssMaintenanceAttributesEntitiesByMid
                                        .isNotEmpty ==
                                    true) {
                                  String maintenanceId = firstItem
                                      .ssMaintenanceAttributesEntitiesByMid
                                      .first
                                      .maintenanceId
                                      .toString();
                                  String encodedId =
                                      base64.encode(utf8.encode(maintenanceId));

                                  Navigation.instance.navigateTo(
                                    Routes.webViewScreen,
                                    args: {
                                      'title': "SS MAINTENANCE",
                                      'url':
                                          "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
                                    },
                                  );
                                } else {
                                  showErrorDialog(
                                      context, "No inspection report found.");
                                }

                                _isLoading = false;
                                notifyListeners();
                              },
                            ),
                            ListTile(
                              title: const Text("Cancel"),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (firstItem.status == "FINISHED") {
                if (firstItem.ssMaintenanceAttributesEntitiesByMid.isNotEmpty ==
                    true) {
                  String maintenanceId = firstItem
                      .ssMaintenanceAttributesEntitiesByMid.first.maintenanceId
                      .toString();
                  String encodedId = base64.encode(utf8.encode(maintenanceId));

                  Navigation.instance.navigateTo(
                    Routes.webViewScreen,
                    args: {
                      'title': "SS MAINTENANCE",
                      'url':
                          "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
                    },
                  );
                } else {
                  showErrorDialog(context, "No inspection report found.");
                }
              } else {
                // Default to update flow
                Navigation.instance.navigateTo(
                  Routes.kv33Screen,
                  args: {
                    'ssCode': firstItem.ssCode,
                    'ssName': firstItem.ssName ?? "",
                    'id': firstItem.maintenanceEmpId ?? "",
                    'type': firstItem.status,
                  },
                );
              }
            } else {
              // Task failed - treat as not inspected
              Navigation.instance.navigateTo(Routes.ssInspect, args: {
                'ssCode': data.itemCode,
                'ssName': data.itemName,
                'scheduleId': data.tourId,
              });
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(
            context,
            response.data['message'] ??
                'Request failed with status: ${response.statusCode}',
          );
        }
      }
    } catch (e, stack) {
      print("Exception in attend: $e");
      print("Stacktrace: $stack");
      showErrorDialog(context, "An error occurred.Please try again later");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> attend(String status, int scheID) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   final payload = {
  //     "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
  //     "appId": "in.tsnpdcl.npdclemployee",
  //     "status": status,
  //     "tre": false,
  //     "scheduleId": "$scheID",
  //   };
  //
  //   var response = await ApiProvider(baseUrl: Apis.SS_END_POINT_BASE_URL)
  //       .postApiCall(context, Apis.GET_SS_INSPECTION_BY_ID, payload);
  //
  //   _isLoading = false;
  //   notifyListeners();
  //   print(" response done");
  //
  //   try {
  //     print("try block started");
  //     if (response != null) {
  //       if (response.data is String) {
  //         response.data = jsonDecode(response.data);
  //       }
  //       if (response.statusCode == successResponseCode) {
  //         if (response.data['sessionValid'] == true) {
  //           if (response.data['taskSuccess'] == true) {
  //             if (response.data['dataList'] == null||response.data['dataList'].isEmpty) {
  //               var argument = {
  //                 'ssCode': data.itemCode,
  //                 'ssName': data.itemName,
  //                 'scheduleId':data.tourId,
  //                 'type':"inspect"
  //               };
  //
  //               Navigation.instance.navigateTo(Routes.ssInspect , args: argument);
  //
  //             }else{
  //               var rawDataList = response.data['dataList'];
  //               print("Raw dataList: $rawDataList");
  //
  //               List<dynamic> jsonList;
  //               if (rawDataList is String) {
  //                 jsonList = jsonDecode(rawDataList);
  //               } else if (rawDataList is List) {
  //                 jsonList = rawDataList;
  //               } else {
  //                 print("Unexpected type: ${rawDataList.runtimeType}");
  //                 jsonList = [];
  //               }
  //
  //               if (jsonList.isEmpty) {
  //                 showErrorDialog(context, "No data received.");
  //                 return;
  //               }
  //
  //               final List<MaintenanceItem> dataList = jsonList.map((json) {
  //                 return MaintenanceItem.fromJson(json);
  //               }).toList();
  //
  //               _overLoadItems.addAll(dataList);
  //               print("VIewDetail: $_overLoadItems");
  //
  //               if (dataList.first.ssMaintenanceAttributesEntitiesByMid == null) {
  //                 print("VIEW DETAIL SCHEDULE STATUS IS NOT PRESENT");
  //
  //                 var argument = {
  //                   'ssCode': dataList.first.ssCode,
  //                   'ssName': dataList.first.ssName??"",
  //                   'id':dataList.first.maintenanceEmpId??"",
  //                   'type':dataList.first.status
  //                 };
  //
  //                 Navigation.instance.navigateTo(Routes.kv33Screen, args: argument);
  //               } else if (dataList.first.status == "FINISHED") {
  //                   print("VIEW DETAIL SCHEDULE STATUS IS FINISHED");
  //
  //                   if (dataList.first.ssMaintenanceAttributesEntitiesByMid.isNotEmpty) {
  //                     print("Attributes: ${dataList.first.ssMaintenanceAttributesEntitiesByMid}");
  //                     print("First attribute: ${dataList.first.ssMaintenanceAttributesEntitiesByMid.first}");
  //
  //                     String maintenanceId = dataList.first.ssMaintenanceAttributesEntitiesByMid.first.maintenanceId.toString();
  //                     String encodedId = base64.encode(utf8.encode(maintenanceId));
  //
  //                     var argument = {
  //                       'title': "SS MAINTENANCE",
  //                       'url': "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
  //                     };
  //
  //                     Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
  //                   } else {
  //                     print("No maintenance attributes available.");
  //                     showErrorDialog(context, "No inspection report found.");
  //                   }
  //                  }else if (dataList.first.status =="INSPECTED"){
  //                 print("VIEW DETAIL SCHEDULE STATUS IS INSPECTED");
  //
  //                 showDialog(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return AlertDialog(
  //                         title: const Text("Choose Option"),
  //                         content: SingleChildScrollView(
  //                           child: ListBody(
  //                             children: [
  //                               ListTile(
  //                                 title: const Text("Update Maintenance Data"),
  //                                 onTap: () {
  //                                   Navigator.of(context).pop();
  //                                   var argument = {
  //                                     'ssCode': dataList.first.ssCode,
  //                                     'ssName': dataList.first.ssName??"",
  //                                     'id': dataList.first.maintenanceId,
  //                                     'type': dataList.first.status
  //                                   };
  //                                   Navigation.instance.navigateTo(
  //                                       Routes.kv33Screen, args: argument);
  //                                 },
  //                               ),
  //                               ListTile(
  //                                 title: const Text("View Inspection Report"),
  //                                 onTap: () async {
  //                                   Navigator.of(context).pop();
  //                                   _isLoading = true;
  //                                   notifyListeners();
  //
  //                                   await Future.delayed(const Duration(seconds: 1));
  //
  //                                   if (dataList.first
  //                                       .ssMaintenanceAttributesEntitiesByMid
  //                                       ?.isNotEmpty ==
  //                                       true) {
  //                                     String maintenanceId = dataList.first
  //                                         .ssMaintenanceAttributesEntitiesByMid
  //                                         .first
  //                                         .maintenanceId
  //                                         .toString();
  //
  //                                     String encodedId =
  //                                     base64.encode(utf8.encode(maintenanceId));
  //
  //                                     var argument = {
  //                                       'title': "SS MAINTENANCE",
  //                                       'url':
  //                                       "${UrlConstants.contextUrl}SSMaintenanceView?iid=$encodedId",
  //                                     };
  //
  //                                     Navigation.instance.navigateTo(Routes.webViewScreen,
  //                                         args: argument);
  //                                   } else {
  //                                     print("No maintenance attributes available.");
  //                                     showErrorDialog(context, "No inspection report found.");
  //                                   }
  //
  //                                   _isLoading = false;
  //                                   notifyListeners();
  //                                 },
  //                               ),
  //                               ListTile(
  //                                 title: const Text("Cancel"),
  //                                 onTap: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     }
  //                 );
  //               }
  //             }
  //           } else {
  //
  //               var argument = {
  //                 'ssCode': data.itemCode,
  //                 'ssName': data.itemName,
  //                 'scheduleId':data.tourId,
  //                 'scheduleId':data.tourId,
  //
  //               };
  //               Navigation.instance.navigateTo(Routes.ssInspect, args: argument);
  //             }
  //         } else {
  //           showSessionExpiredDialog(context);
  //         }
  //       } else {
  //         showAlertDialog(
  //           context,
  //           response.data['message'] ?? 'Request failed with status: ${response.statusCode}',
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     print("view detail Exception caught: $e");
  //     showErrorDialog(context, "An error occured: $e");
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
