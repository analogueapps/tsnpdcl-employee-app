import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

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
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.underInspection,
          iconAsset: Icons.hourglass_top_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.inspectionCompleted,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.toBeMaintained,
          iconAsset: Icons.build_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.maintenanceFinished,
          iconAsset: Icons.done_all_outlined,
          cardColor: Colors.blue,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.maintenanceStats,
          iconAsset: Icons.query_stats_outlined,
          cardColor: Colors.pink,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
