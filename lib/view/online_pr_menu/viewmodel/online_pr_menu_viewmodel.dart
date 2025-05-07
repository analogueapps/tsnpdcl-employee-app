import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

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
          routeName: Routes.onlineCollection),
      SubMenuGridItem(
          title: GlobalConstants.issueDuplicateReceipt,
          iconAsset: Icons.content_copy,
          cardColor: Colors.green,
          routeName: Routes.issueDuplicateReceipt),
      SubMenuGridItem(
          title: GlobalConstants.printLastPr,
          iconAsset: Icons.content_copy,
          cardColor: Colors.redAccent,
          routeName: Routes.printLastPR),
      SubMenuGridItem(
          title: GlobalConstants.reports,
          iconAsset: Icons.view_list,
          cardColor: Colors.yellow,
          routeName: Routes.onlinePRReports),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName == Routes.onlinePrMenuScreen) {
      String status = '';
      if (title == GlobalConstants.issueDuplicateReceipt) {
        status = StatusConstants.ISSUED_DUPLICATE_RECEIPT;
      } else if (title == GlobalConstants.onlineCollection) {
        status = StatusConstants.ONLINE_COLLECTION;
      }else if (title == GlobalConstants.printLastPr) {
        status = StatusConstants.PRINT_LAST_PR;
      } else if (title == GlobalConstants.reports) {
        status = StatusConstants.REPORTS;
      }
      Navigation.instance.navigateTo(routeName, args: status);
    } else {
      Navigation.instance.navigateTo(routeName);
    }
  }
}
