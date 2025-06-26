import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class NameAndAddressMenuScreenViewmodel extends ChangeNotifier {
  final List<SubMenuGridItem> _nameAddressMenuItems = [];

  List<SubMenuGridItem> get nameAddressItems => _nameAddressMenuItems;

  // Constructor to initialize the items
  NameAndAddressMenuScreenViewmodel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _nameAddressMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.createCorrespondence,
          iconAsset: Icons.computer,
          cardColor: Colors.orange,
          routeName: Routes.nameCreateCorrespondence),
      SubMenuGridItem(
          title: GlobalConstants.pendingAtEro,
          iconAsset: Icons.hourglass_bottom,
          cardColor: Colors.blue,
          routeName: Routes.nameAndAddressChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.completed,
          iconAsset: Icons.playlist_add_check,
          cardColor: Colors.green,
          routeName: Routes.nameAndAddressChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.rejectedByERO,
          iconAsset: Icons.close,
          cardColor: Colors.redAccent,
          routeName:  Routes.nameAndAddressChangeRequestList),
    ]);

    notifyListeners();
  }

Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName != Routes.nameCreateCorrespondence) {
      String status = '';
       if (title == GlobalConstants.pendingAtEro) {
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
