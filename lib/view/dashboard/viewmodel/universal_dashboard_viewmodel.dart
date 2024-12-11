import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/general_assets.dart';
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
      UniversalDashboardItem(title: "Update app", imageAsset: Assets.updateApp, routeName: routeName),
      UniversalDashboardItem(title: "Online pr", imageAsset: Assets.onlinePr, routeName: routeName),
      UniversalDashboardItem(title: "Upload caste certificate", imageAsset: Assets.uploadCasteCertificate, routeName: routeName),
      UniversalDashboardItem(title: "Meeseva(new meter releases)", imageAsset: Assets.meeseva, routeName: routeName),
    ]);
    consumerAndServiceManagement.addAll([
      UniversalDashboardItem(title: "Search consumer", imageAsset: Assets.searchConsumer, routeName: routeName),
      UniversalDashboardItem(title: "Consumer details", imageAsset: Assets.consumerDetails, routeName: routeName),
      UniversalDashboardItem(title: "Gruha jyothi", imageAsset: Assets.gruhaJyothi, routeName: routeName),
      UniversalDashboardItem(title: "Manage Staff", imageAsset: Assets.manageStaff, routeName: routeName),
    ]);
    maintenanceAndInspections.addAll([
      UniversalDashboardItem(title: "Line clearance", imageAsset: Assets.lineClearance, routeName: routeName),
      UniversalDashboardItem(title: "Dtr maintenance", imageAsset: Assets.dtrMaintenance, routeName: routeName),
      UniversalDashboardItem(title: "Dtr failure", imageAsset: Assets.dtrFailure, routeName: routeName),
      UniversalDashboardItem(title: "Failure dtr(s) inspection", imageAsset: Assets.failureDtrInspection, routeName: routeName),
      UniversalDashboardItem(title: "Ss maintenance", imageAsset: Assets.ssMaintenance, routeName: routeName),
      UniversalDashboardItem(title: "Electro-mech meters replacement", imageAsset: Assets.electroMech, routeName: routeName),
      UniversalDashboardItem(title: "Maintenance", imageAsset: Assets.maintenance, routeName: routeName),
      UniversalDashboardItem(title: "Bs udc inspection", imageAsset: Assets.bsUdcInspection, routeName: routeName),
      UniversalDashboardItem(title: "Interruptions", imageAsset: Assets.interruptions, routeName: routeName),
      UniversalDashboardItem(title: "Ct pt failure/replacement", imageAsset: Assets.ctPtFailure, routeName: routeName),
    ]);
    mappingAndGIS.addAll([
      UniversalDashboardItem(title: "Asset mapping", imageAsset: Assets.assetMapping, routeName: routeName),
      UniversalDashboardItem(title: "Mapping of non-agl services", imageAsset: Assets.mappingOfNonAglServices, routeName: routeName),
      UniversalDashboardItem(title: "Gis ids", imageAsset: Assets.gisIds, routeName: routeName),
      UniversalDashboardItem(title: "Pole tracker", imageAsset: Assets.poloTracker, routeName: routeName),
      UniversalDashboardItem(title: "Middle poles", imageAsset: Assets.middlePoles, routeName: routeName),
      UniversalDashboardItem(title: "Check measurement(lines)", imageAsset: Assets.checkMeasurement, routeName: routeName),
    ]);
    reportsAndSchedules.addAll([
      UniversalDashboardItem(title: "Schedules", imageAsset: Assets.schedules, routeName: routeName),
      UniversalDashboardItem(title: "D'list", imageAsset: Assets.dList, routeName: routeName),
      UniversalDashboardItem(title: "D'list report", imageAsset: Assets.dListReport, routeName: routeName),
      UniversalDashboardItem(title: "Reports", imageAsset: Assets.reports, routeName: routeName),
      UniversalDashboardItem(title: "Exceptionals", imageAsset: Assets.exceptionals, routeName: routeName),
      UniversalDashboardItem(title: "Pdms", imageAsset: Assets.pdms, routeName: routeName),
      UniversalDashboardItem(title: "Focc", imageAsset: Assets.focc, routeName: routeName),
    ]);
    testingAndReadings.addAll([
      UniversalDashboardItem(title: "Measure dist.", imageAsset: Assets.measureDist, routeName: routeName),
      UniversalDashboardItem(title: "Tong tester readings", imageAsset: Assets.tongTesterReadings, routeName: routeName),
      UniversalDashboardItem(title: "Check readings", imageAsset: Assets.checkReadings, routeName: routeName),
    ]);
    rFAndMonitoring.addAll([
      UniversalDashboardItem(title: "RFSS", imageAsset: Assets.rfss, routeName: routeName),
      UniversalDashboardItem(title: "Uscno<=>scno", imageAsset: Assets.uscNo, routeName: routeName),
    ]);
    others.addAll([
      UniversalDashboardItem(title: "Ganesh pandal info", imageAsset: Assets.ganeshPandalInfo, routeName: routeName),
      UniversalDashboardItem(title: "Mapping of non-agl services", imageAsset: Assets.mappingOfNonAglServices, routeName: routeName),
      UniversalDashboardItem(title: "Upload caste certificate", imageAsset: Assets.uploadCasteCertificate, routeName: routeName),
      UniversalDashboardItem(title: "Electro-mech meters replacement", imageAsset: Assets.electroMech, routeName: routeName),
      UniversalDashboardItem(title: "Account", imageAsset: Assets.account, routeName: routeName),
      UniversalDashboardItem(title: "Logout", imageAsset: Assets.logout, routeName: routeName),
    ]);

    sections.addAll(
        [
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
        ]
    );
    notifyListeners();
  }

  // Add items to the dashboard
  void _initializeItems() {
    const String routeName = '';

    _allItems.addAll([
      UniversalDashboardItem(title: "Update app", imageAsset: Assets.updateApp, routeName: routeName),
      UniversalDashboardItem(title: "Search consumer", imageAsset: Assets.searchConsumer, routeName: routeName),
      UniversalDashboardItem(title: "Line clearance", imageAsset: Assets.lineClearance, routeName: routeName),
      UniversalDashboardItem(title: "Asset mapping", imageAsset: Assets.assetMapping, routeName: routeName),
      UniversalDashboardItem(title: "Ganesh pandal info", imageAsset: Assets.ganeshPandalInfo, routeName: routeName),
      UniversalDashboardItem(title: "Online pr", imageAsset: Assets.onlinePr, routeName: routeName),
      UniversalDashboardItem(title: "Measure dist.", imageAsset: Assets.measureDist, routeName: routeName),
      UniversalDashboardItem(title: "Consumer details", imageAsset: Assets.consumerDetails, routeName: routeName),
      UniversalDashboardItem(title: "Gruha jyothi", imageAsset: Assets.gruhaJyothi, routeName: routeName),
      UniversalDashboardItem(title: "Dtr maintenance", imageAsset: Assets.dtrMaintenance, routeName: routeName),
      UniversalDashboardItem(title: "Dtr failure", imageAsset: Assets.dtrFailure, routeName: routeName),
      UniversalDashboardItem(title: "Failure dtr(s) inspection", imageAsset: Assets.failureDtrInspection, routeName: routeName),
      UniversalDashboardItem(title: "Ss maintenance", imageAsset: Assets.ssMaintenance, routeName: routeName),
      UniversalDashboardItem(title: "Pmi of lines", imageAsset: Assets.pmiOfLines, routeName: routeName),
      UniversalDashboardItem(title: "RFSS", imageAsset: Assets.rfss, routeName: routeName),
      UniversalDashboardItem(title: "Schedules", imageAsset: Assets.schedules, routeName: routeName),
      UniversalDashboardItem(title: "Mapping of non-agl services", imageAsset: Assets.mappingOfNonAglServices, routeName: routeName),
      UniversalDashboardItem(title: "Tong tester readings", imageAsset: Assets.tongTesterReadings, routeName: routeName),
      UniversalDashboardItem(title: "Uscno<=>scno", imageAsset: Assets.uscNo, routeName: routeName),
      UniversalDashboardItem(title: "Gis ids", imageAsset: Assets.gisIds, routeName: routeName),
      UniversalDashboardItem(title: "Upload caste certificate", imageAsset: Assets.uploadCasteCertificate, routeName: routeName),
      UniversalDashboardItem(title: "Meeseva(new meter releases)", imageAsset: Assets.meeseva, routeName: routeName),
      UniversalDashboardItem(title: "Exceptionals", imageAsset: Assets.exceptionals, routeName: routeName),
      UniversalDashboardItem(title: "Ltmt", imageAsset: Assets.ltmt, routeName: routeName),
      UniversalDashboardItem(title: "Electro-mech meters replacement", imageAsset: Assets.electroMech, routeName: routeName),
      UniversalDashboardItem(title: "Pole tracker", imageAsset: Assets.poloTracker, routeName: routeName),
      UniversalDashboardItem(title: "Dtr master", imageAsset: Assets.dtrMaster, routeName: routeName),
      UniversalDashboardItem(title: "D'list", imageAsset: Assets.dList, routeName: routeName),
      UniversalDashboardItem(title: "D'list report", imageAsset: Assets.dListReport, routeName: routeName),
      UniversalDashboardItem(title: "Middle poles", imageAsset: Assets.middlePoles, routeName: routeName),
      UniversalDashboardItem(title: "Maintenance", imageAsset: Assets.maintenance, routeName: routeName),
      UniversalDashboardItem(title: "Check readings", imageAsset: Assets.checkReadings, routeName: routeName),
      UniversalDashboardItem(title: "Bs udc inspection", imageAsset: Assets.bsUdcInspection, routeName: routeName),
      UniversalDashboardItem(title: "Interruptions", imageAsset: Assets.interruptions, routeName: routeName),
      UniversalDashboardItem(title: "Manage staff", imageAsset: Assets.manageStaff, routeName: routeName),
      UniversalDashboardItem(title: "New services(schemes)", imageAsset: Assets.newServices, routeName: routeName),
      UniversalDashboardItem(title: "Ct pt failure/replacement", imageAsset: Assets.ctPtFailure, routeName: routeName),
      UniversalDashboardItem(title: "Pdms", imageAsset: Assets.pdms, routeName: routeName),
      UniversalDashboardItem(title: "Reports", imageAsset: Assets.reports, routeName: routeName),
      UniversalDashboardItem(title: "Check measurement(lines)", imageAsset: Assets.checkMeasurement, routeName: routeName),
      UniversalDashboardItem(title: "Focc", imageAsset: Assets.focc, routeName: routeName),
      UniversalDashboardItem(title: "Ebs", imageAsset: Assets.ebs, routeName: routeName),
      UniversalDashboardItem(title: "Mats", imageAsset: Assets.mats, routeName: routeName),
      UniversalDashboardItem(title: "Account", imageAsset: Assets.account, routeName: routeName),
      UniversalDashboardItem(title: "Logout", imageAsset: Assets.logout, routeName: routeName),
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
          .where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
