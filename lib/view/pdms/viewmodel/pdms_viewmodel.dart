import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/online_pr_menu/model/online_pr_menu_item.dart';
import 'package:tsnpdcl_employee/view/pdms/model/pdms_menu_item.dart';

class PdmsViewModel extends ChangeNotifier {
  final List<PdmsMenuItem> _pdmsMenuItems = [];

  List<PdmsMenuItem> get pdmsMenuItems => _pdmsMenuItems;

  // Constructor to initialize the items
  PdmsViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _pdmsMenuItems.addAll([
      PdmsMenuItem(
          title: GlobalConstants.createPoleIndent,
          iconAsset: Icons.list_alt_outlined,
          cardColor: Colors.orange,
          routeName: routeName),
      PdmsMenuItem(
          title: GlobalConstants.dis,
          iconAsset: Icons.local_shipping_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      PdmsMenuItem(
          title: GlobalConstants.pendingVerification,
          iconAsset: Icons.pending_actions_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      PdmsMenuItem(
          title: GlobalConstants.verified,
          iconAsset: Icons.check_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
      PdmsMenuItem(
          title: GlobalConstants.mismatch,
          iconAsset: Icons.close,
          cardColor: Colors.blue,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
