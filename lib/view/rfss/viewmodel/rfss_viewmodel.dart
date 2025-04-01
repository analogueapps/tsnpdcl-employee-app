import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/global_list_dialog_item.dart';
import 'package:tsnpdcl_employee/view/rfss/model/list_dialog_item.dart';
import 'package:tsnpdcl_employee/view/rfss/model/rfss_menu_grid_item.dart';

class RfssViewModel extends ChangeNotifier {
  final List<RfssMenuGridItem> _rfssMenuItems = [];

  List<RfssMenuGridItem> get rfssMenuItems => _rfssMenuItems;

  // Constructor to initialize the items
  RfssViewModel() {
    _initializeItems();
  }

  // Add items
  void _initializeItems() {
    const String routeName = '';
    _rfssMenuItems.addAll([
      RfssMenuGridItem(
        title: GlobalConstants.mappingOfServices,
        iconAsset: Icons.account_tree_outlined,
        cardColor: Colors.redAccent,

      ),
      RfssMenuGridItem(
        title: GlobalConstants.dtrDigitilization,
        iconAsset: Icons.power_sharp,
        cardColor: Colors.green,
        // routeName: Routes.viewDispatchInstructionsScreen
      ),
      RfssMenuGridItem(
        title: GlobalConstants.dtrDefectsReporting,
        iconAsset: Icons.build_outlined,
        cardColor: Colors.orange,
        // routeName: Routes.createPoleIndentsScreen
      ),
    ]);

    notifyListeners();
  }

  Future<void> rfssMenuItemClicked(BuildContext context, String title) async {
    if (title == GlobalConstants.mappingOfServices) {
      List<listDialogItem> listDialogItemArray = [];
      listDialogItemArray.addAll([
        listDialogItem(
            title: "Non-AGL Service",
            routeName: Routes.nonAglService
        ),
        listDialogItem(
            title: "AGL Service",
            routeName: Routes.aglService
        ),
      ]);
      showCustomListRfssDialog(context, listDialogItemArray);
    } else if (title == GlobalConstants.dtrDigitilization) {
      List<listDialogItem> listDialogItemArray = [];
      listDialogItemArray.addAll([
        listDialogItem(
            title: "Create DTR Master(Online)",
            routeName:Routes.createOnlineDTR
        ),listDialogItem(
            title: "View Mapped DTR's",
            routeName: Routes.mappedDtrScreen,
        ),
        listDialogItem(
            title: "Create DTR Master(Offline)",
            routeName: Routes.createOfflineDTR
        ),
        listDialogItem(
            title: "Download For Offline",
            routeName: Routes.downloadFeederScreen,
        ),
        listDialogItem(
            title: "View Offline Data",
            routeName:Routes.offlineData
        ),
        listDialogItem(
            title: "View Mismatch DTR's",
            routeName:  Routes.misMatched,
        ),
      ]);
      showCustomListRfssDialog(context, listDialogItemArray);
    } else if (title == GlobalConstants.dtrDefectsReporting) {
      List<listDialogItem> listDialogItemArray = [];
      listDialogItemArray.addAll([
        listDialogItem(
            title: "Open New Inspection",
            routeName: Routes.openNewInspection
        ),
        listDialogItem(
            title: "View Inspections",
            routeName: Routes.dtrMaintenanceScreen
        ),

      ]);
      // Uncomment this line to show the dialog
      showCustomListRfssDialog(context, listDialogItemArray);
    }
  }
}