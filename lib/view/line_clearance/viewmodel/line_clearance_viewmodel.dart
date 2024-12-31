import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class LineClearanceViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _lineClearanceItems = [];

  List<SubMenuGridItem> get lineClearanceItems => _lineClearanceItems;

  // Constructor to initialize the items
  LineClearanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _lineClearanceItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.lcMasterDataTitle,
          iconAsset: Icons.bar_chart,
          cardColor: Colors.orange,
          routeName: Routes.lcMasterSsListScreen
      ),
      SubMenuGridItem(
          title: GlobalConstants.pendingAeAde,
          iconAsset: Icons.pending_actions_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.ongoingLc,
          iconAsset: Icons.move_up_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.closedLc,
          iconAsset: Icons.cancel_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
