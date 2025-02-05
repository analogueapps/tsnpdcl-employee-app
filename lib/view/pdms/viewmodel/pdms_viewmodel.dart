import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class PdmsViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _pdmsMenuItems = [];

  List<SubMenuGridItem> get pdmsMenuItems => _pdmsMenuItems;

  // Constructor to initialize the items
  PdmsViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _pdmsMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.createPoleIndent,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.orange,
          routeName: Routes.createPoleIndentsScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.dis,
          iconAsset: Icons.local_shipping_outlined,
          cardColor: Colors.green,
          routeName: Routes.viewDispatchInstructionsScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.pendingVerification,
          iconAsset: Icons.pending_actions_outlined,
          cardColor: Colors.redAccent,
          routeName: Routes.viewPoleDumpedLocationScreen,
      ),
      SubMenuGridItem(
          title: GlobalConstants.verified,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.yellow,
          routeName: Routes.viewPoleDumpedLocationScreen,
      ),
      SubMenuGridItem(
          title: GlobalConstants.mismatch,
          iconAsset: Icons.close,
          cardColor: Colors.blue,
          routeName: Routes.viewPoleDumpedLocationScreen,
      ),
    ]);

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
