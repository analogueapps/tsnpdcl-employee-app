import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/model/sub_menu_grid_item.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/status_constants.dart';

class DismantleOfServiceMenuScreenViewmodel extends ChangeNotifier {
  final List<SubMenuGridItem> _dismantleMenuItems = [];

  List<SubMenuGridItem> get dismantleService => _dismantleMenuItems;

  // Constructor to initialize the items
  DismantleOfServiceMenuScreenViewmodel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';

    _dismantleMenuItems.addAll([
      SubMenuGridItem(
          title: GlobalConstants.createCorrespondence,
          iconAsset: Icons.computer,
          cardColor: Colors.orange,
          routeName: Routes.dismantleCreateCorrespondence),
      SubMenuGridItem(
          title: GlobalConstants.pendingAtEro,
          iconAsset: Icons.hourglass_bottom,
          cardColor: Colors.blue,
          routeName: Routes.dismantleChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.demandIssued,
          iconAsset: Icons.receipt_outlined,
          cardColor: const Color(0Xffa1887f),
          routeName: Routes.dismantleChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.duesPaid,
          iconAsset: Icons.recommend,
          cardColor: Colors.green,
          routeName: Routes.dismantleChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.noDuesCertificate,
          iconAsset: Icons.receipt_long_outlined,
          cardColor: Colors.green,
          routeName: Routes.dismantleChangeRequestList),
      SubMenuGridItem(
          title: GlobalConstants.rejectedByERO,
          iconAsset: Icons.close,
          cardColor: Colors.redAccent,
          routeName:  Routes.dismantleChangeRequestList),
    ]);

    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (routeName != Routes.revokingOfServicesScreen) {
      String status = '';
      if (title == GlobalConstants.createCorrespondence) { //revokeOfServices
        status ="";
      }else if (title == GlobalConstants.pendingAtEro) { //revokeOfServices
        status = StatusConstants.TYPE_PENDING_ERO;
      }else if (title == GlobalConstants.demandIssued) {
        status = StatusConstants.DEMAND_RAISED;
      } else if (title == GlobalConstants.duesPaid) {
        status = StatusConstants.DUES_PAID;
      }else if (title == GlobalConstants.noDuesCertificate) {
        status = StatusConstants.NO_DUES;
      }else if (title == GlobalConstants.rejectedByERO) {
        status = StatusConstants.TYPE_REJECTED_ERO;
      }
      Navigation.instance.navigateTo(routeName, args: status);
      print("Navigating with status");
    } else {
      Navigation.instance.navigateTo(routeName);
      print("Navigating without status");
    }
  }
}
