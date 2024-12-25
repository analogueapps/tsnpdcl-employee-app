import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/global_list_dialog_item.dart';

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

// Custom List Items in dialog
Future<void> showCustomListDialog(BuildContext context, List<GlobalListDialogItem> globalListDialogItem) async {
  return showDialog(
    context: context,
    barrierDismissible: isFalse,
    builder: (context) {
      return AlertDialog(
        title: const Text("Choose Option", style: TextStyle(fontWeight: FontWeight.w700),),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: globalListDialogItem.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(globalListDialogItem[index].title),
                onTap: () {
                  //onOptionSelected(index);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}