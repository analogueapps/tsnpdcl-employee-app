import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      okLabel: 'Yes',
      cancelLabel: 'No',
      isDestructiveAction: true,
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
  }
}