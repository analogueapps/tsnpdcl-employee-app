import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';

class OnlinePrMenuViewModel extends ChangeNotifier {
  final List<OnlinePrMenuItem> _onlinePrMenuItems = [];

  List<OnlinePrMenuItem> get onlinePrMenuItems => _onlinePrMenuItems;

  // Constructor to initialize the items
  OnlinePrMenuViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _onlinePrMenuItems.addAll([
      OnlinePrMenuItem(
          title: GlobalConstants.onlineCollection,
          iconAsset: Icons.calculate,
          cardColor: Colors.orange,
          routeName: routeName),
      OnlinePrMenuItem(
          title: GlobalConstants.issueDuplicateReceipt,
          iconAsset: Icons.content_copy,
          cardColor: Colors.green,
          routeName: routeName),
      OnlinePrMenuItem(
          title: GlobalConstants.printLastPr,
          iconAsset: Icons.content_copy,
          cardColor: Colors.redAccent,
          routeName: routeName),
      OnlinePrMenuItem(
          title: GlobalConstants.reports,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
