import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/universal_dashboard_item.dart';
import 'package:tsnpdcl_employee/view/line_clearance/model/line_clearance_menu_item.dart';

class LineClearanceViewModel extends ChangeNotifier {
  final List<LineClearanceMenuItem> _lineClearanceItems = [];

  List<LineClearanceMenuItem> get lineClearanceItems => _lineClearanceItems;

  // Constructor to initialize the items
  LineClearanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _lineClearanceItems.addAll([
      LineClearanceMenuItem(
          title: GlobalConstants.lcMasterDataTitle,
          iconAsset: Icons.bar_chart,
          cardColor: Colors.orange,
          routeName: routeName),
      LineClearanceMenuItem(
          title: GlobalConstants.pendingAeAde,
          iconAsset: Icons.pending_actions_outlined,
          cardColor: Colors.green,
          routeName: routeName),
      LineClearanceMenuItem(
          title: GlobalConstants.ongoingLc,
          iconAsset: Icons.move_up_outlined,
          cardColor: Colors.redAccent,
          routeName: routeName),
      LineClearanceMenuItem(
          title: GlobalConstants.closedLc,
          iconAsset: Icons.cancel_outlined,
          cardColor: Colors.yellow,
          routeName: routeName),
    ]);

    notifyListeners();
  }
}
