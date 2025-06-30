import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/dialogs/process_dialog.dart';
import 'package:tsnpdcl_employee/network/api_provider.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/designation_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/employee_master_entity.dart';
import 'package:tsnpdcl_employee/view/filter/model/filter_label_model_list.dart';
import 'package:tsnpdcl_employee/view/pdms/helper/approve_close_ticket_page.dart';
import 'package:tsnpdcl_employee/view/pdms/helper/assign_inspection_officer_page.dart';
import 'package:tsnpdcl_employee/view/pdms/model/inspection_ticket_entity.dart';

class ViewDetailedInspectionTicketViewmodel extends ChangeNotifier {
  final BuildContext context;
  final String data;
  late InspectionTicketEntity inspectionTicketEntity;
  late NpdclUser npdclUser;

  bool isButtonVisible = false;
  String buttonText = "";
  Color buttonColor = Colors.transparent;
  Function? buttonAction;

  // Employee master
  final List<EmployeeMasterEntity> employeeMasterEntityList = [];

  ViewDetailedInspectionTicketViewmodel(
      {required this.context, required this.data}) {
    inspectionTicketEntity = InspectionTicketEntity.fromJson(jsonDecode(data));
    _loadUser();
  }

  void _loadUser() {
    String? prefJson =
        SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user =
        jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
    notifyListeners();
    _updateButtonState();
  }

  void _updateButtonState() {
    if (npdclUser.designationCode == CGM_DESIGNATION_CODE &&
        npdclUser.wing?.toLowerCase() == "pmm") {
      isButtonVisible = true;
      buttonText = "Forward/Reject";
    } else {
      isButtonVisible = false;
    }

    if (npdclUser.designationCode == EE_CIVIL_DESIGNATION_CODE &&
        npdclUser.wing?.toLowerCase() == "civil" &&
        npdclUser.empId?.toLowerCase() ==
            inspectionTicketEntity.empId?.toLowerCase() &&
        inspectionTicketEntity.ticketStatus?.toLowerCase() == "assigned") {
      isButtonVisible = true;
      buttonText = "SUBMIT INSPECTION REPORT";
      buttonAction = _submitInspectionReport;
    } else if (npdclUser.designationCode == CGM_DESIGNATION_CODE &&
        npdclUser.wing?.toLowerCase() == "pmm") {
      final status = inspectionTicketEntity.ticketStatus?.toLowerCase();

      if (status == "open") {
        isButtonVisible = true;
        buttonText = "Forward/Reject";
        buttonAction = _forwardRejectMethod;
      } else if (status == "closed") {
        isButtonVisible = false;
      } else if (status == "inspected") {
        isButtonVisible = true;
        buttonText = "APPROVE QTY & CLOSE TICKET";
        buttonAction = _approveQtyAndCloseTicket;
      } else {
        isButtonVisible = false;
      }
    }
    notifyListeners();
  }

  _submitInspectionReport() {}

  _forwardRejectMethod() {
    if (employeeMasterEntityList.isNotEmpty) {
      showAssignDialog();
    } else {
      getEmployeesOfSection();
    }
  }

  Future<void> getEmployeesOfSection() async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Fetching your staff...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee"
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.GET_INSPECTION_OFFICERS_URL, payload);
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
                jsonList =
                    []; // Fallback to empty list if the type is unexpected
              }
              final List<EmployeeMasterEntity> dataList = jsonList
                  .map((json) => EmployeeMasterEntity.fromJson(json))
                  .toList();
              employeeMasterEntityList.addAll(dataList);
              notifyListeners();
              showAssignDialog();
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

  Future<void> showAssignDialog() async {
    List<OptionList> inspectionOfficers = employeeMasterEntityList
        .map((e) => OptionList(
            optionId: e.empId,
            optionName: '${e.empName},${e.designation},${e.wing}'))
        .toList();
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
            child: AssignInspectionOfficerPage(
                inspectionTicketEntity: inspectionTicketEntity,
                inspectionOfficers: inspectionOfficers),
          ),
        );
      },
    );

    // Use the returned result
    if (result != null) {
      assignOfficer(result);
    }
  }

  Future<void> assignOfficer(result) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId": inspectionTicketEntity.ticketId,
      "empId": result["empId"],
      "scheduleDate": result["scheduleDate"]
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.ASSIGN_TICKET_URL, payload);
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
            showSuccessDialog(context, response.data['message'], () {
              Navigation.instance
                  .pushAndRemoveUntil(Routes.universalDashboardScreen);
            });
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

  _approveQtyAndCloseTicket() async {
    final result = await showDialog(
      context: context,
      builder: (context) => ApproveCloseTicketPage(
        inspectionTicketEntity: inspectionTicketEntity,
      ),
    );

    if (result != null) {
      closeTicket(result);
    }
  }

  Future<void> closeTicket(result) async {
    ProcessDialogHelper.showProcessDialog(
      context,
      message: "Please wait...",
    );

    final payload = {
      "token":
          SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey),
      "appId": "in.tsnpdcl.npdclemployee",
      "ticketId": inspectionTicketEntity.ticketId,
      "approvedQty": result
    };

    var response = await ApiProvider(baseUrl: Apis.PDMS_END_POINT_BASE_URL)
        .postApiCall(context, Apis.CLOSE_TICKET_URL, payload);
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
            showSuccessDialog(context, response.data['message'], () {
              Navigation.instance
                  .pushAndRemoveUntil(Routes.universalDashboardScreen);
            });
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
}
