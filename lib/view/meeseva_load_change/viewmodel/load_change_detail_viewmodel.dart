import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
import 'package:tsnpdcl_employee/view/meeseva_category_pending_allotment/model/category_change_request_model.dart';
import 'package:tsnpdcl_employee/view/meeseva_category_pending_allotment/model/make_capacity_model.dart';
import 'package:tsnpdcl_employee/view/check_readings/model/ero_model.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/employee_master_entity.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class LoadChangeDetailViewmodel extends ChangeNotifier {
  LoadChangeDetailViewmodel({
    required this.data,
    required this.context,
  }) {
    loadChange =
        CategoryChangeRequestModel.fromJson(jsonDecode(data['catData']));
    print("CategoryChangeDetailViewmodel: ${data['status']}");
  }

  final BuildContext context;
  final Map<String, dynamic> data;

  late final CategoryChangeRequestModel loadChange;

  final bool _isLoading = isFalse;

  bool get isLoading => _isLoading;

  String? selectedOption = "";

  void toggleOption(String value) {
    selectedOption = value;
    print("$selectedOption :choose option");
    notifyListeners();
  }

  EroModel? reason;
  String? selectedReason;
  List<EroModel> get reasonList =>
      makeCapacity.isNotEmpty && makeCapacity[0].rejectReasons.isNotEmpty
          ? makeCapacity[0]
              .rejectReasons //${reason.optionId} (${reason.optionName})'
              .toList()
          : [];

  EroModel? make;
  String? selectedMAke;
  List<EroModel> get makeList =>
      makeCapacity.isNotEmpty && makeCapacity[0].meterMakesList.isNotEmpty
          ? makeCapacity[0].meterMakesList.toList()
          : [];

  EroModel? capacity;
  String? selectedCapacity;
  List<EroModel> get capacityList =>
      makeCapacity.isNotEmpty && makeCapacity[0].meterCapacityList.isNotEmpty
          ? makeCapacity[0].meterCapacityList.toList()
          : [];

  bool isEditMeterChecked = false;

  TextEditingController serialNo = TextEditingController();
  TextEditingController finalReadingKWH = TextEditingController();
  TextEditingController finalReadingKVAH = TextEditingController();

  // Accept Staff
  final List<EmployeeMasterEntity> employeeMasterEntityList = [];
  Future<void> getEmployeesOfSection(CategoryChangeRequestModel? item) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching your staff...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_EMPLOYEE_OF_SECTION_URL, payload);
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
            if (response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];
              }
              final List<EmployeeMasterEntity> dataList = jsonList
                  .map((json) => EmployeeMasterEntity.fromJson(json))
                  .toList();
              employeeMasterEntityList.addAll(dataList);
              notifyListeners();
              assignForMaintenance(item);
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

  void assignForMaintenance(CategoryChangeRequestModel? item) {
    EmployeeMasterEntity? selectedItem;
    DateTime? selectedDate;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            // contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: Container(
              width: double.infinity,
              color: CommonColors.colorPrimary,
              padding: const EdgeInsets.symmetric(vertical: doubleFifteen),
              child: Text(
                "Assign for Inspection".toUpperCase(),
                textAlign: TextAlign.center, // Center align the text
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.w600, // Optional: Bold text
                  fontSize: titleSize, // Optional: Font size
                ),
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width *
                  pointEight, // 80% of screen width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ViewDetailedLcTileWidget(
                    tileKey: "Registration No",
                    tileValue: item?.regNum ?? "N/A",
                    valueColor: Colors.green,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ViewDetailedLcTileWidget(
                    tileKey: "Registration Date",
                    tileValue: DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(item!.regDate ?? ""),
                    ),
                    valueColor: Colors.green,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ViewDetailedLcTileWidget(
                      tileKey: "Consumer Name",
                      tileValue: item.consumerName ?? ""),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  ViewDetailedLcTileWidget(
                      tileKey: "Service Request Type",
                      tileValue: "${item.existCat} to ${item.reqCat}" ?? ""),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const Text(
                    "Select Staff",
                    style: TextStyle(
                      fontSize: normalSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: doubleFive,
                  ),
                  DropdownButton<EmployeeMasterEntity>(
                    isExpanded: true,
                    hint: const Text("Select an item",
                        style: TextStyle(fontSize: normalSize)),
                    value: selectedItem,
                    items: employeeMasterEntityList.map((emp) {
                      final empIdStr = emp.empId.toString();
                      return DropdownMenuItem<EmployeeMasterEntity>(
                        value: emp,
                        child: Row(
                          children: [
                            Image.asset(Assets.account, height: 30, width: 30),
                            const SizedBox(width: doubleTen),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(checkNull(emp.empName),
                                      style: const TextStyle(
                                          fontSize: normalSize)),
                                  Text(checkNull(emp.designation),
                                      style: TextStyle(
                                          fontSize: extraRegularSize,
                                          color: Colors.grey[700])),
                                  Divider(
                                      height: doubleOne,
                                      color: Colors.grey[200]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (EmployeeMasterEntity? newValue) {
                      setState(() {
                        selectedItem = newValue;
                        print("selectedEmp value:  ${selectedItem?.empId}");
                      });
                    },
                  ),
                  const SizedBox(
                    height: doubleFive,
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(doubleFive),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedDate = null;
                          selectedItem = null;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel".toUpperCase(),
                          style: const TextStyle(
                              fontSize: extraRegularSize, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: doubleTen),
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
                          showAlertDialog(context, "Please select staff");
                        } else {
                          print(
                              "assignMaintenance api call: ${item.regId} ${selectedItem!.empId}");
                          updateLoadChange(item.regId, selectedItem!.empId);
                        }
                      },
                      child: Text("Ok".toUpperCase(),
                          style: const TextStyle(
                              fontSize: extraRegularSize, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> updateLoadChange(num regID, String? selectedEmpId) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Processing...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "lmEmpId": selectedEmpId,
      "status": "F_ALLOT",
      "regId": regID
    };

    var response = await ApiProvider(baseUrl: Apis.CAT_CHANGE_ENDPOINT_URL)
        .postApiCall(context, Apis.UPDATE_CAT_CHANGE, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
                selectedEmpId = "";
                notifyListeners();
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

  //ACCEPT/REJECT
  final List<MeterMakeAndCapacityModel> makeCapacity = [];
  Future<void> getMeterMakesAndCapacities() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Processing...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.CAT_CHANGE_ENDPOINT_URL)
        .postApiCall(context, Apis.MAKE_CAPACITIES, payload);
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
            if (response.data['dataList'] != null) {
              // final List<dynamic> jsonList = jsonDecode(response.data['dataList']);
              List<dynamic> jsonList;

              // If dataList is a String, decode it; otherwise, it's already a List
              if (response.data['dataList'] is String) {
                jsonList = jsonDecode(response.data['dataList']);
              } else if (response.data['dataList'] is List) {
                jsonList = response.data['dataList'];
              } else {
                jsonList = [];
              }
              final List<MeterMakeAndCapacityModel> dataList = jsonList
                  .map((json) => MeterMakeAndCapacityModel.fromJson(json))
                  .toList();
              makeCapacity.addAll(dataList);
              notifyListeners();
              acceptRejectDialog();
            }
          } else {
            showAlertDialog(context, response.data['message']);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }

  void acceptRejectDialog() {
    serialNo.text = loadChange.meterSlNo;
    // finalReading.text=loadChange.meterFr.toString();
    selectedMAke = loadChange.meterMake;
    selectedCapacity = loadChange.meterCapacity;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              content: SizedBox(
                width: MediaQuery.of(context).size.width *
                    pointEight, // 80% of screen width
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CHOOSE THE OPTION",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Accept",
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                              print("$selectedOption :choose option");
                            },
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "Accept",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                              value: "Reject",
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                                print("$selectedOption :choose option");
                              }),
                          const SizedBox(width: 4),
                          const Text(
                            "Reject",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: doubleFive,
                      ),
                      Visibility(
                        visible: selectedOption == "Reject",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Select Reason:"),
                            DropdownButtonFormField<EroModel>(
                              value: reason,
                              hint: const Text("Select"),
                              isExpanded: true,
                              items: reasonList.map((EroModel value) {
                                return DropdownMenuItem<EroModel>(
                                  value: value,
                                  child: Text(value.optionName),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  reason = newValue;
                                  selectedReason = newValue!.optionId;
                                  // print("selectedReason: $reason selected and optionID: $selectedReason");
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: selectedOption == "Accept",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: isEditMeterChecked,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isEditMeterChecked = newValue ?? false;
                                    });
                                    if (isEditMeterChecked) {
                                      print(
                                          "$isEditMeterChecked Edit Meter Particulars");
                                    } // Update ViewModel
                                  },
                                ),
                                const Text("Edit Meter Particulars"),
                              ],
                            ),
                            const Text(
                              "METER PARTICULARS",
                              style: TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Text("Make"),
                            DropdownButtonFormField<EroModel>(
                              value: make,
                              hint: Text(loadChange.meterMake,
                                      style: TextStyle(
                                          color: isEditMeterChecked
                                              ? Colors.black
                                              : null)) ??
                                  const Text("Select"),
                              isExpanded: true,
                              items: makeList.map((EroModel value) {
                                return DropdownMenuItem<EroModel>(
                                  value: value,
                                  child: Text(value.optionName),
                                );
                              }).toList(),
                              onChanged: isEditMeterChecked
                                  ? (newValue) {
                                      setState(() {
                                        make = newValue;
                                        selectedMAke = newValue!.optionId;
                                      });
                                    }
                                  : null,
                            ),
                            const SizedBox(
                              height: doubleTen,
                            ),
                            const Text("Capacity"),
                            DropdownButtonFormField<EroModel>(
                              value: capacity,
                              hint: Text(
                                    loadChange.meterCapacity,
                                    style: TextStyle(
                                        color: isEditMeterChecked
                                            ? Colors.black
                                            : null),
                                  ) ??
                                  const Text("Select"),
                              isExpanded: true,
                              items: capacityList.map((EroModel value) {
                                return DropdownMenuItem<EroModel>(
                                  value: value,
                                  child: Text(value.optionName),
                                );
                              }).toList(),
                              onChanged: isEditMeterChecked
                                  ? (newValue) {
                                      setState(() {
                                        capacity = newValue;
                                        selectedCapacity = newValue!.optionId;
                                        // print("selectedReason: $reason selected and optionID: $selectedReason");
                                      });
                                    }
                                  : null,
                            ),
                            const Text("Serial No"),
                            TextFormField(
                              controller: serialNo,
                            ),
                            const Text("Final Reading(KWH)"),
                            TextFormField(
                              controller: finalReadingKWH,
                            ),
                            const Text("Final Reading(KVAH)"),
                            TextFormField(
                              controller: finalReadingKVAH,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(doubleFive),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            reason = null;
                            selectedOption = null;
                            selectedReason = null;
                            isEditMeterChecked = false;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel".toUpperCase(),
                            style: const TextStyle(
                                fontSize: extraRegularSize,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: doubleTen),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CommonColors.successGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(doubleFive),
                          ),
                        ),
                        onPressed: () async {
                          if (selectedOption == "Accept" &&
                              serialNo.text == "") {
                            showAlertDialog(context, "Please enter SerialNo");
                          } else if (selectedOption == "Accept" &&
                              finalReadingKWH.text == "") {
                            showAlertDialog(
                                context, "Please enter Final Reading");
                          } else if (selectedOption == "Accept" &&
                              finalReadingKVAH.text == "") {
                            showAlertDialog(
                                context, "Please enter Final Reading");
                          } else if (selectedOption == "Accept" &&
                              selectedMAke!.isEmpty) {
                            showAlertDialog(context, "Please choose Make");
                          } else if (selectedOption == "Accept" &&
                              selectedCapacity!.isEmpty) {
                            showAlertDialog(context, "Please choose Capacity");
                          } else if (selectedOption == "Reject" &&
                              selectedReason == null) {
                            showAlertDialog(context, "Please select a Reason");
                          } else {
                            updateCatChangeApplication(loadChange.regId, "",
                                loadChange.testReportPath);
                          }
                        },
                        child: Text("submit".toUpperCase(),
                            style: const TextStyle(
                                fontSize: extraRegularSize,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
  }

  void buttonCreated() {
    String? code =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.designationCodeKey);
    if (code == 155 || code == 150) {
      if (loadChange.status == "VERIFIED") {}
    } else {}
  }

  Future<void> updateCatChangeApplication(
      num regID, String? selectedEmpId, String imageUrl) async {
    String? empType =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.empType);
    print("Employee Tyep: $empType");

    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Processing...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "testReportPath": imageUrl,
      "lmEmpId": selectedEmpId,
      "regId": regID,
      if (empType == "OM") ...{
        "status": selectedOption == "Accept" ? "LM_F" : "LM_NF",
      } else ...{
        "status": selectedOption == "Accept" ? "AE_F" : "AE_NF",
      },
      if (selectedOption == "Accept") ...{
        "make": selectedMAke,
        "capacity": selectedCapacity,
        "meterSerial": serialNo.text,
        // "finalReading":finalReading.text,
      } else ...{
        "reason": selectedReason,
      }
    };
    print("Payload for updateCatChangeApplication is : $payload");

    var response = await ApiProvider(baseUrl: Apis.CAT_CHANGE_ENDPOINT_URL)
        .postApiCall(context, Apis.UPDATE_CAT_CHANGE, payload);
    if (context.mounted) {
      ProcessDialogHelper.closeDialog(context);
    }

    try {
      if (response != null) {
        if (response.data is String) {
          response.data = jsonDecode(response.data); // Parse string to JSON
        }
        if (response.statusCode == successResponseCode) {
          if (response.data['sessionValid'] == isTrue) {
            if (response.data['taskSuccess'] == isTrue) {
              if (response.data['message'] != null) {
                showSuccessDialog(context, response.data['message'], () {
                  Navigator.pop(context);
                });
                selectedEmpId = "";
                notifyListeners();
              }
            } else {
              showAlertDialog(context, response.data['message']);
            }
          } else {
            showSessionExpiredDialog(context);
          }
        } else {
          showAlertDialog(context, response.data['message']);
        }
      }
    } catch (e) {
      showErrorDialog(context, "An error occurred. Please try again.");
      rethrow;
    }
  }
}
