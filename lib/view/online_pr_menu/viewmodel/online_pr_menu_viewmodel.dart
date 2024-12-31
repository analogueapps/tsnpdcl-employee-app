import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';

class OnlinePrMenuViewModel extends ChangeNotifier {
  final List<SubMenuGridItem> _onlinePrMenuItems = [];

  List<SubMenuGridItem> get onlinePrMenuItems => _onlinePrMenuItems;

  // Constructor to initialize the items
  OnlinePrMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _onlinePrMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.onlineCollection,
          iconAsset: Icons.calculate,
          cardColor: Colors.orange,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.issueDuplicateReceipt,
          iconAsset: Icons.content_copy,
          cardColor: Colors.green,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.printLastPr,
          iconAsset: Icons.content_copy,
          cardColor: Colors.redAccent,
          routeName: routeName),
      SubMenuGridItem(
          title: GlobalConstants.reports,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
