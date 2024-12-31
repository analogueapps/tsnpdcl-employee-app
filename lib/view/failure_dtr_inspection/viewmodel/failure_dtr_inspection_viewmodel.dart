import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class FailureDtrInspectionViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _failureDtrInspectionMenuItems = [];

  List<SubMenuGridItem> get failureDtrInspectionMenuItems => _failureDtrInspectionMenuItems;

  // Constructor to initialize the items
  FailureDtrInspectionViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _failureDtrInspectionMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.dtrInspection,
          iconAsset: Icons.post_add,
          cardColor: Colors.orange,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.viewInspectionReports,
          iconAsset: Icons.assignment_late_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.viewClosedReports,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
