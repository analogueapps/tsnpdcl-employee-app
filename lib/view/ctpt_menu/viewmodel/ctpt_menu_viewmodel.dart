import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/ctpt_menu/model/ctpt_menu_item.dart';
import 'package:tsnpdcl_employee/view/dtr_failure/model/dtr_failure_menu_item.dart';
import 'package:tsnpdcl_employee/view/dtr_maintenance/model/dtr_maintenance_menu_item.dart';
import 'package:tsnpdcl_employee/view/failure_dtr_inspection/model/failure_dtr_inspection_menu_item.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class CtptMenuViewModel extends ChangeNotifier {
  final List<CtptMenuItem> _ctptMenuItems = [];

  List<CtptMenuItem> get ctptMenuItems => _ctptMenuItems;

  // Constructor to initialize the items
  CtptMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _ctptMenuItems.addAll([
      CtptMenuItem(
          title: GlobalConstants.reportCtPtFailure,
          routeName: routeName),
      CtptMenuItem(
          title: GlobalConstants.viewCtPtReportedList,
          routeName: routeName),
      CtptMenuItem(
          title: GlobalConstants.viewCtPtFailureConfirmedList,
          routeName: routeName),
      CtptMenuItem(
          title: GlobalConstants.viewCtPtIssuedList,
          routeName: routeName),
      CtptMenuItem(
          title: GlobalConstants.viewCtPtReplacedList,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
