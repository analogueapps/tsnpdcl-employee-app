import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';
import 'package:tsnpdcl_employee/view/ss_maintenance/model/ss_maintenance_grid_item.dart';

class SsMaintenanceViewModel extends ChangeNotifier {
  final List<SsMaintenanceGridItem> _ssMaintenanceMenuItems = [];

  List<SsMaintenanceGridItem> get ssMaintenanceMenuItems => _ssMaintenanceMenuItems;

  // Constructor to initialize the items
  SsMaintenanceViewModel() {
    _initializeItems();
  }

  // Add items with proper route names
  void _initializeItems() {
    _ssMaintenanceMenuItems.addAll([
      SsMaintenanceGridItem(
        title: GlobalConstants.inspectSS,
        iconAsset: Icons.inventory_outlined,
        cardColor: Colors.redAccent,
        routeName: "", // Define this in Routes
      ),
      SsMaintenanceGridItem(
        title: GlobalConstants.insOrPending,
        iconAsset: Icons.hourglass_top,
        cardColor: Colors.green,
        routeName: Routes.maintenanceDueScreen, // Route to MaintenanceDueScreen
      ),
      SsMaintenanceGridItem(
        title: GlobalConstants.mainFinished,
        iconAsset: Icons.check,
        cardColor: Colors.orange,
        routeName: Routes.maintenanceFinishedScreen, // Define this in Routes
      ),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    // Navigate to the specified route
    if (routeName == Routes.maintenanceDueScreen) {
      Navigation.instance.navigateTo(routeName);
    }
    else if (routeName == Routes.maintenanceFinishedScreen) {
      Navigation.instance.navigateTo(routeName);
    }
    else {
      // Handle cases where routeName might be empty (optional fallback)
      print('No route defined for $title');
    }
  }
}


