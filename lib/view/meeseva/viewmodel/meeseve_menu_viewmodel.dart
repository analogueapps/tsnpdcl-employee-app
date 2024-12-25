import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/meeseva/model/meeseva_menu_item.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class MeeseveMenuViewModel extends ChangeNotifier {
  final List<MeesevaMenuItem> _meesevaMenuItems = [];

  List<MeesevaMenuItem> get meesevaMenuItems => _meesevaMenuItems;

  // Constructor to initialize the items
  MeeseveMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _meesevaMenuItems.addAll([
      MeesevaMenuItem(
          title: GlobalConstants.daysPendingAbstract,
          iconAsset: Icons.read_more,
          cardColor: Colors.orange,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.lmWiseAbstract,
          iconAsset: Icons.content_copy,
          cardColor: Colors.green,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.searchApplication,
          iconAsset: Icons.content_copy,
          cardColor: Colors.redAccent,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingFcAllotmentByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.underFeasibilityCheckByOm,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForFeasibleByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForNotFeasibleByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeAllottedByAde,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForNotFeasibleByAde,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeAllottedByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeFixedByOmStaff,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersInstalledToBeReleasedByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.releasedByAe,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.rejected,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
