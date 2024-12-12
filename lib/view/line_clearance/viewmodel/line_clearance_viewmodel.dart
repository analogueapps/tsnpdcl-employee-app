import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/universal_dashboard_item.dart';

class LineClearanceViewModel extends ChangeNotifier {
  final List<UniversalDashboardItem> _lineClearanceItems = [];

  List<UniversalDashboardItem> get lineClearanceItems => _lineClearanceItems;

  // Constructor to initialize the items
  LineClearanceViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _lineClearanceItems.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.lcMasterDataTitle,
          imageAsset: Assets.lcMasterData,
          routeName: routeName
      ),
      UniversalDashboardItem(
          title: GlobalConstants.pendingAeAde,
          imageAsset: Assets.pendingAeAde,
          routeName: routeName
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ongoingLc,
          imageAsset: Assets.ongoingLc,
          routeName: routeName
      ),
      UniversalDashboardItem(
          title: GlobalConstants.closedLc,
          imageAsset: Assets.closedLc,
          routeName: routeName
      ),
    ]);

    notifyListeners();
  }
}
