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
          iconAsset: Icons.assignment_late_rounded,
          cardColor: Colors.orange,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.lmWiseAbstract,
          iconAsset: Icons.summarize,
          cardColor: Colors.green,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.searchApplication,
          iconAsset: Icons.search_rounded,
          cardColor: Colors.redAccent,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingFcAllotmentByAe,
          iconAsset: Icons.pending_actions_rounded,
          cardColor: Colors.blue,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.underFeasibilityCheckByOm,
          iconAsset: Icons.hourglass_top_rounded,
          cardColor: Colors.amber,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForFeasibleByAe,
          iconAsset: Icons.check_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForNotFeasibleByAe,
          iconAsset: Icons.close_rounded,
          cardColor: Colors.red,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeAllottedByAde,
          iconAsset: Icons.verified_user_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.pendingForNotFeasibleByAde,
          iconAsset: Icons.cancel_rounded,
          cardColor: Colors.red,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeAllottedByAe,
          iconAsset: Icons.local_shipping_rounded,
          cardColor: Colors.cyan,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersToBeFixedByOmStaff,
          iconAsset: Icons.delivery_dining_rounded,
          cardColor: Colors.purple,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.metersInstalledToBeReleasedByAe,
          iconAsset: Icons.where_to_vote_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.releasedByAe,
          iconAsset: Icons.bolt_rounded,
          cardColor: Colors.yellow,
          routeName: routeName),
      MeesevaMenuItem(
          title: GlobalConstants.rejected,
          iconAsset: Icons.cancel_rounded,
          cardColor: Colors.red,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
