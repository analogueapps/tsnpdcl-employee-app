import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/view/dashboard/model/drawer_section.dart';
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

  // Constructor to initialize the items
  UniversalDashboardViewModel() {
    _initializeItems();
    _initializeMenuItems();
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
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.gruhaJyothiTitle,
          imageAsset: Assets.gruhaJyothi,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.manageStaffTitle,
          imageAsset: Assets.manageStaff,
          routeName: routeName),
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
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.ctPtFailureTitle,
          imageAsset: Assets.ctPtFailure,
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.poleTrackerTitle,
          imageAsset: Assets.poloTracker,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.middlePolesTitle,
          imageAsset: Assets.middlePoles,
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.exceptionalsTitle,
          imageAsset: Assets.exceptionals,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.pdmsTitle,
          imageAsset: Assets.pdms,
          routeName: Routes.pdmsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.foccTitle,
          imageAsset: Assets.focc,
          routeName: routeName),
    ]);
    testingAndReadings.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.measureDistTitle,
          imageAsset: Assets.measureDist,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.tongTesterReadingsTitle,
          imageAsset: Assets.tongTesterReadings,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.checkReadingsTitle,
          imageAsset: Assets.checkReadings,
          routeName: routeName),
    ]);
    rFAndMonitoring.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.rfssTitle,
          imageAsset: Assets.rfss,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.uscNoTitle,
          imageAsset: Assets.uscNo,
          routeName: routeName),
    ]);
    others.addAll([
      UniversalDashboardItem(
          title: GlobalConstants.ganeshPandalInfoTitle,
          imageAsset: Assets.ganeshPandalInfo,
          routeName: Routes.ganeshPandalInfoScreen
      ),
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
          routeName: routeName),
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
      UniversalDashboardItem(
          title: GlobalConstants.ganeshPandalInfoTitle,
          imageAsset: Assets.ganeshPandalInfo,
          routeName: Routes.ganeshPandalInfoScreen
      ),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.gruhaJyothiTitle,
          imageAsset: Assets.gruhaJyothi,
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.pmiOfLinesTitle,
          imageAsset: Assets.pmiOfLines,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.rfssTitle,
          imageAsset: Assets.rfss,
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.uscNoTitle,
          imageAsset: Assets.uscNo,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.gisIdsTitle,
          imageAsset: Assets.gisIds,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.uploadCasteCertificateTitle,
          imageAsset: Assets.uploadCasteCertificate,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.meesevaTitle,
          imageAsset: Assets.meeseva,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.exceptionalsTitle,
          imageAsset: Assets.exceptionals,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.ltmtTitle,
          imageAsset: Assets.ltmt,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.electroMechTitle,
          imageAsset: Assets.electroMech,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.poleTrackerTitle,
          imageAsset: Assets.poloTracker,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.dtrMasterTitle,
          imageAsset: Assets.dtrMaster,
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
          title: GlobalConstants.middlePolesTitle,
          imageAsset: Assets.middlePoles,
          routeName: routeName),
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
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.manageStaffTitle,
          imageAsset: Assets.manageStaff,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.newServicesTitle,
          imageAsset: Assets.newServices,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.ctPtFailureTitle,
          imageAsset: Assets.ctPtFailure,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.pdmsTitle,
          imageAsset: Assets.pdms,
          routeName: Routes.pdmsScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.reportsTitle,
          imageAsset: Assets.reports,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.checkMeasurementTitle,
          imageAsset: Assets.checkMeasurement,
          routeName: Routes.measureDistanceScreen
      ),
      UniversalDashboardItem(
          title: GlobalConstants.foccTitle,
          imageAsset: Assets.focc,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.ebsTitle,
          imageAsset: Assets.ebs,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.matsTitle,
          imageAsset: Assets.mats,
          routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.accountTitle,
          imageAsset: Assets.account,
          routeName: routeName),
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
}
