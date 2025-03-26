import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart'; // Import dialog method
import 'package:tsnpdcl_employee/utils/general_routes.dart'; // Import Routes
import 'package:tsnpdcl_employee/view/rfss/model/list_dialog_item.dart';

class MiddlePolesViewModel extends ChangeNotifier {
  // List of menu items for the Middle Poles Screen
  final List<String> _menuItems = [
    GlobalConstants.newStr,
    GlobalConstants.pendingList,
    GlobalConstants.completedList,
  ];

  List<String> get menuItems => _menuItems;

  // Method to handle item click
  Future<void> mpNewMenuItemClicked(BuildContext context, String title) async {
    if (title == GlobalConstants.newStr) {
      // List of dialog items for "New Str"
      List<listDialogItem> listDialogItemArray = [];
      listDialogItemArray.addAll([
        listDialogItem(
          title: "33KV Middle Pole",
          routeName: Routes.reportsScreen,
        ),
        listDialogItem(
          title: "11KV/LT Middle Pole",
          routeName: Routes.reportsScreen,
        ),
      ]);
      // Show the custom dialog
      showCustomListRfssDialog(context, listDialogItemArray, heading: GlobalConstants.networkType);
    }
  }
}
