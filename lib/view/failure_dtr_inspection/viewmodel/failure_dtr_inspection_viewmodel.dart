import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/model/dtr_failure_menu_item.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_maintenance_menu_item.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/model/failure_dtr_inspection_menu_item.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class FailureDtrInspectionViewModel extends ChangeNotifier {
  final List<FailureDtrInspectionMenuItem> _failureDtrInspectionMenuItems = [];

  List<FailureDtrInspectionMenuItem> get failureDtrInspectionMenuItems => _failureDtrInspectionMenuItems;

  // Constructor to initialize the items
  FailureDtrInspectionViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _failureDtrInspectionMenuItems.addAll([
      FailureDtrInspectionMenuItem(
          title: GlobalConstants.dtrInspection,
          iconAsset: Icons.post_add,
          cardColor: Colors.orange,
          routeName: routeName),
      FailureDtrInspectionMenuItem(
          title: GlobalConstants.viewInspectionReports,
          iconAsset: Icons.assignment_late_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      FailureDtrInspectionMenuItem(
          title: GlobalConstants.viewClosedReports,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
