import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class DtrMaintenanceViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _dtrMaintenanceMenuItems = [];

  List<SubMenuGridItem> get dtrMaintenanceMenuItems => _dtrMaintenanceMenuItems;

  // Constructor to initialize the items
  DtrMaintenanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _dtrMaintenanceMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.assignForInspection,
          iconAsset: Icons.assignment_outlined,
          cardColor: Colors.orange,
          routeName: Routes.dtrMasterListScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.underInspection,
          iconAsset: Icons.hourglass_top_outlined,
          cardColor: Colors.green,
          routeName: Routes.dtrInspectionListScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.inspectionCompleted,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.redAccent,
          routeName: Routes.dtrInspectionListScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.toBeMaintained,
          iconAsset: Icons.build_outlined,
          cardColor: Colors.yellow,
          routeName: Routes.dtrInspectionListScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.maintenanceFinished,
          iconAsset: Icons.done_all_outlined,
          cardColor: Colors.blue,
          routeName: Routes.dtrInspectionListScreen
      ),
      // SubMenuGridItem(
      //     title: GlobalConstants.maintenanceStats,
      //     iconAsset: Icons.query_stats_outlined,
      //     cardColor: Colors.pink,
      //     routeName: Routes.dtrInspectionListScreen
      // ),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName == Routes.dtrInspectionListScreen) {
      String status = '';
      if (title == GlobalConstants.underInspection) {
        status = StatusConstants.TYPE_PENDING_INSPECTION;
      } else if (title == GlobalConstants.inspectionCompleted) {
        status = StatusConstants.TYPE_INSPECTION_DONE;
      } else if (title == GlobalConstants.toBeMaintained) {
        status = StatusConstants.TYPE_TO_BE_MAINTAINED;
      } else if (title == GlobalConstants.maintenanceFinished) {
        status = StatusConstants.TYPE_MAINTENANCE_DONE;
      }
      // else if (title == GlobalConstants.maintenanceStats) {
      //   status = StatusConstants.MISMATCH_DUMPS;
      // }
      Navigation.instance.navigateTo(routeName, args: status);
    } else {
      Navigation.instance.navigateTo(routeName);
    }
  }
}
