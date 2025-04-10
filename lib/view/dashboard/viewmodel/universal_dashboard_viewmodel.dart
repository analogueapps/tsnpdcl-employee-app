import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/auth/model/npdcl_user.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/drawer_section.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/global_list_dialog_item.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/universal_dashboard_item.dart';

class UniversalDashboardViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  final List<UniversalDashboardItem> _allItems = [];
  List<UniversalDashboardItem> _filteredItems = [];

  List<UniversalDashboardItem> get filteredItems => _filteredItems;

  // Drawer main item
  List<DrawerSection> sections = [];

  // Drawer sub items
  List<UniversalDashboardItem> appManagement = [];
  List<UniversalDashboardItem> consumerAndServiceManagement = [];
  List<UniversalDashboardItem> maintenanceAndInspections = [];
  List<UniversalDashboardItem> mappingAndGIS = [];
  List<UniversalDashboardItem> reportsAndSchedules = [];
  List<UniversalDashboardItem> testingAndReadings = [];
  List<UniversalDashboardItem> rFAndMonitoring = [];
  List<UniversalDashboardItem> others = [];

  // Npdcl User data
  NpdclUser? _npdclUser;
  NpdclUser? get npdclUser => _npdclUser;

  // Constructor to initialize the items
  UniversalDashboardViewModel() {
    _initializeItems();
    _initializeMenuItems();
    _initializeData();
  }

  void _initializeData() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    _npdclUser = user[0];
    notifyListeners();
  }

  void _initializeMenuItems() {
    const String routeName = '';

    appManagement.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.updateAppTitle,
          imageAsset: Assets.updateApp,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.onlinePrTitle,
          imageAsset: Assets.onlinePr,
          routeName: Routes.onlinePrMenuScreen
          ),
      UniversalDashboardItem(
          title: GlobalConstants.uploadCasteCertificateTitle,
          imageAsset: Assets.uploadCasteCertificate,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.meesevaTitle,
          imageAsset: Assets.meeseva,
          routeName: Routes.meesevaMenuScreen
      ),
    ]);
    consumerAndServiceManagement.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.searchConsumerTitle,
          imageAsset: Assets.searchConsumer,
          routeName: Routes.searchConsumerScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.consumerDetailsTitle,
          imageAsset: Assets.consumerDetails,
          routeName: Routes.consumerDetailsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.gruhaJyothiTitle,
          imageAsset: Assets.gruhaJyothi,
          routeName: Routes.gruhaJyothiScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.manageStaffTitle,
          imageAsset: Assets.manageStaff,
          routeName: Routes.manageStaffsScreen
      ),
    ]);
    maintenanceAndInspections.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.lineClearanceTitle,
          imageAsset: Assets.lineClearance,
          routeName: Routes.lineClearanceScreen),
      UniversalDashboardItem(
          title: GlobalConstants.dtrMaintenanceTitle,
          imageAsset: Assets.dtrMaintenance,
          routeName: Routes.dtrMaintenanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dtrFailureTitle,
          imageAsset: Assets.dtrFailure,
          routeName: Routes.dtrFailureScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.failureDtrInspectionTitle,
          imageAsset: Assets.failureDtrInspection,
          routeName: Routes.failureDtrInspectionScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ssMaintenanceTitle,
          imageAsset: Assets.ssMaintenance,
          routeName: Routes.ssMaintenanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.electroMechTitle,
          imageAsset: Assets.electroMech,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.maintenanceTitle,
          imageAsset: Assets.maintenance,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.bsUdcInspectionTitle,
          imageAsset: Assets.bsUdcInspection,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.interruptionsTitle,
          imageAsset: Assets.interruptions,
          routeName: GlobalConstants.interruptionsTitle,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ctPtFailureTitle,
          imageAsset: Assets.ctPtFailure,
          routeName: Routes.ctptMenuScreen
      ),
    ]);
    mappingAndGIS.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.assetMappingTitle,
          imageAsset: Assets.assetMapping,
          routeName: Routes.assetMappingScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.mappingOfNonAglServicesTitle,
          imageAsset: Assets.mappingOfNonAglServices,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.gisIdsTitle,
          imageAsset: Assets.gisIds,
          routeName: GlobalConstants.gisIdsTitle
      ),
      UniversalDashboardItem(
          title: GlobalConstants.poleTrackerTitle,
          imageAsset: Assets.poloTracker,
          routeName: GlobalConstants.poleTrackerTitle,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.middlePolesTitle,
          imageAsset: Assets.middlePoles,
          routeName: Routes.middlePolesScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.checkMeasurementTitle,
          imageAsset: Assets.checkMeasurement,
          routeName: routeName),
    ]);
    reportsAndSchedules.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.schedulesTitle,
          imageAsset: Assets.schedules,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.dListTitle,
          imageAsset: Assets.dList,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.dListReportTitle,
          imageAsset: Assets.dListReport,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.reportsTitle,
          imageAsset: Assets.reports,
          routeName: GlobalConstants.reportsTitle
      ),
      UniversalDashboardItem(
          title: GlobalConstants.exceptionalsTitle,
          imageAsset: Assets.exceptionals,
          routeName: Routes.exceptionalsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.pdmsTitle,
          imageAsset: Assets.pdms,
          routeName: Routes.pdmsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.foccTitle,
          imageAsset: Assets.focc,
          routeName: Routes.webViewScreen
      ),
    ]);
    testingAndReadings.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.measureDistTitle,
          imageAsset: Assets.measureDist,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.tongTesterReadingsTitle,
          imageAsset: Assets.tongTesterReadings,
        routeName: Routes.structureDtrList,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.checkReadingsTitle,
          imageAsset: Assets.checkReadings,
          routeName: routeName),
    ]);
    rFAndMonitoring.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.rfssTitle,
          imageAsset: Assets.rfss,
          routeName: Routes.rfssScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.uscNoTitle,
          imageAsset: Assets.uscNo,
          routeName: Routes.webViewScreen
      ),
    ]);
    others.addAll([
      // UniversalDashboardItem(
      //     title: GlobalConstants.ganeshPandalInfoTitle,
      //     imageAsset: Assets.ganeshPandalInfo,
      //     routeName: Routes.ganeshPandalInfoScreen
      // ),
      UniversalDashboardItem(
          title: GlobalConstants.mappingOfNonAglServicesTitle,
          imageAsset: Assets.mappingOfNonAglServices,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.uploadCasteCertificateTitle,
          imageAsset: Assets.uploadCasteCertificate,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.electroMechTitle,
          imageAsset: Assets.electroMech,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.accountTitle,
          imageAsset: Assets.account,
          routeName: Routes.accountScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.logoutTitle,
          imageAsset: Assets.logout,
          routeName: routeName),
    ]);

    sections.addAll([
      DrawerSection(
        title: "App Management",
        leadingIcon: Icons.settings,
        items: appManagement,
      ),
      DrawerSection(
        title: "Consumer and Service Management",
        leadingIcon: Icons.person,
        items: consumerAndServiceManagement,
      ),
      DrawerSection(
        title: "Maintenance and Inspections",
        leadingIcon: Icons.build,
        items: maintenanceAndInspections,
      ),
      DrawerSection(
        title: "Mapping and GIS",
        leadingIcon: Icons.map,
        items: mappingAndGIS,
      ),
      DrawerSection(
        title: "Reports and Schedules",
        leadingIcon: Icons.schedule,
        items: reportsAndSchedules,
      ),
      DrawerSection(
        title: "Testing and Readings",
        leadingIcon: Icons.receipt,
        items: testingAndReadings,
      ),
      DrawerSection(
        title: "RF and Monitoring",
        leadingIcon: Icons.signal_cellular_4_bar,
        items: rFAndMonitoring,
      ),
      DrawerSection(
        title: "Others",
        leadingIcon: Icons.more_horiz,
        items: others,
      ),
    ]);
    notifyListeners();
  }

  // Add items to the dashboard
  void _initializeItems() {
    const String routeName = '';

    _allItems.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.updateAppTitle,
          imageAsset: Assets.updateApp,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.searchConsumerTitle,
          imageAsset: Assets.searchConsumer,
          routeName: Routes.searchConsumerScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.lineClearanceTitle,
          imageAsset: Assets.lineClearance,
          routeName: Routes.lineClearanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.assetMappingTitle,
          imageAsset: Assets.assetMapping,
          routeName: Routes.assetMappingScreen
      ),
      // UniversalDashboardItem(
      //     title: GlobalConstants.ganeshPandalInfoTitle,
      //     imageAsset: Assets.ganeshPandalInfo,
      //     routeName: Routes.ganeshPandalInfoScreen
      // ),
      UniversalDashboardItem(
          title: GlobalConstants.onlinePrTitle,
          imageAsset: Assets.onlinePr,
          routeName: Routes.onlinePrMenuScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.measureDistTitle,
          imageAsset: Assets.measureDist,
          routeName: Routes.measureDistanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.consumerDetailsTitle,
          imageAsset: Assets.consumerDetails,
          routeName: Routes.consumerDetailsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.gruhaJyothiTitle,
          imageAsset: Assets.gruhaJyothi,
          routeName: Routes.gruhaJyothiScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dtrMaintenanceTitle,
          imageAsset: Assets.dtrMaintenance,
          routeName: Routes.dtrMaintenanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dtrFailureTitle,
          imageAsset: Assets.dtrFailure,
          routeName: Routes.dtrFailureScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.failureDtrInspectionTitle,
          imageAsset: Assets.failureDtrInspection,
          routeName: Routes.failureDtrInspectionScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ssMaintenanceTitle,
          imageAsset: Assets.ssMaintenance,
          routeName: Routes.ssMaintenanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.pmiOfLinesTitle,
          imageAsset: Assets.pmiOfLines,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.rfssTitle,
          imageAsset: Assets.rfss,
          routeName: Routes.rfssScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.schedulesTitle,
          imageAsset: Assets.schedules,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.mappingOfNonAglServicesTitle,
          imageAsset: Assets.mappingOfNonAglServices,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.tongTesterReadingsTitle,
          imageAsset: Assets.tongTesterReadings,
          routeName: Routes.overloadedDtrsView,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.uscNoTitle,
          imageAsset: Assets.uscNo,
          routeName: Routes.webViewScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.gisIdsTitle,
          imageAsset: Assets.gisIds,
          routeName: GlobalConstants.gisIdsTitle
      ),
      UniversalDashboardItem(
          title: GlobalConstants.uploadCasteCertificateTitle,
          imageAsset: Assets.uploadCasteCertificate,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.meesevaTitle,
          imageAsset: Assets.meeseva,
          routeName: Routes.meesevaMenuScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.exceptionalsTitle,
          imageAsset: Assets.exceptionals,
          routeName: Routes.exceptionalsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ltmtTitle,
          imageAsset: Assets.ltmt,
          routeName: Routes.ltmtScreen),
      UniversalDashboardItem(
          title: GlobalConstants.electroMechTitle,
          imageAsset: Assets.electroMech,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.poleTrackerTitle,
          imageAsset: Assets.poloTracker,
          routeName: GlobalConstants.poleTrackerTitle,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dtrMasterTitle,
          imageAsset: Assets.dtrMaster,
          routeName: GlobalConstants.dtrMasterTitle
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dListTitle,
          imageAsset: Assets.dList,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.dListReportTitle,
          imageAsset: Assets.dListReport,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.middlePolesTitle,
          imageAsset: Assets.middlePoles,
          routeName: Routes.middlePolesScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.maintenanceTitle,
          imageAsset: Assets.maintenance,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.checkReadingsTitle,
          imageAsset: Assets.checkReadings,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.bsUdcInspectionTitle,
          imageAsset: Assets.bsUdcInspection,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.interruptionsTitle,
          imageAsset: Assets.interruptions,
          routeName: GlobalConstants.interruptionsTitle,
      ),
      UniversalDashboardItem(
          title: GlobalConstants.manageStaffTitle,
          imageAsset: Assets.manageStaff,
          routeName: Routes.manageStaffsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.newServicesTitle,
          imageAsset: Assets.newServices,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.ctPtFailureTitle,
          imageAsset: Assets.ctPtFailure,
          routeName: Routes.ctptMenuScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.pdmsTitle,
          imageAsset: Assets.pdms,
          routeName: Routes.pdmsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.reportsTitle,
          imageAsset: Assets.reports,
          routeName: GlobalConstants.reportsTitle
      ),
      UniversalDashboardItem(
          title: GlobalConstants.checkMeasurementTitle,
          imageAsset: Assets.checkMeasurement,
          routeName: Routes.measureDistanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.foccTitle,
          imageAsset: Assets.focc,
          routeName: Routes.webViewScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ebsTitle,
          imageAsset: Assets.ebs,
          routeName: Routes.webViewScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.matsTitle,
          imageAsset: Assets.mats,
          routeName: Routes.webViewScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.accountTitle,
          imageAsset: Assets.account,
          routeName: Routes.accountScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.logoutTitle,
          imageAsset: Assets.logout,
          routeName: routeName),
    ]);

    _filteredItems = List.from(_allItems); // Clone the list for filtered items
    notifyListeners();
  }

  // Filter items based on the query string
  void filterItems(String query) {
    if (query.isEmpty) {
      _filteredItems = List.from(_allItems); // Clone the list for safety
    } else {
      _filteredItems = _allItems
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> menuItemClicked(BuildContext context, String title, String routeName) async {
    if (title == GlobalConstants.logoutTitle) {
      showLogoutDialog(context);
    } else if (routeName == Routes.webViewScreen) {
      final urlMapping = {
        GlobalConstants.uscNoTitle: UrlConstants.onlineLTConsCheckUrl,
        GlobalConstants.foccTitle: UrlConstants.foccUrl,
        GlobalConstants.ebsTitle: UrlConstants.ebsUrl,
        GlobalConstants.matsTitle: UrlConstants.matsUrl,
        GlobalConstants.viewReport: UrlConstants.viewReportUrl,
      };

      if (urlMapping.containsKey(title)) {
        var argument = {
          'title': title,
          'url': urlMapping[title],
        };
        //Navigator.pushNamed(context, routeName, arguments: argument);
        Navigation.instance.navigateTo(routeName, args: argument);
      }
    } else if(routeName == GlobalConstants.reportsTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: "CT PT Failure Reports",
          routeName: Routes.reportsScreen
        ),
        GlobalListDialogItem(
            title: "Middle Poles Reports",
            routeName: Routes.reportsScreen
        ),
        GlobalListDialogItem(
            title: "Maintenance Reports",
            routeName: Routes.reportsScreen
        ),
      ]);
      showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.dtrMasterTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
            title: "Create DTR Master(Online)",
            routeName: Routes.createOnlineDTR
        ),
        GlobalListDialogItem(
            title: "View Mapped DTR's",
            routeName: Routes.configureFilter,
        ),
        GlobalListDialogItem(
            title: "Create DTR Master(Offline)",
            routeName: Routes.createOfflineDTR,
        ),
        GlobalListDialogItem(
            title: "Download For Offline",
            routeName: Routes.downloadFeederScreen,
        ),
        GlobalListDialogItem(
            title: "View Offline Data",
            routeName: Routes.offlineData,
        ),
        GlobalListDialogItem(
            title: "View Mismatch DTR's",
            routeName: Routes.misMatched,
        ),
      ]);
      showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.poleTrackerTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
            title: "Digitize Lines",
            routeName: Routes.poleTrackerSelectionScreen,
        ),
        GlobalListDialogItem(
            title: "View Offline Feeders",
            routeName: Routes.viewOfflineFeedersScreen,
        ),
        GlobalListDialogItem(
            title: "View Sketch",
            routeName: Routes.poleTrackerSelectionViewSketchScreen,
        ),
      ]);
      showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.gisIdsTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: "View GIS List",
          routeName: Routes.viewGisIdsScreen,
        ),
        GlobalListDialogItem(
          title: "View Offline Forms",
          routeName: "",
        ),
        GlobalListDialogItem(
          title: "View Offline Forms(Pending)",
          routeName: "",
        ),
      ]);
      showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.interruptionsTitle) { // swetha
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
            title: "33KV Breakdown Entry",
            routeName: Routes.breakdown33kvScreen,
        ),
        GlobalListDialogItem(
          title: "View 33KV Breakdowns",
          routeName: Routes.view33kvBreakdownScreen,
        ),
        GlobalListDialogItem(
            title: "11KV Breakdown Entry",
            routeName: Routes.breakdown11kvScreen,
        ),
        GlobalListDialogItem(
            title: "View 11KV Breakdowns",
            routeName: Routes.view11kvBreakdownScreen,
        ),
        GlobalListDialogItem(
            title: "Interruptions Entry",
            routeName: Routes.interruptionsEntryScreen,
        ),
        GlobalListDialogItem(
            title: "SAIDI SAIFI CALCULATOR",
            routeName: Routes.saidiSaifiCalculatorScreen,
        ),
        GlobalListDialogItem(
            title: "VIEW SAIDI SAIFI",
            routeName: Routes.viewSaidiSaifiScreen
        ),
        GlobalListDialogItem(
            title: "View Report",
            routeName: Routes.viewReportScreen
        ),
      ]);
      showCustomListDialog(context, globalListDialogItem);
    } else {
      //Navigator.pushNamed(context, routeName);
      Navigation.instance.navigateTo(routeName);
    }
  }
}
