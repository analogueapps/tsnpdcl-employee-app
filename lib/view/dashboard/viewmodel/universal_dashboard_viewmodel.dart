import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/dialogs/custom_bottom_sheet.dart';
import 'package:tsnpdcl_employee/dialogs/custom_list_dialog.dart';
import 'package:tsnpdcl_employee/dialogs/dialog_master.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
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

  // Npdcl User data
  NpdclUser? _npdclUser;
  NpdclUser? get npdclUser => _npdclUser;

  // Constructor to initialize the items
  UniversalDashboardViewModel() {
    _initializeItems();
    _initializeData();
  }

  void _initializeData() {
    String? prefJson = SharedPreferenceHelper.getStringValue(LoginSdkPrefs.npdclUserPrefKey);
    final List<dynamic> jsonList = jsonDecode(prefJson);
    final List<NpdclUser> user = jsonList.map((json) => NpdclUser.fromJson(json)).toList();
    _npdclUser = user[0];
    notifyListeners();
  }

  // Add items to the dashboard
  void _initializeItems() {
    const String routeName = '';

    // _allItems.addAll([
    //   // UniversalDashboardItem(
    //   //     title: GlobalConstants.updateAppTitle,
    //   //     imageAsset: Assets.updateApp,
    //   //     routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.searchConsumerTitle,
    //       imageAsset: Assets.searchConsumer,
    //       routeName: Routes.searchConsumerScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.lineClearanceTitle,
    //       imageAsset: Assets.lineClearance,
    //       routeName: Routes.lineClearanceScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.assetMappingTitle,
    //       imageAsset: Assets.assetMapping,
    //       routeName: Routes.assetMappingScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.onlinePrTitle,
    //       imageAsset: Assets.onlinePr,
    //       routeName: Routes.onlinePrMenuScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.measureDistTitle,
    //       imageAsset: Assets.measureDist,
    //       routeName: Routes.measureDistanceScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.consumerDetailsTitle,
    //       imageAsset: Assets.consumerDetails,
    //       routeName: Routes.consumerDetailsScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.gruhaJyothiTitle,
    //       imageAsset: Assets.gruhaJyothi,
    //       routeName: Routes.gruhaJyothiScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.dtrMaintenanceTitle,
    //       imageAsset: Assets.dtrMaintenance,
    //       routeName: Routes.dtrMaintenanceScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.dtrFailureTitle,
    //       imageAsset: Assets.dtrFailure,
    //       routeName: Routes.dtrFailureScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.failureDtrInspectionTitle,
    //       imageAsset: Assets.failureDtrInspection,
    //       routeName: Routes.failureDtrInspectionScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.ssMaintenanceTitle,
    //       imageAsset: Assets.ssMaintenance,
    //       routeName: Routes.ssMaintenanceScreen
    //   ),
    //
    //   UniversalDashboardItem(
    //       title: GlobalConstants.rfssTitle,
    //       imageAsset: Assets.rfss,
    //       routeName: Routes.rfssScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.schedulesTitle,
    //       imageAsset: Assets.schedules,
    //       routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.mappingOfNonAglServicesTitle,
    //       imageAsset: Assets.mappingOfNonAglServices,
    //       routeName: Routes.nonAglService),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.tongTesterReadingsTitle,
    //       imageAsset: Assets.tongTesterReadings,
    //       routeName: Routes.overloadedDtrsView,
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.uscNoTitle,
    //       imageAsset: Assets.uscNo,
    //       routeName: Routes.webViewScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.gisIdsTitle,
    //       imageAsset: Assets.gisIds,
    //       routeName: GlobalConstants.gisIdsTitle
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.meesevaTitle,
    //       imageAsset: Assets.meeseva,
    //       routeName: Routes.meesevaMenuScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.exceptionalsTitle,
    //       imageAsset: Assets.exceptionals,
    //       routeName: Routes.exceptionalsScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.ltmtTitle,
    //       imageAsset: Assets.ltmt,
    //       routeName: Routes.ltmtScreen),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.electroMechTitle,
    //       imageAsset: Assets.electroMech,
    //       routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.poleTrackerTitle,
    //       imageAsset: Assets.poloTracker,
    //       routeName: GlobalConstants.poleTrackerTitle,
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.dtrMasterTitle,
    //       imageAsset: Assets.dtrMaster,
    //       routeName: GlobalConstants.dtrMasterTitle
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.dListTitle,
    //       imageAsset: Assets.dList,
    //       routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.dListReportTitle,
    //       imageAsset: Assets.dListReport,
    //       routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.middlePolesTitle,
    //       imageAsset: Assets.middlePoles,
    //       routeName: Routes.middlePolesScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.checkReadingsTitle,
    //       imageAsset: Assets.checkReadings,
    //       routeName: Routes.checkReadingScreen),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.bsUdcInspectionTitle,
    //       imageAsset: Assets.bsUdcInspection,
    //       routeName: Routes.bsUdcInspectionList),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.interruptionsTitle,
    //       imageAsset: Assets.interruptions,
    //       routeName: GlobalConstants.interruptionsTitle,
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.manageStaffTitle,
    //       imageAsset: Assets.manageStaff,
    //       routeName: Routes.manageStaffsScreen
    //   ),
    //   // UniversalDashboardItem(
    //   //     title: GlobalConstants.newServicesTitle,
    //   //     imageAsset: Assets.newServices,
    //   //     routeName: routeName),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.ctPtFailureTitle,
    //       imageAsset: Assets.ctPtFailure,
    //       routeName: Routes.ctptMenuScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.pdmsTitle,
    //       imageAsset: Assets.pdms,
    //       routeName: Routes.pdmsScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.reportsTitle,
    //       imageAsset: Assets.reports,
    //       routeName: GlobalConstants.reportsTitle
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.checkMeasurementTitle,
    //       imageAsset: Assets.checkMeasurement,
    //       routeName: Routes.measureDistanceScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.foccTitle,
    //       imageAsset: Assets.focc,
    //       routeName: Routes.webViewScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.ebsTitle,
    //       imageAsset: Assets.ebs,
    //       routeName: Routes.webViewScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.matsTitle,
    //       imageAsset: Assets.mats,
    //       routeName: Routes.webViewScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.accountTitle,
    //       imageAsset: Assets.account,
    //       routeName: Routes.accountScreen
    //   ),
    //   UniversalDashboardItem(
    //       title: GlobalConstants.logoutTitle,
    //       imageAsset: Assets.logout,
    //       routeName: routeName),
    // ]);

    _allItems.addAll([
      // UniversalDashboardItem(
      //     title: GlobalConstants.updateAppTitle,
      //     imageAsset: Assets.updateApp,
      //     routeName: routeName),
      UniversalDashboardItem(
          title: GlobalConstants.cccTitle,
          imageAsset: Assets.focc,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.consumerRelatedTitle,
          imageAsset: Assets.searchConsumer,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.lineRelatedTitle,
          imageAsset: Assets.lineClearance,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.billingRelatedTitle,
          imageAsset: Assets.onlinePr,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.toolsTitle,
          imageAsset: Assets.ssMaintenance,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.dtrTitle,
          imageAsset: Assets.dtrMaster,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.subStationTitle,
          imageAsset: Assets.subStation,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.schedulesTitle,
          imageAsset: Assets.schedules,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.meesevaTitle,
          imageAsset: Assets.meeseva,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.ltmtTitle,
          imageAsset: Assets.ltmt,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.manageStaffTitle,
          imageAsset: Assets.manageStaff,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.pdmsTitle,
          imageAsset: Assets.pdms,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.reportsTitle,
          imageAsset: Assets.reports,
          routeName: ""
      ),
      UniversalDashboardItem(
          title: GlobalConstants.usefulLinksTitle,
          imageAsset: Assets.ebs,
          routeName: ""
      ),
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
        Navigation.instance.navigateTo(routeName, args: argument);
      }
    } else if(title == GlobalConstants.usefulLinksTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: GlobalConstants.foccTitle,
          routeName: Routes.webViewScreen,
          imageAsset: Assets.focc,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.ebsTitle,
          routeName: Routes.webViewScreen,
          imageAsset: Assets.ebs,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.matsTitle,
          routeName: Routes.webViewScreen,
          imageAsset: Assets.mats,
        ),
      ]);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (_) => CustomBottomSheet(
          title: title,
          items: globalListDialogItem,
          onItemSelected: (item) {
            final urlMapping = {
              GlobalConstants.uscNoTitle: UrlConstants.onlineLTConsCheckUrl,
              GlobalConstants.foccTitle: UrlConstants.foccUrl,
              GlobalConstants.ebsTitle: UrlConstants.ebsUrl,
              GlobalConstants.matsTitle: UrlConstants.matsUrl,
              GlobalConstants.viewReport: UrlConstants.viewReportUrl,
            };
            if (urlMapping.containsKey(item.title)) {
              var argument = {
                'title': item.title,
                'url': urlMapping[item.title],
              };
              Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
            } else {
              AlertUtils.showSnackBar(context, anErrorOccurred, isTrue);
            }
          },
        ),
      );
    } else if(title == GlobalConstants.consumerRelatedTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: GlobalConstants.locateConsumerTitle,
          routeName: Routes.searchConsumerScreen,
          imageAsset: Assets.searchConsumer,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.consumerDetailsTitle,
          routeName: Routes.consumerDetailsScreen,
          imageAsset: Assets.consumerDetails,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.uscNoTitle,
          routeName: Routes.webViewScreen,
          imageAsset: Assets.uscNo,
        ),
      ]);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (_) => CustomBottomSheet(
          title: title,
          items: globalListDialogItem,
          onItemSelected: (item) {
            if (item.title == GlobalConstants.uscNoTitle) {
              var argument = {
                'title': GlobalConstants.uscNoTitle,
                'url': UrlConstants.onlineLTConsCheckUrl,
              };
              Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
            } else {
              Navigation.instance.navigateTo(item.routeName);
            }
          },
        ),
      );
    } else if(title == GlobalConstants.lineRelatedTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: GlobalConstants.lineClearanceTitle,
          routeName: Routes.lineClearanceScreen,
          imageAsset: Assets.lineClearance,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.poleTrackerTitle,
          routeName: "",
          imageAsset: Assets.poloTracker,
        ),
      ]);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (_) => CustomBottomSheet(
          title: title,
          items: globalListDialogItem,
          onItemSelected: (item) {
            if(item.title == GlobalConstants.poleTrackerTitle) {
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
              showDialog(
                context: context,
                builder: (_) => CustomListDialog(
                  title: item.title,
                  items: globalListDialogItem,
                  onItemSelected: (item) {
                    Navigation.instance.navigateTo(item.routeName);
                  },
                ),
              );
            } else {
              Navigation.instance.navigateTo(item.routeName);
            }
          },
        ),
      );
    } else if(title == GlobalConstants.billingRelatedTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: GlobalConstants.verifyWrongCatConfirmed,
          routeName: Routes.onlinePrMenuScreen,
          imageAsset: Assets.yesOrNo,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.onlinePrTitle,
          routeName: Routes.onlinePrMenuScreen,
          imageAsset: Assets.onlinePr,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.gruhaJyothiTitle,
          routeName: Routes.gruhaJyothiScreen,
          imageAsset: Assets.gruhaJyothi,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.exceptionalsTitle,
          routeName: Routes.exceptionalsScreen,
          imageAsset: Assets.electricMeter,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.electroMechTitle,
          routeName: "",
          imageAsset: Assets.electricMeter,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.dListTitle,
          routeName: "",
          imageAsset: Assets.dList,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.dListReportTitle,
          routeName: "",
          imageAsset: Assets.dListReport,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.checkReadingsTitle,
          routeName: Routes.checkReadingScreen,
          imageAsset: Assets.checkReadings,
        ),
        GlobalListDialogItem(
          title: GlobalConstants.bsUdcInspectionTitle,
          routeName: Routes.bsUdcInspectionList,
          imageAsset: Assets.bsUdcInspection,
        ),
      ]);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (_) => CustomBottomSheet(
          title: title,
          items: globalListDialogItem,
          onItemSelected: (item) {
            if(item.title == GlobalConstants.dListReportTitle) {
              var argument = {
                'title': GlobalConstants.dListReportTitle,
                'url': UrlConstants.dListReportUrl,
              };
              Navigation.instance.navigateTo(Routes.webViewScreen, args: argument);
            } else {
              Navigation.instance.navigateTo(item.routeName);
            }
          },
        ),
      );
    } else if(routeName == "") {
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
      //showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.poleTrackerTitle) {
      //showCustomListDialog(context, globalListDialogItem);
    } else if(routeName == GlobalConstants.gisIdsTitle) {
      List<GlobalListDialogItem> globalListDialogItem = [];
      globalListDialogItem.addAll([
        GlobalListDialogItem(
          title: "View GIS List",
          routeName: Routes.viewGisIdsScreen,
        ),
        GlobalListDialogItem(
          title: "View Offline Forms",
          routeName: Routes.gisOfflineForms,
        ),
        GlobalListDialogItem(
          title: "View Offline Forms(Pending)",
          routeName:Routes.viewPendingOfflineForms,
        ),
      ]);
      //showCustomListDialog(context, globalListDialogItem);
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
      //showCustomListDialog(context, globalListDialogItem);
    } else {
      //Navigator.pushNamed(context, routeName);
      Navigation.instance.navigateTo(routeName);
    }
  }
}

