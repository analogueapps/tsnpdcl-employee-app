
// ignore_for_file: constant_identifier_names

class Apis{

  /// API KEY
  static const API_KEY = "d0bbef01-87c6-4629-9659-d95c59c22a9c";

  /// <<<<<<<<<< *** ALL URLS SECTION WISE *** >>>>>>>>>> ///
  /// AUTHENTICATION
  static const ROOT_URL = "http://210.212.223.83:7000/";
  static const AUTH_URL = "NpdclLoginSdkWebApi/sdk/webapi";

  /// IMAGE
  static const NPDCL_STORAGE_SERVER_IP = "http://210.212.223.83:7000/NpdclFileStorageWebApi/";
  ///IMAGE UPLOAD URL
  static const IMAGE_UPLOAD_URL="$ROOT_URL/NpdclFileStorageWebApi/tsnpdcl/fd/api/imr";

  /// CONSUMER RELATED
  static const NPDCL_EMP_URL = "NpdclEmployeeWebApi/npemp/api";

  ///CHECK READING ROOT DOMAIN * BHAVANA
  static const CHECK_ROOT_URL="http://210.212.223.87:8181/NPDCL2019WebApi/rest/";

  /// LINE RELATED
  static const SERVER_IP = "http://210.212.223.88";
  static const SS_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/ss/";
  static const GET_SS_OF_SECTION_URL = "getSSOfSection";
  static const GET_11KV_FEEDER_OF_33KV_SS_URL = "get11kvFeedersOf33KvSS";
  static const LC_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/lc/";
  static const GET_INDUCTION_POINTS_OF_FEEDER_URL = "getInductionPointsOfFeeder";
  static const ADD_INDUCTION_POINT_URL = "addInductionPoint";
  static const GET_ALL_LC_REQUEST_LIST_URL = "getAllLcRequests";
  static const GET_DETAILED_LC_URL = "getLc";

  /// PDMS
  static const PDMS_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/pdms/";
  static const GET_INDENTS_OF_STATUS_URL = "getIndentsOfStatus";
  static const GET_INDENTS_FILTER_DATA_URL = "getIndentsFilterData";
  static const GET_FILTERED_INDENTS_DATA_URL = "getFilteredIndents";
  static const REQUEST_OTP_URL = "requestOtp";
  static const REQUEST_UN_AUTH_OTP_URL = "requestUnAuthOtp";
  static const VERIFY_OTP_URL = "verifyOTP";
  static const CREATE_POLE_INDENT_URL = "createPoleIndent";
  static const UPDATE_POLE_INDENT_URL = "updatePoleIndent";
  static const FORWARD_POLE_INDENT_TO_STORES_URL = "forwardPoleIndentToStores";
  static const GET_DIS_OF_STATUS_URL = "getDisOfStatus";
  static const GET_DIS_FILTER_DATA_URL = "getDisFilterData";
  static const GET_FILTERED_DIS_DATA_URL = "getFilteredDis";
  static const SAVE_FORM_13_DATA_URL = "saveForm13Data";
  static const REQUEST_DI_DOWNLOAD_LINK_URL = "requestDIDownloadLink";
  static const GET_POLE_DUMPED_LOCATION_URL = "getPoleDumpLocations";

  /// REPORTS
  static const GET_CTPT_BAR_GRAPH_DATA_URL = "getCtPtBarGraphData";
  static const GET_MIDDLE_POLES_BAR_GRAPH_DATA_URL = "getMiddlePolesBarGraphData";
  static const GET_MAINTENANCE_BAR_GRAPH_DATA_URL = "getMaintenanceBarGraphData";

  /// DTR MAINTENANCE
  static const DTR_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/dtr/";
  static const GET_DTR_MASTER_INDEX_URL = "getDtrMasterIndex";
  static const GET_DTR_MASTER_FILTER_DATA_URL = "getDtrMasterFilterData";
  static const GET_FILTERED_DTR_MASTER_DATA_URL = "getFilteredDtrMasterData";
  static const GET_DTR_INSPECTIONS_URL = "getDtrInspections";
  static const GET_DTR_INSPECTIONS_FILTER_DATA_URL = "getDtrInspectionsFilterData";
  static const GET_FILTERED_DTR_INSPECTIONS_DATA_URL = "getFilteredDtrInspections";
  static const GET_EMPLOYEE_OF_SECTION_URL = "getEmployeesOfSection";
  static const ASSIGN_DTR_INSPECTION_URL = "assignDtrInspection";

  /// INTERRUPTIONS * SWETHA
  static const INTERRUPTIONS_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/interruptions/";
  /// 33KV BREAKDOWN ENTRY * DROPDOWN FIELDS
  static const GET_132KV_SUBSTATIONS_OF_SECTION = "get132kvSubstationsOfSection";
  static const GET_FEEDERS_OF_132KV_SS = "getFeedersOf132kvSs";
  /// 11KV BREAKDOWN ENTRY * DROPDOWN FIELDS
  static const GET_SUBSTATIONS_OF_SECTION = "getSubstationsOfSection";
  static const GET_FEEDERS_OF_SS = "getFeedersOfSs";
  /// SAVING FORMS
  static const SAVE_BREAKDOWN_REPORT = "saveBreakDownReport";
  /// GET 33KV DATA
  static const GET_BREAKDOWNS_OF_SECTION = "getBreakDownsOfSection";

  /// Tong tester readings
  static const TONG_TESTER_END_POINT_BASE_URL = "$ROOT_URL$NPDCL_EMP_URL";
  static const String GET_SECTIONS_OF_SUBDIVISION = "/getSectionOfSubdivision";
  static const String GET_STRUCTURES_OF_SECTION = "/getStructuresOfSection";
  static const String GET_DTRS_OF_STRUCTURE = "/getDtrsOfStructure";
  static const String SAVE_TONG_TESTER_READING = "/savedTongTesterReading";
  static const GET_TONG_TEST_READINGS="getTongTesterReadings";

  /// Account
  static const String LOAD_ACCOUNT = "/load/account";

  /// CTPT FAILURE
  static const String CTPT_END_POINT_BASE_URL = "$ROOT_URL$NPDCL_EMP_URL";
  static const String GET_HT_SERVICES = "getHTServices";

  ///SS MAINTENANCE * BHAVANA
  static const GET_SS_MAINTENANCE= "getSSInspections";
  static const SS_MAINTENANCE_WEB_URL="$SERVER_IP:5656/NPFDAS/SSMaintenanceView?iid=";

  ///Dtr Failure
  static const SAVE_DTR_FAILURE_URL = "saveDtrFailureReport";
  static const GET_DTR_REPORTS_FR="getDtrFailureReports";

  ///CHECK READINGS * BHAVANA
  static const GET_EROS="api/getEros";
  static const  VALIDATE_SERVICE="api/validateService";
  static String CHECK_BS_UDC_IP_PORT=SERVER_IP.startsWith("http://192.168.30")?"http://10.100.4.58:7000":"http://210.212.223.83:7000";
  static String CHECK_BS_UDC_WED_URL=CHECK_BS_UDC_IP_PORT+"/NpdclEmployeeWebApi/";

  ///ONLINE PR * BHAVANA
  static const   ONLINE_PR_END_POINT_BASE_URL= "$SERVER_IP:5656/NPFDAS/ep/onlinePr/";
  static const ISSUE_DUPLICATE_URL = "authenticateRcDevice";

  ///CCC
  static const CCC_END_POINT_BASE_URL="$SERVER_IP:5656/NPFDAS/ep/ccc/";
  static const GET_ABSTRACT="getAbstract";
  static const GET_CCC_TICKETS="getCCCTickets";

  ///SCHEDULES
  static const SCHEDULES_URL="getTourDairyByMonth";
  static const SS_URL="getSSMasterIndex";
  static const  SCHEDULE_SS="scheduleSSMaintenance";
  static const  LINE_FEEDERS="get11kvFeedersOf33KvSS";
  static const SCHEDULE_LINE="schedule11KvLineMaintenance";
  static const VIEW_SCHEDULE="getTourDairyByDate";

}