import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class WrongBillingMenuScreenViewmodel extends ChangeNotifier {
  final List<SubMenuGridItem> _wrongBillingMenuItems = [];

  List<SubMenuGridItem> get wrongBilling => _wrongBillingMenuItems;

  // Constructor to initialize the items
  WrongBillingMenuScreenViewmodel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _wrongBillingMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.createCorrespondence,
          iconAsset: Icons.computer,
          cardColor: Colors.orange,
          routeName: Routes.appBillingScreen),
      SubMenuGridItem(
          title: GlobalConstants.pendingAtEro,
          iconAsset: Icons.hourglass_bottom,
          cardColor: Colors.blue,
          routeName: Routes.revokeOfServicesChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.completed,
          iconAsset: Icons.playlist_add_check,
          cardColor: Colors.green,
          routeName: Routes.revokeOfServicesChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.rejectedByERO,
          iconAsset: Icons.close,
          cardColor: Colors.redAccent,
          routeName:  Routes.revokeOfServicesChangeRequestList),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName != Routes.revokingOfServicesScreen) {
      String status = '';
      if (title == GlobalConstants.createCorrespondence) { //revokeOfServices
        status ="";
      }else if (title == GlobalConstants.pendingAtEro) { //revokeOfServices
        status = StatusConstants.TYPE_PENDING_ERO;
      }else if (title == GlobalConstants.completed) {
        status = StatusConstants.TYPE_COMPLETED;
      } else if (title == GlobalConstants.rejectedByERO) {
        status = StatusConstants.TYPE_REJECTED_ERO;
      }
      Navigation.instance.navigateTo(routeName, args: status);
      print("Navigating with status");
    } else {
      Navigation.instance.navigateTo(routeName);
      print("Navigating without status");
    }
  }
}
