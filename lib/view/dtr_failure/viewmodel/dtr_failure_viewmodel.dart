import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class DtrFailureViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _dtrFailureMenuItems = [];

  List<SubMenuGridItem> get dtrFailureMenuItems => _dtrFailureMenuItems;

  // Constructor to initialize the items
  DtrFailureViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _dtrFailureMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.dtrFailureReporting,
          iconAsset: Icons.post_add,
          cardColor: Colors.orange,
          routeName: Routes.dtrFailureReportingScreen),
      SubMenuGridItem(
          title: GlobalConstants.viewFailureReports,
          iconAsset: Icons.assignment_late_outlined,
          cardColor: Colors.green,
          routeName: Routes.viewFailureReports),
      SubMenuGridItem(
          title: GlobalConstants.viewRectifiedReports,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.redAccent,
          routeName:Routes.dtrFailureRectifiedScreen),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName == Routes.dtrFailureScreen) {
      String status = '';
      if (title == GlobalConstants.dtrFailureReporting) {
        status = StatusConstants.TYPE_FAILURE_REPORTS;
      } else if (title == GlobalConstants.viewFailureReports) {
        status = StatusConstants.TYPE_VIEW_REPORTS;
      } else if (title == GlobalConstants.viewRectifiedReports) {
        status = StatusConstants.TYPE_VIEW_RECTIFIED;
      }
      Navigation.instance.navigateTo(routeName, args: status);
    } else {
      Navigation.instance.navigateTo(routeName);
    }
  }

}
