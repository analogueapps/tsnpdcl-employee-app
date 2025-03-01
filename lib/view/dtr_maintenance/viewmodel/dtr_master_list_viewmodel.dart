import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_structure_index_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/employee_master_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';

class DtrMasterListViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  late NpdclUser npdclUser;

  bool _isLoading = isFalse;
  bool get isLoading => _isLoading;

  final List<DtrStructureIndexModel> _dtrStructureIndexList = [];
  List<DtrStructureIndexModel> get dtrStructureIndexList => _dtrStructureIndexList;

  // Filter list
  final List<FilterLabelModelList> filterLabelModelList = [];

  // Employee master
  final List<EmployeeMasterEntity> employeeMasterEntityList = [];

  // Constructor to initialize the items
  DtrMasterListViewmodel({required this.context}) {
    _loadUser();
    getDtrMasterIndex();
  }

  void _loadUser() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
  }

  Future<void> getDtrMasterIndex() async {
    _dtrStructureIndexList.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_MASTER_INDEX_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
          if (response.data['taskSuccess'] == isTrue) {
            if(response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];  // Fallback to empty list if the type is unexpected
              }
              final List<DtrStructureIndexModel> dataList = jsonList.map((json) => DtrStructureIndexModel.fromJson(json)).toList();
              _dtrStructureIndexList.addAll(dataList);
              notifyListeners();
            }
          }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void filterFabClicked() {
    if(filterLabelModelList.isNotEmpty) {
      moveToFilterScreen();
    } else {
      getFilterData();
    }
  }

  Future<void> getFilterData() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Loading available filters...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_DTR_MASTER_FILTER_DATA_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['taskSuccess'] == isTrue) {
            if(response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];  // Fallback to empty list if the type is unexpected
              }
              final List<FilterLabelModelList> dataList = jsonList.map((json) => FilterLabelModelList.fromJson(json)).toList();
              filterLabelModelList.addAll(dataList);
              notifyListeners();
              moveToFilterScreen();
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }
  }

  void moveToFilterScreen() {
    Navigation.instance.navigateTo(Routes.filterScreen, args: jsonEncode(filterLabelModelList),onReturn: (result) {
      if(result != null) {
        getFilteredDtrMasterData(result);
      }
    });
  }

  Future<void> getFilteredDtrMasterData(dynamic result) async {
    _dtrStructureIndexList.clear();
    _isLoading = isTrue;
    notifyListeners();

    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "query": jsonEncode(result)
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_FILTERED_DTR_MASTER_DATA_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
          if (response.data['taskSuccess'] == isTrue) {
            if(response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];  // Fallback to empty list if the type is unexpected
              }
              final List<DtrStructureIndexModel> dataList = jsonList.map((json) => DtrStructureIndexModel.fromJson(json)).toList();
              _dtrStructureIndexList.addAll(dataList);
              notifyListeners();
              if(_dtrStructureIndexList.isEmpty) {
                showAlertDialog(context,response.data['message']);
              }
            }
          }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

  void containerClicked(DtrStructureIndexModel item) {
    if(employeeMasterEntityList.isNotEmpty) {
      assignDtrInspectionDialog(item);
    } else {
      getEmployeesOfSection(item);
    }
  }

  Future<void> getEmployeesOfSection(DtrStructureIndexModel item) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching your staff...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.GET_EMPLOYEE_OF_SECTION_URL, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['taskSuccess'] == isTrue) {
            if(response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];  // Fallback to empty list if the type is unexpected
              }
              final List<EmployeeMasterEntity> dataList = jsonList.map((json) => EmployeeMasterEntity.fromJson(json)).toList();
              employeeMasterEntityList.addAll(dataList);
              notifyListeners();
              assignDtrInspectionDialog(item);
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }
  }

  void assignDtrInspectionDialog(DtrStructureIndexModel item) {
    // Selected item
    String? selectedItem;
    DateTime? selectedDate;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return Dialog(
        //   child: AssignDtrInspectionDialog(),
        // );
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              title: Container(
                width: double.infinity,
                color: CommonColors.colorPrimary,
                padding: const EdgeInsets.symmetric(vertical: doubleFifteen),
                child: Text(
                  "Assign DTR Inspection".toUpperCase(),
                  textAlign: TextAlign.center, // Center align the text
                  style: const TextStyle(
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.w600, // Optional: Bold text
                    fontSize: titleSize, // Optional: Font size
                  ),
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * pointEight, // 80% of screen width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(doubleTen),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: numFour,
                            child: Text(
                              "Structure Code",
                              style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: doubleThirty,
                            width: doubleOne,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: doubleTen,),
                          Expanded(
                            flex: numSix,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                checkNull(item.structureCode),
                                style: const TextStyle(
                                  color: CommonColors.colorPrimary,
                                  fontSize: extraRegularSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(doubleFive),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: numFour,
                            child: Text(
                              "Previous Maint. Count",
                              style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: doubleThirty,
                            width: doubleOne,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: doubleTen,),
                          Expanded(
                            flex: numSix,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                checkNull(item.maintenanceCount.toString()),
                                style: const TextStyle(
                                  fontSize: extraRegularSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(doubleFive),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: numFour,
                            child: Text(
                              "Last Maint. Date",
                              style: TextStyle(
                                fontSize: normalSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: doubleThirty,
                            width: doubleOne,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: doubleTen,),
                          Expanded(
                            flex: numSix,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                checkNull(item.lastMaintainedDate),
                                style: const TextStyle(
                                  fontSize: extraRegularSize,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(doubleFive),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Staff",
                            style: TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: doubleFive,),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text(
                              "Select an item",
                              style: TextStyle(fontSize: normalSize,),
                            ),
                            value: selectedItem,
                            items: employeeMasterEntityList.map((item) => DropdownMenuItem<String>(
                              value: item.empId,
                              child: Row(
                                children: [
                                  RepaintBoundary(
                                    child: Image.asset(
                                      Assets.account,
                                      height: 30.0,
                                      width: 30.0,
                                      filterQuality: FilterQuality.low,
                                    ),
                                  ),
                                  const SizedBox(width: doubleTen,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          checkNull(item.empName),
                                          style: const TextStyle(
                                            fontSize: normalSize,
                                          ),
                                        ),
                                        Text(
                                          checkNull(item.designation),
                                          style: TextStyle(
                                              fontSize: extraRegularSize,
                                              color: Colors.grey[700]
                                          ),
                                        ),
                                        Divider(
                                          height: doubleOne,
                                          color: Colors.grey[200],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: doubleFive,),
                          const Text(
                            "Select Schedule Date",
                            style: TextStyle(
                              fontSize: normalSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: doubleFive,),
                          InkWell(
                            onTap: () async {
                              final DateTime today = DateTime.now();
                              final DateTime maxDate = today.add(const Duration(days: 30)); // 30 days from today

                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: today,
                                lastDate: maxDate,
                              );

                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(width: doubleTen,),
                                Expanded(
                                  child: Text(
                                    selectedDate != null ? DateFormat('dd/MM/yyyy').format(selectedDate!) : "CHOOSE DATE",
                                    style: const TextStyle(
                                        color: CommonColors.colorPrimary,
                                      fontSize: normalSize,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(doubleTen),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(doubleFive),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: extraRegularSize,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: doubleTen,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CommonColors.successGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(doubleFive),
                                ),
                              ),
                              onPressed: () async {
                                if (selectedItem == null) {
                                  showAlertDialog(context, "Please select staff to assign DTR inspection");
                                } else if (selectedDate == null) {
                                  showAlertDialog(context, "Please select schedule date of maintenance");
                                } else{
                                  assignDtrInspection(item, selectedItem, selectedDate);
                                }
                              },
                              child: Text(
                                "Ok".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: extraRegularSize,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> assignDtrInspection(DtrStructureIndexModel item, String? lmEmpId, DateTime? selectedDate) async {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    NpdclUser npdclUser = user[0];

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "lmEmpId": lmEmpId,
      "structureCode": item.structureCode,
      "distributionCode": item.distributionCode,
      "scheduledDate": DateFormat('dd/MM/yyyy').format(selectedDate!),
      "scheduledMonth": DateFormat('MMyyyy').format(selectedDate),
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.ASSIGN_DTR_INSPECTION_URL, payload);
    _isLoading = isFalse;

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          //if(response.data['sessionValid'] == isTrue) {
          if (response.data['taskSuccess'] == isTrue) {
            showAlertDialog(context,response.data['message']);
          } else {
            showAlertDialog(context,response.data['message']);
          }
          // } else {
          //   showSessionExpiredDialog(context);
          // }
        } else {
          showAlertDialog(context,response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }

    notifyListeners();
  }

}
