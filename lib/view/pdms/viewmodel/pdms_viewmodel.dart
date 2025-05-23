import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';

class PdmsViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _pdmsMenuItems = [];

  List<SubMenuGridItem> get pdmsMenuItems => _pdmsMenuItems;

  // Constructor to initialize the items
  PdmsViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    final npdclUser = user[0];

    const String routeName = '';

    // Simulate currentUser values
    String userWing = npdclUser.wing!.toLowerCase();
    int userCode = npdclUser.designationCode!.toInt();

    if (userWing == "operation" && (userCode == 155 || userCode == 150)) {
      _pdmsMenuItems.addAll([
        SubMenuGridItem(
            title: GlobalConstants.createPoleIndent,
            iconAsset: Icons.edit_note,
            cardColor: Colors.teal,
            routeName: Routes.createPoleIndentsScreen
        ),
        SubMenuGridItem(
            title: GlobalConstants.dis,
            iconAsset: Icons.local_shipping,
            cardColor: Colors.amber.shade400,
            routeName: Routes.viewDispatchInstructionsScreen
        ),
        SubMenuGridItem(
          title: GlobalConstants.pendingVerification,
          iconAsset: Icons.pending_actions,
          cardColor: Colors.red.shade400,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
        SubMenuGridItem(
          title: GlobalConstants.verified,
          iconAsset: Icons.check,
          cardColor: Colors.green.shade400,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
        SubMenuGridItem(
          title: GlobalConstants.mismatch,
          iconAsset: Icons.close,
          cardColor: Colors.red.shade900,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
      ]);
    } else if (userWing == "operation" && userCode == 125) {
      _pdmsMenuItems.addAll([
        SubMenuGridItem(
            title: GlobalConstants.viewPoleIndent,
            iconAsset: Icons.edit_note,
            cardColor: Colors.teal,
            routeName: Routes.createPoleIndentsScreen
        ),
        // SubMenuGridItem(
        //     title: GlobalConstants.dis,
        //     iconAsset: Icons.local_shipping,
        //     cardColor: Colors.amber.shade400,
        //     routeName: Routes.viewDispatchInstructionsScreen
        // ),
        // SubMenuGridItem(
        //   title: GlobalConstants.pendingVerification,
        //   iconAsset: Icons.pending_actions,
        //   cardColor: Colors.red.shade400,
        //   routeName: Routes.viewPoleDumpedLocationScreen,
        // ),
        // SubMenuGridItem(
        //   title: GlobalConstants.verified,
        //   iconAsset: Icons.check,
        //   cardColor: Colors.green.shade400,
        //   routeName: Routes.viewPoleDumpedLocationScreen,
        // ),
        // SubMenuGridItem(
        //   title: GlobalConstants.mismatch,
        //   iconAsset: Icons.close,
        //   cardColor: Colors.red.shade900,
        //   routeName: Routes.viewPoleDumpedLocationScreen,
        // ),
      ]);
    } else if (userWing == "store") {
      _pdmsMenuItems.addAll([
        SubMenuGridItem(
            title: GlobalConstants.viewPurchaseOrders,
            iconAsset: Icons.shopping_cart,
            cardColor: Colors.blue.shade400,
            routeName: routeName
        ),
        SubMenuGridItem(
            title: GlobalConstants.viewPoleIndent,
            iconAsset: Icons.edit_note,
            cardColor: Colors.teal,
            routeName: routeName
        ),
        SubMenuGridItem(
            title: GlobalConstants.dis,
            iconAsset: Icons.local_shipping,
            cardColor: Colors.amber.shade400,
            routeName: Routes.viewDispatchInstructionsScreen
        ),
        SubMenuGridItem(
          title: GlobalConstants.pendingVerification,
          iconAsset: Icons.pending_actions,
          cardColor: Colors.red.shade400,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
        SubMenuGridItem(
          title: GlobalConstants.verified,
          iconAsset: Icons.check,
          cardColor: Colors.green.shade400,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
        SubMenuGridItem(
          title: GlobalConstants.mismatch,
          iconAsset: Icons.close,
          cardColor: Colors.red.shade900,
          routeName: Routes.viewPoleDumpedLocationScreen,
        ),
      ]);
    }

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName == Routes.viewPoleDumpedLocationScreen) {
      String status = '';
      if (title == GlobalConstants.pendingVerification) {
        status = StatusConstants.PENDING_DUMPS;
      } else if (title == GlobalConstants.verified) {
        status = StatusConstants.VERIFED_DUMPS;
      } else if (title == GlobalConstants.mismatch) {
        status = StatusConstants.MISMATCH_DUMPS;
      }
      Navigation.instance.navigateTo(routeName, args: status);
    } else {
      Navigation.instance.navigateTo(routeName);
    }
  }
}
