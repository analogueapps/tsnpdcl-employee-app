import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class PdmsViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _pdmsMenuItems = [];

  List<SubMenuGridItem> get pdmsMenuItems => _pdmsMenuItems;

  // Constructor to initialize the items
  PdmsViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _pdmsMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.createPoleIndent,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.orange,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.dis,
          iconAsset: Icons.local_shipping_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.pendingVerification,
          iconAsset: Icons.pending_actions_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.verified,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.mismatch,
          iconAsset: Icons.close,
          cardColor: Colors.blue,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
