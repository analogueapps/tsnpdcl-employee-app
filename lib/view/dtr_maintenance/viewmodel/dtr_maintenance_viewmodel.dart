import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_maintenance_menu_item.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class DtrMaintenanceViewModel extends ChangeNotifier {
  final List<DtrMaintenanceMenuItem> _dtrMaintenanceMenuItems = [];

  List<DtrMaintenanceMenuItem> get dtrMaintenanceMenuItems => _dtrMaintenanceMenuItems;

  // Constructor to initialize the items
  DtrMaintenanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _dtrMaintenanceMenuItems.addAll([
      DtrMaintenanceMenuItem(
          title: GlobalConstants.assignForInspection,
          iconAsset: Icons.assignment_outlined,
          cardColor: Colors.orange,
          routeName: routeName),
      DtrMaintenanceMenuItem(
          title: GlobalConstants.underInspection,
          iconAsset: Icons.hourglass_top_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      DtrMaintenanceMenuItem(
          title: GlobalConstants.inspectionCompleted,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      DtrMaintenanceMenuItem(
          title: GlobalConstants.toBeMaintained,
          iconAsset: Icons.build_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
      DtrMaintenanceMenuItem(
          title: GlobalConstants.maintenanceFinished,
          iconAsset: Icons.done_all_outlined,
          cardColor: Colors.blue,
          routeName: routeName),
      DtrMaintenanceMenuItem(
          title: GlobalConstants.maintenanceStats,
          iconAsset: Icons.query_stats_outlined,
          cardColor: Colors.pink,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
