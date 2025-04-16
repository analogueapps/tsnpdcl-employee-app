import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_list_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class CtptMenuViewModel extends ChangeNotifier {
  final List<SubMenuListItem> _ctptMenuItems = [];

  List<SubMenuListItem> get ctptMenuItems => _ctptMenuItems;

  // Constructor to initialize the items
  CtptMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _ctptMenuItems.addAll([
      SubMenuListItem(
          title: GlobalConstants.reportCtPtFailure,
          routeName: Routes.reportCtPtFailure),
      SubMenuListItem(
          title: GlobalConstants.viewCtPtReportedList,
          routeName: Routes.viewCtPtReportList),
      SubMenuListItem(
          title: GlobalConstants.viewCtPtFailureConfirmedList,
          routeName: Routes.viewFailureConfirmedList),
      SubMenuListItem(
          title: GlobalConstants.viewCtPtIssuedList,
          routeName:Routes.viewIssuedList),
      SubMenuListItem(
          title: GlobalConstants.viewCtPtReplacedList,
          routeName: Routes.viewReplacedList),
    ]);

    notifyListeners();
  }
}
