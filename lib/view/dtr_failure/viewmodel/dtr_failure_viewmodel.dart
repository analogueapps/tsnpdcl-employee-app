import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

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
          routeName: Routes.failureReporting),
      SubMenuGridItem(
          title: GlobalConstants.viewFailureReports,
          iconAsset: Icons.assignment_late_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.viewRectifiedReports,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
