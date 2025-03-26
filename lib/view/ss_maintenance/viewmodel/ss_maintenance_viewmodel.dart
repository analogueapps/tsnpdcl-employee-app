import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/model/ss_maintenance_grid_item.dart';

class SsMaintenanceViewModel extends ChangeNotifier {
  final List<SsMaintenanceGridItem> _ssMaintenanceMenuItems = [];

  List<SsMaintenanceGridItem> get ssMaintenanceMenuItems => _ssMaintenanceMenuItems;

  // Constructor to initialize the items
  SsMaintenanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _ssMaintenanceMenuItems.addAll([
      SsMaintenanceGridItem(
        title: GlobalConstants.inspectSS,
        iconAsset: Icons.inventory_outlined,
        cardColor: Colors.redAccent,
        // routeName: Routes.viewPoleDumpedLocationScreen,
      ),
      SsMaintenanceGridItem(
        title: GlobalConstants.insOrPending,
        iconAsset: Icons.hourglass_top,
        cardColor: Colors.green,
        // routeName: Routes.viewDispatchInstructionsScreen
      ),
      SsMaintenanceGridItem(
        title: GlobalConstants.mainFinished,
        iconAsset: Icons.check,
        cardColor: Colors.orange,
        // routeName: Routes.createPoleIndentsScreen
      ),
    ]);

    notifyListeners();
  }
}
