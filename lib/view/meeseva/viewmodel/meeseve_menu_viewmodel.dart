import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class MeeseveMenuViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _meesevaMenuItems = [];

  List<SubMenuGridItem> get meesevaMenuItems => _meesevaMenuItems;

  // Constructor to initialize the items
  MeeseveMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _meesevaMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.daysPendingAbstract,
          iconAsset: Icons.assignment_late_rounded,
          cardColor: Colors.orange,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.lmWiseAbstract,
          iconAsset: Icons.summarize,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.searchApplication,
          iconAsset: Icons.search_rounded,
          cardColor: Colors.redAccent,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.pendingFcAllotmentByAe,
          iconAsset: Icons.pending_actions_rounded,
          cardColor: Colors.blue,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.underFeasibilityCheckByOm,
          iconAsset: Icons.hourglass_top_rounded,
          cardColor: Colors.amber,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.pendingForFeasibleByAe,
          iconAsset: Icons.check_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.pendingForNotFeasibleByAe,
          iconAsset: Icons.close_rounded,
          cardColor: Colors.red,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.metersToBeAllottedByAde,
          iconAsset: Icons.verified_user_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.pendingForNotFeasibleByAde,
          iconAsset: Icons.cancel_rounded,
          cardColor: Colors.red,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.metersToBeAllottedByAe,
          iconAsset: Icons.local_shipping_rounded,
          cardColor: Colors.cyan,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.metersToBeFixedByOmStaff,
          iconAsset: Icons.delivery_dining_rounded,
          cardColor: Colors.purple,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.metersInstalledToBeReleasedByAe,
          iconAsset: Icons.where_to_vote_rounded,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.releasedByAe,
          iconAsset: Icons.bolt_rounded,
          cardColor: Colors.yellow,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.rejected,
          iconAsset: Icons.cancel_rounded,
          cardColor: Colors.red,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
