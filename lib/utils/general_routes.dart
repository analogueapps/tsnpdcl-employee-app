class Routes {
  // AUTH
  static const String splashScreen = 'SplashScreen';

  static const String employeeIdLoginScreen = 'employee_id_login_screen';
  static const String corporateLoginScreen = 'corporate_login_screen';
  static const String changePasswordScreen = 'ChangePasswordScreen';
  static const String otpVerificationScreen = 'OtpVerificationScreen';

  // DASHBOARD
  static const String universalDashboardScreen = 'universal_dashboard_screen';
  static const String naviDashboardScreen = 'NaviDashboardScreen';
  static const String adeopNaviScreen = 'AdeopNaviScreen';
  // INSIDE DASHBOARD MENUS
  static const String searchConsumerScreen = 'search_consumer_screen';
  static const String lineClearanceScreen = 'line_clearance_screen';
  static const String assetMappingScreen = 'asset_mapping_screen';
  static const String ganeshPandalInfoScreen = 'ganesh_pandal_info_screen';
  static const String onlinePrMenuScreen = 'online_pr_menu_screen';
  static const String measureDistanceScreen = 'measure_distance_screen';
  static const String dtrMaintenanceScreen = 'dtr_maintenance_screen';
  static const String dtrFailureScreen = 'dtr_failure_screen';
  static const String failureDtrInspectionScreen = 'failure_dtr_inspection_screen';
  static const String pdmsScreen = 'pdms_screen';
  static const String ctptMenuScreen = 'ctpt_menu_screen';
  static const String consumerDetailsScreen = 'consumer_details_screen';
  static const String webViewScreen = 'web_view_screen';
  static const String meesevaMenuScreen = 'meeseva_menu_screen';
  static const String sectionScreen = 'SectionScreen';

  // CONSUMER
  static const String dListFormScreen = 'dlist_form_screen';

  // LINE CLEARANCE
  static const String lcMasterSsListScreen = 'LcMasterSsListScreen';
  static const String lcMasterFeederListScreen = 'LcMasterFeederListScreen';
  static const String feederInductionListScreen = 'FeederInductionListScreen';
  static const String addInductionPointScreen = 'AddInductionPointScreen';
  static const String allLcRequestListScreen = 'AllLcRequestListScreen';
  static const String viewLineClearanceScreen = 'ViewLineClearanceScreen';
  static const String viewDetailedLcScreen = 'ViewDetailedLcScreen';

  // POLE TRACKER
  static const String poleTrackerSelectionViewSketchScreen = "PoleTrackerSelectionViewSketchScreen";
  static const String viewDigitalSketchScreen = "ViewDigitalSketchScreen";
  static const String newProposalScreen = "NewProposalScreen";
  static const String poleTrackerSelectionScreen = "PoleTrackerSelectionScreen";
  static const String poleProposal11kvFeederMarkScreen = "PoleProposal11kvFeederMarkScreen";
  static const String pole33kvProposalFeederMarkScreen = "Pole33kvProposalFeederMarkScreen";
  static const String pole11kvFeederMarkScreen = "Pole11kvFeederMarkScreen";
  static const String viewOfflineFeedersScreen = "ViewOfflineFeedersScreen";

  // BILLING RELATED
  static const String gruhaJyothiScreen = "GruhaJyothiScreen";

  // MANAGE STAFF
  static const String manageStaffsScreen = "ManageStaffsScreen";

  // PDMS
  static const String createPoleIndentsScreen = "CreatePoleIndentsScreen";
  static const String viewDetailedPoleIndentScreen = "ViewDetailedPoleIndentScreen";
  static const String viewDispatchInstructionsScreen = "ViewDispatchInstructionsScreen";
  static const String viewDetailedDiTabsScreen = "ViewDetailedDiTabsScreen";
  static const String viewDetailedTransportScreen = "ViewDetailedTransportScreen";
  static const String viewPoleDumpedLocationScreen = "ViewPoleDumpedLocationScreen";
  static const String viewDetailedPoleDumpedLocationScreen = "ViewDetailedPoleDumpedLocationScreen";
  static const String viewFirmsScreen = "ViewFirmsScreen";
  static const String createFirmScreen = "CreateFirmScreen";
  static const String viewInspectionTicketsScreen = "ViewInspectionTicketsScreen";
  static const String viewDetailedInspectionTicketScreen = "ViewDetailedInspectionTicketScreen";

  // REPORTS
  static const String reportsScreen = "ReportsScreen";

  // EXCEPTIONALS
  static const String exceptionalsScreen = "ExceptionalsScreen";

  // FILTER
  static const String filterScreen = "FilterScreen";

  // DTR MAINTENANCE
  static const String dtrMasterListScreen = "DtrMasterListScreen";
  static const String dtrInspectionListScreen = "DtrInspectionListScreen";
  static const String dtrMaintenanceInspectionScreen = "DtrMaintenanceInspectionScreen";

  static const String ganeshPandalInformationScreen = 'ganesh_pandal_information_screen';

  // WIDGETS
  static const String pinchZoomImageView = 'PinchZoomImageView';

  //tong tester readings * swetha
  static const String tongTesterReadingsScreen = 'TongTesterReading';
  static const String overLoadDTRList = 'OverLoadDTRList';
  static const String viewDetailedTongTesterReadings="ViewDetailedTongTesterReadings";


  // RFSS Screen * swetha
  static const String rfssScreen = 'RfssScreen';
  // * Bhavana
  static const String nonAglService='NonAglServices';
  static const String aglService='AglServices';
  static const String openNewInspection="NewInspection";
  static const String downloadStructures="DownloadStructuresScreen";

  // Middle Poles Screen * Swetha
  static const String middlePolesScreen = 'MiddlePolesScreen';
  static const String middlePoles33kv = 'MiddlePoles33kv';
  static const String middlePole11kv = 'MiddlePole11kv';
  static const String pendingCompletedListScreen = 'PendingListScreen';
  static const String viewDetailedPendingListScreen = 'ViewDetailedPendingListScreen';
  static const String pendingListFloatingButton = 'PendingListFloatingButton';

  // SS Maintenance Screen * Swetha
  static const String ssMaintenanceScreen = 'SsMaintenanceScreen';
  static const String maintenanceDueScreen = 'MaintenanceDueScreen';
  static const String maintenanceFinishedScreen = 'MaintenanceFinishedScreen';

  //ltmt * Bhavana
  static const String ltmtScreen='LtmtMenu';
  static const String metersStock= 'MetersStock';
  static const String meterOM="MetersOm";

  //DTR Master * Bhavana
  static const String mappedDtrScreen= "MappedDtr";
  static const String dtrStructure="StructDetails";
  static const String configureFilter="ConfigureFilter";
  static const String downloadFeederScreen="DownloadFeederData";
  static const String misMatched="MisMatchedDtr";
  static const String offlineData= "ViewOfflineDataDTR";
  static const String createOnlineDTR="CreateDtrOnline";
  static const String createOfflineDTR="CreateDtrOffline";

  //DTR Failures
  static const String viewFailureReports="ViewRectifiedReports";
  static const String dtrFailureReportingScreen="ReportDTRFailure";
  static const String dtrFailureRectifiedScreen="DtrFailureRectifiedReports";

  //Failure DTR(s) Inspected *Bhavana
  static const String failureDTRsInspectionScreen="ReportedDTRFailure";
  static const String viewDTRsInspectionScreen="ViewInspectionReports";
  static const String viewDTRsClosedScreen="ViewClosedReports";

  // Interruptions * swetha
  static const String breakdown33kvScreen = "Breakdown33kvScreen";
  static const String breakdown11kvScreen = "Breakdown11kvScreen";
  static const String interruptionsEntryScreen = "InterruptionsEntryScreen";
  static const String saidiSaifiCalculatorScreen = "SaidiSaifiCalculatorScreen";
  static const String viewSaidiSaifiScreen = "ViewSaidiSaifiScreen";
  static const String view33kvBreakdownScreen = "View33kvBreakdownScreen";
  static const String view11kvBreakdownScreen = "View11kvBreakdownScreen";
  static const String detailedView33kvBreakdownScreen = "DetailedView33kvBreakdownScreen";
  static const String detailedView11kvBreakdownScreen = "DetailedView11kvBreakdownScreen";
  static const String view33kvOpenRestoreDetails = "View33kvOpenRestoreDetails";
  static const String view11kvOpenRestoreDetails = "View11kvOpenRestoreDetails";
  static const String monthYearSelector = "MonthYearSelector";
  static const String viewReportScreen = "ViewReportScreen";

  // CT PT FAILURE/REPLACEMENT
  static const String reportCtPtFailure = "CTFailureReportScreen";
  static const String viewCtPtReportList = "FailureReportedList";
  static const String failureIndividual = "IndividualFailureReport";
  static const String viewDetailedCtptReport = "ViewDetailedCtptReport"; // * swetha
  static const String viewFailureConfirmedList="ViewFailureConfirmedList"; // *Bhavana
  static const String viewIssuedList="ViewFailureConfirmedList"; // *Bhavana
  static const String viewReplacedList="ViewFailureConfirmedList"; // *Bhavana

  //GIS DIS * Bhavana
  static const String viewGisIdsScreen="GISIDsScreen";
  static const String createGisIds="CreateGisId";
  static const String gisIndividual="GisIndividualId";
  static const String addGis="AddGisPoint";
  static const String viewWorkScreen="WorkDetailsPage";
  static const String viewWorkFloatButtonScreen="ViewWorkFloatingButton";
  static const String viewPendingOfflineForms="PendingOfflineList";
  static const String gisOfflineForms="GisOfflineList";


  // ACCOUNT * SWETHA
  static const String accountScreen = "AccountScreen";

  //CHECK READINGS * Bhavana
  static const String checkReadingScreen = "CheckReadings";
  static const String enterServicesScreen = "EnterServiceDetails";

  //BS/UDC * Bhavana
  static const String bsUdcInspectionList = "BsUdcList";

  //Online PR * Bhavana
  static const String issueDuplicateReceipt="IssueDuplicateReceipt";
  static const String printLastPR="PrintLastPrView";
  static const String onlinePRReports="ReportsView";
  static const String onlineCollection="OnlineCollectionView";


  // Meeseva * Surya
  static const String meeSevaAbstractScreen = "MeeSevaAbstractScreen";
  static const String servicesAppListScreen = "ServicesAppListScreen";
  static const String formLoaderScreen = "FormLoaderScreen";

  // Dlist * Surya
  static const String dlistMenuScreen = "DlistMenuScreen";
  static const String rangeWiseDlistScreen = "RangeWiseDlistScreen";
  static const String clusterMapScreen = "ClusterMapScreen";
  static const String dlistAttendScreen = "DlistAttendScreen";
  static const String dlistFilterScreen = "DlistFilterScreen";

  //CCC * Bhavana
  static const String cccDashboard = "CCCDashboardScreen";
  static const String cccORICB="CccOricb";
  static const String openDetail="CCCViewDetailed";

  //SCHEDULES *BHAVANA
  static const String schedule="SchedulesScreen";
  static const String viewSchedule="ViewSchedule";
  static const String  viewDetailSchedule="ViewDetailSchedules";
  static const String kv33Screen="Kv33Screen";
  static const String ssInspect="SsInspection";

  //VERIFY WRONG CONFIRMATIONS
  static const String areaWiseAbstract="AreaWiseAbstractView";
  static const String inspectServices="InspectServices";

    //PTR & FEEDERS LOADERS
    static const String ptrFeederScreen="PtrFreederScreen";

    //CHECK MEASUREMENT(LINES)*BHAVANA
    static const String checkMeasureScreen="CheckMeasureScreen";
    static const String docketScreen="DocketScreen";
    static const String pole11kvScreen="Pole11kvFeeder";
    static const String pole33kvScreen="Pole33kvFeeder";
    static const String check33kvScreen="CheckMeasure11kv";
    static const String check11kvScreen="CheckMeasure33kv";

}