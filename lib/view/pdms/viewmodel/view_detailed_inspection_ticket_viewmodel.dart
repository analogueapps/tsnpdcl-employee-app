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
import 'package:tsnpdcl_employee/utils/designation_utils.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_codes.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/pdms/model/inspection_ticket_entity.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pole_request_indent_entity.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/view/pdms/view/forward_or_reject_indent_dialog.dart';
import 'package:tsnpdcl_employee/view/pdms/view/otp_request_and_validate_dialog.dart';
import 'package:tsnpdcl_employee/widget/fill_text_form_field.dart';
import 'package:tsnpdcl_employee/widget/primary_button.dart';

class ViewDetailedInspectionTicketViewmodel extends ChangeNotifier {
  final BuildContext context;
  final String data;
  late InspectionTicketEntity inspectionTicketEntity;
  late NpdclUser npdclUser;

  bool isButtonVisible = false;
  String buttonText = "";
  Color buttonColor = Colors.transparent;
  Function? buttonAction;

  ViewDetailedInspectionTicketViewmodel({required this.context, required this.data}) {
    inspectionTicketEntity = InspectionTicketEntity.fromJson(jsonDecode(data));
    _loadUser();
  }

  void _loadUser() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    npdclUser = user[0];
    notifyListeners();
    _updateButtonState();
  }

  void _updateButtonState() {
    if (npdclUser.designationCode == CGM_DESIGNATION_CODE && npdclUser.wing?.toLowerCase() == "pmm") {
      isButtonVisible = true;
    } else {
      isButtonVisible = false;
    }

    // if (DesignationUtils.isAde(npdclUser.designationCode!.toInt())) {
    //   isButtonVisible = true;
    //   buttonText = "FORWARD TO STORES";
    //   buttonColor = CommonColors.deepBlue;
    //   //buttonAction = _forwardToStores;
    // } else if (DesignationUtils.isAe(npdclUser.designationCode!.toInt()) &&
    //     DesignationUtils.isOperationWing(checkNull(npdclUser.wing))) {
    //   isButtonVisible = true;
    //   buttonText = "CANCEL INDENT";
    //   buttonColor = CommonColors.deepRed;
    //   //buttonAction = _showCancelIndentDialog;
    // } else if (DesignationUtils.isAe(npdclUser.designationCode!.toInt()) &&
    //     DesignationUtils.isStoreWing(checkNull(npdclUser!.wing)) &&
    //     (indentStatus == StatusCodes.PoleIndentStatus.AE_OD_STR ||
    //         indentStatus == StatusCodes.PoleIndentStatus.PAR_APPROVED)) {
    //   isButtonVisible = true;
    //   buttonText = "APPROVE/REJECT";
    //   buttonColor = CommonColors.colorPrimary;
    //   buttonAction = _showApprovalDialog;
    // } else if (DesignationUtils.isAde(npdclUser.designationCode!.toInt()) &&
    //     DesignationUtils.isStoreWing(checkNull(npdclUser!.wing)) &&
    //     indentStatus == StatusCodes.PoleIndentStatus.ADE_STR) {
    //   isButtonVisible = true;
    //   buttonText = "APPROVE/REJECT";
    //   buttonColor = CommonColors.colorPrimary;
    //   buttonAction = _showApprovalDialog;
    // } else {
    //   isButtonVisible = false;
    // }
    notifyListeners();
  }
}
