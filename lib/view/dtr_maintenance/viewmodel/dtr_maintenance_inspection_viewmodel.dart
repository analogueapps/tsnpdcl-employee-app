import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_inspection_sheet_entity.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/employee_master_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';
import 'package:tsnpdcl_employee/widget/view_detailed_lc_tile_widget.dart';

class DtrMaintenanceInspectionViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;
  String jsonResponse;

  DtrInspectionSheetEntity? dtrInspectionSheetEntity = null;

  List<OptionList> groups = [];
  List<OptionList> get groupsList => groups;

  OptionList? selectedGroup;

  // Constructor to initialize the items
  DtrMaintenanceInspectionViewmodel({required this.context, required this.jsonResponse}) {
    dtrInspectionSheetEntity = DtrInspectionSheetEntity.fromJson(jsonDecode(jsonResponse));
    loadFilters();
  }

  void loadFilters() {
    List<OptionList> predefinedGroups = [
      OptionList(optionId: "HT_SIDE", optionName: "HT Side"),
      OptionList(optionId: "LT_SIDE", optionName: "LT Side"),
      OptionList(optionId: "OIL", optionName: "Oil"),
      OptionList(optionId: "EARTHING", optionName: "Earthing"),
      OptionList(optionId: "LT_NETWORK", optionName: "LT Network"),
      OptionList(optionId: "LA", optionName: "LA's"),
      OptionList(optionId: "DTR_LOADING", optionName: "DTR Loading"),
      OptionList(optionId: "TONG", optionName: "Tong Tester Readings"),
    ];
    groups = predefinedGroups;

    selectedGroup = predefinedGroups.firstWhere(
          (group) => group.optionId == "HT_SIDE",
      orElse: () => predefinedGroups.first,
    );
    notifyListeners();
  }

  void selectGroup(OptionList group) {
    selectedGroup = group;
    print("SelectedGroup : ${group.optionId}");
    notifyListeners();
  }


  Map<String, bool Function()> get maintenanceCheckMap => {
    "HT_SIDE": htIsMaintenanceRequired,
    "LT_SIDE": ltIsMaintenanceRequired,
    "OIL": oilMaintenanceRequired,
    "EARTHING":earthMaintenanceRequired,
    "LT_NETWORK": ltnMaintenanceRequired,
    "LA": laMaintenanceRequired,
    "DTR_LOADING": dtrMaintenanceRequired,
    "TONG": () => false,
  };

  bool htIsMaintenanceRequired(){
    return dtrInspectionSheetEntity?.abContactsDamaged>0 ||
        dtrInspectionSheetEntity?.nylonBushDamaged>0||
        dtrInspectionSheetEntity?.abBrassStripDamaged>0||
        dtrInspectionSheetEntity?.hornsToBeReplaced>0||
        (dtrInspectionSheetEntity?.gapIsNotCorrect!="Y") ||dtrInspectionSheetEntity?.hgFuseSetPostTypeInsulatorsCount>0 || dtrInspectionSheetEntity?.htBushesDamageCount>0 || dtrInspectionSheetEntity?.htBushRodsDamCount>0;
  }

  bool ltIsMaintenanceRequired(){
    return dtrInspectionSheetEntity?.ltBushesDamageCount>0 || dtrInspectionSheetEntity?.ltBushRodsDamCount>0 || dtrInspectionSheetEntity?.ltBiMetalClampsDamCount>0 ||
        (dtrInspectionSheetEntity?.ltBreakerStatus!="DAMAGED") || (dtrInspectionSheetEntity?.ltFuseSetStatus!="DAMAGED")
        || dtrInspectionSheetEntity?.ltFuseWire!="COPPER_OK"|| (dtrInspectionSheetEntity?.ltPvcCableStatus!="DAMAGED");


  }

  bool oilMaintenanceRequired(){
    return  dtrInspectionSheetEntity?.oilShortageInLiters>0 || (dtrInspectionSheetEntity?.gasketsDamaged!="DAMAGED") || (dtrInspectionSheetEntity?.diaphragmStatus!="DAMAGED");
  }

  bool earthMaintenanceRequired(){
    return  dtrInspectionSheetEntity?.earthPipesStatus!=null&&dtrInspectionSheetEntity?.earthPipesStatus.toLowerCase() == "damaged" ||
        dtrInspectionSheetEntity?.earthing!=null && dtrInspectionSheetEntity?.earthing.toLowerCase() == "damaged";
  }

  bool ltnMaintenanceRequired(){
  return dtrInspectionSheetEntity?.noOfLooseLinesOnDtr>0 || dtrInspectionSheetEntity?.treeCuttingRequired>0 || (dtrInspectionSheetEntity?.otherObservationsByLm.toLowerCase() == "y");
  }

  bool laMaintenanceRequired(){
  return dtrInspectionSheetEntity?.lightningArrestors!=null&&dtrInspectionSheetEntity?.lightningArrestors.toLowerCase() == "damaged";
  }
  bool dtrMaintenanceRequired(){
  return (dtrInspectionSheetEntity?.dtrAglLoadHp>0.0 || dtrInspectionSheetEntity?.domesticNonDomLoad >0.0 || dtrInspectionSheetEntity?.industrialLoadInHp>0.0 || dtrInspectionSheetEntity?.waterWorksLoadInHp>0.0 || dtrInspectionSheetEntity?.otherLoadInKw>0.0);
  }

   void assignForMaintenance(DtrInspectionSheetEntity? item){
     EmployeeMasterEntity? selectedItem;
     DateTime? selectedDate;

     showDialog(
       barrierDismissible: true,
       context: context,
       builder: (BuildContext context) {
         return
         StatefulBuilder(
           builder: (context, setState) {
             return AlertDialog(
               // contentPadding: EdgeInsets.zero,
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
                 width: MediaQuery
                     .of(context)
                     .size
                     .width * pointEight, // 80% of screen width
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ViewDetailedLcTileWidget(
                         tileKey: "Structure Code",
                         tileValue: item?.structureCode ?? "N/A"),
                     const Divider(
                       color: Colors.grey,
                       thickness: 1,
                     ),
                     ViewDetailedLcTileWidget(
                         tileKey: "Inspection Date",
                         tileValue: item?.reportSubmitDate),
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
                     const SizedBox(height: doubleFive,),
                     DropdownButton<EmployeeMasterEntity>(
                       isExpanded: true,
                       hint: const Text("Select an item", style: TextStyle(fontSize: normalSize)),
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
                                     Text(checkNull(emp.empName), style: const TextStyle(fontSize: normalSize)),
                                     Text(checkNull(emp.designation), style: TextStyle(fontSize: extraRegularSize, color: Colors.grey[700])),
                                     Divider(height: doubleOne, color: Colors.grey[200]),
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
                         final DateTime maxDate = today.add(
                             const Duration(days: 30)); // 30 days from today

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
                               selectedDate != null ? DateFormat('dd/MM/yyyy')
                                   .format(selectedDate!) : "CHOOSE DATE",
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
                             setState((){
                               selectedDate=null;
                               selectedItem=null;
                             });
                             Navigator.of(context).pop();
                           },
                           child: Text("Cancel".toUpperCase(),
                               style: const TextStyle(fontSize: extraRegularSize, color: Colors.white)),
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
                               showAlertDialog(context, "Please select staff to assign DTR inspection");
                             } else if (selectedDate == null) {
                               showAlertDialog(context, "Please select schedule date of maintenance");
                             } else {
                               print("assignDtrMaintenance api call: ${item!.sheetId} ${selectedItem!.empId}");
                               assignDtrMaintenance(item.sheetId, selectedItem!.empId);
                             }
                           },
                           child: Text("Ok".toUpperCase(),
                               style: const TextStyle(fontSize: extraRegularSize, color: Colors.white)),
                         ),
                       ),
                     ],
                   ),
                 ],
             );
           }
         );
       },
     );
  }


  final List<EmployeeMasterEntity> employeeMasterEntityList = [];
  Future<void> getEmployeesOfSection(DtrInspectionSheetEntity? item) async {
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
              assignForMaintenance(item);
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

  Future<void> assignDtrMaintenance(num? sheetID, String? selectedEmpId) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Processing...",
    );

    final payload = {
      "token": SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "lmEmpId":selectedEmpId,
      "id":sheetID
    };

    var response = await ApiProvider(baseUrl: Apis.DTR_END_POINT_BASE_URL).postApiCall(context, Apis.ASSIGN_DTR_MAINTENANCE_URL, payload);
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
                showSuccessDialog(context, response.data['message'], (){
                  Navigator.pop(context);
                });
                selectedEmpId=null;
                sheetID=null;
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
      showErrorDialog(context,  "An error occurred. Please try again.");
      rethrow;
    }
  }

}
