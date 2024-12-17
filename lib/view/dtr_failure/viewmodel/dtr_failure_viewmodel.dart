import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/model/dtr_failure_menu_item.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_maintenance_menu_item.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class DtrFailureViewModel extends ChangeNotifier {
  final List<DtrFailureMenuItem> _dtrFailureMenuItems = [];

  List<DtrFailureMenuItem> get dtrFailureMenuItems => _dtrFailureMenuItems;

  // Constructor to initialize the items
  DtrFailureViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _dtrFailureMenuItems.addAll([
      DtrFailureMenuItem(
          title: GlobalConstants.dtrFailureReporting,
          iconAsset: Icons.post_add,
          cardColor: Colors.orange,
          routeName: routeName),
      DtrFailureMenuItem(
          title: GlobalConstants.viewFailureReports,
          iconAsset: Icons.assignment_late_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      DtrFailureMenuItem(
          title: GlobalConstants.viewRectifiedReports,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
