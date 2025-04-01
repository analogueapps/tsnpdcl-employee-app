import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/global_list_dialog_item.dart';
import 'package:tsnpdcl_employee/view/rfss/model/list_dialog_item.dart';

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
    await SharedPreferenceHelper.clearData();
    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
  }
}

Future<void> showSessionExpiredDialog(BuildContext context) async {
  final result = await showOkAlertDialog(
      context: context,
      title: 'Session Expired',
      message: 'Your session has expired. Please log in again to continue.',
      okLabel: 'Okay',
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    await SharedPreferenceHelper.clearData();
    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
  }
}

Future<void> showAlertDialog(BuildContext context, String message) async {
  final result = await showOkAlertDialog(
      context: context,
      title: "Alert",
      message: message,
      okLabel: "OK",
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    Navigation.instance.canPop();
  }
}

Future<void> showErrorDialog(BuildContext context, String message) async {
  final result = await showOkAlertDialog(
      context: context,
      title: "Error",
      message: message,
      okLabel: "OK",
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    Navigation.instance.canPop();
  }
}

Future<void> showSuccessDialog(BuildContext context, String message, VoidCallback onPressed) async {
  final result = await showOkAlertDialog(
      context: context,
      title: "Success",
      message: message,
      okLabel: "OK",
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    Navigation.instance.canPop();
    onPressed();
  }
}

Future<void> showAlertActionDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String okLabel,
  String cancelLabel = "Cancel",
  required VoidCallback onPressed,
  VoidCallback? onCancelPressed,
}) async {
  final result = await showOkCancelAlertDialog(
      context: context,
      title: title,
      message: message,
      okLabel: okLabel,
      cancelLabel: cancelLabel,
      isDestructiveAction: true,
      barrierDismissible: false
  );

  if (result == OkCancelResult.ok) {
    Navigation.instance.canPop();
    onPressed();
  } else if (result == OkCancelResult.cancel && onCancelPressed != null) {
    Navigation.instance.canPop();
    onCancelPressed();
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
                  if(globalListDialogItem[index].title == "CT PT Failure Reports") {
                    Navigation.instance.navigateTo(globalListDialogItem[index].routeName, args: Apis.GET_CTPT_BAR_GRAPH_DATA_URL);
                  } else if(globalListDialogItem[index].title == "Middle Poles Reports") {
                    Navigation.instance.navigateTo(globalListDialogItem[index].routeName, args: Apis.GET_MIDDLE_POLES_BAR_GRAPH_DATA_URL);
                  } else if(globalListDialogItem[index].title == "Maintenance Reports") {
                    Navigation.instance.navigateTo(globalListDialogItem[index].routeName, args: Apis.GET_MAINTENANCE_BAR_GRAPH_DATA_URL);
                  } else {
                    Navigation.instance.navigateTo(globalListDialogItem[index].routeName);
                  }
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

// RFSS, middle poles Screen dialog box * swetha
void showCustomListRfssDialog(BuildContext context, List<listDialogItem> listDialogItem, {String? heading}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing the dialog by tapping outside
    builder: (context) {
      return AlertDialog(
        title: heading != null
            ? Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ) // Show the custom heading if provided
            : const Text("Select an Option"), // Default heading if no heading is provided
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listDialogItem.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  listDialogItem[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  // Navigate to the route specified in the listDialogItem
                  Navigation.instance.navigateTo(listDialogItem[index].routeName);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
// void showCustomListRfssDialog(BuildContext context, List<listDialogItem> listDialogItem, {String? heading}) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevents dismissing the dialog by tapping outside
//     builder: (context) {
//       return AlertDialog(
//         title: heading != null
//             ? Text(
//           heading,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold
//           ),) // Show the custom heading if provided
//             : const Text("Select an Option"), // Default heading if no heading is provided
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: listDialogItem.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(
//                   listDialogItem[index].title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Add your navigation logic here, depending on your requirements
//                 },
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }
