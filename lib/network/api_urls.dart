
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

  ///

  ///Asset Mapping
  static const ROOT_URL_ASSET_MAPPING = "http://210.212.223.88:5656/NPFDAS/ep/asset/";
  static const ASSET_MAPPING_URL="/map";

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
  static const GET_POLE_FIRMS_URL = "getPoleFirms";
  static const CREATE_FIRM_URL = "createFirm";
  static const UPDATE_FIRM_URL = "updateFirm";
  static const GET_TICKETS_OF_STATUS_URL = "getTicketsOfStatus";
  static const GET_FILTERED_TICKETS_URL = "getFilteredTickets";
  static const GET_TICKETS_FILTER_DATA_URL = "getTicketsFilterData";
  static const GET_INSPECTION_OFFICERS_URL = "getInspectionOfficers";
  static const ASSIGN_TICKET_URL = "assignTicket";
  static const CLOSE_TICKET_URL = "closeTicket";

  /// REPORTS
  static const GET_CTPT_BAR_GRAPH_DATA_URL = "getCtPtBarGraphData";
  static const GET_MIDDLE_POLES_BAR_GRAPH_DATA_URL = "getMiddlePolesBarGraphData";
  static const GET_MAINTENANCE_BAR_GRAPH_DATA_URL = "getMaintenanceBarGraphData";

  /// DTR MAINTENANCE
  static const DTR_END_POINT_BASE_URL = "$SERVER_IP:5656/NPFDAS/ep/dtr/";
  static const GET_DTR_MASTER_INDEX_URL = "getDtrMasterIndex";
  static const OPEN_DTR_DEFECT_SHEET="openDtrDefectSheet";
  static const GET_DTR_MASTER_FILTER_DATA_URL = "getDtrMasterFilterData";
  static const GET_FILTERED_DTR_MASTER_DATA_URL = "getFilteredDtrMasterData";
  static const GET_DTR_INSPECTIONS_URL = "getDtrInspections";
  static const GET_DTR_INSPECTIONS_FILTER_DATA_URL = "getDtrInspectionsFilterData";
  static const GET_FILTERED_DTR_INSPECTIONS_DATA_URL = "getFilteredDtrInspections";
  static const GET_EMPLOYEE_OF_SECTION_URL = "getEmployeesOfSection";
  static const ASSIGN_DTR_INSPECTION_URL = "assignDtrInspection";

  ///DTR DEFECTS * Bhavana
  //assignDtrMaintenance
  static const ASSIGN_DTR_MAINTENANCE_URL = "assignDtrMaintenance";

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

  ///CCC * BHAVANA
  static const CCC_END_POINT_BASE_URL="$SERVER_IP:5656/NPFDAS/ep/ccc/";
  static const GET_ABSTRACT="getAbstract";
  static const GET_CCC_TICKETS="getCCCTickets";
  static const UPDATE_TICKET="updateCCCTicket";
  static const CALL_CONSUMER="connectWithConsumer";
  static const COMPLAINT_STATUS="getCCCTicketTrack";

  ///SCHEDULES *BHAVANA
  static const SCHEDULES_URL="getTourDairyByMonth";
  static const SS_URL="getSSMasterIndex";
  static const  SCHEDULE_SS="scheduleSSMaintenance";
  static const  LINE_FEEDERS="get11kvFeedersOf33KvSS";
  static const SCHEDULE_LINE="schedule11KvLineMaintenance";
  static const VIEW_SCHEDULE="getTourDairyByDate";
  static const GET_SS_INSPECTION_BY_ID="getSSInspectionByScheduleId";
  static const SAVE_MAINTENANCE="saveSSMaintenance";
  static const SAVE_INSPECTION="saveSSInspection";

  ///VERIFY WRONG CONFIRMATION * BHAVANA
  static const VERIFY_WRONG_CONFIRM_URL="$SERVER_IP:5656/NPFDAS/ep/wrongCat/";
  static const GET_ALL_ABSTRACT="getAllAbstract";
  static const GET_VERIFY_ABSTRACT="getAbstract";
  static const GET_CAT_CONFIRM="getCatConfirmEntities";


  ///PTR & FEEDER LOADERS
  static const GET_PTR_FEEDERS_SS="getPtrAndFeedersOfSs";
  static const SAVE_PTR_FEEDERS="savePtrAndFeederLoads";

  ///POLE TRACKER
 static const CREATE_NEW_PROPOSAL="createNewProposal";

  ///Exceptionals
  static String IP_PORT_METER_MAKE=SERVER_IP.startsWith("http://192.168.30")?"http://10.100.4.58:7000":"http://210.212.223.83:7000";
  static const METER_MAKE="/NpdclEmployeeWebApi/npemp/api";
  static String METER_CHANGE="http://10.100.4.58:7000/NpdclEmployeeWebApi/npemp/api";
  static String METER_CHANGE_COMPLETE_ROOT = "/NpdclEmployeeWebApi/npemp/api";
  static const METER_CHANGE_BASE_URL = "http://10.100.4.58:7000";

  //Meeseva -> Category Change
  static const CAT_CHANGE_ENDPOINT_URL = "$SERVER_IP:5656/NPFDAS/ep/cat-change/";
  static const CAT_CHANGE_REQUESTS_OF_SECTION="getCatChangeRequestsOfSection";
  static const UPDATE_CAT_CHANGE="updateCatChangeApplication";
  static const MAKE_CAPACITIES="getMakesAndCapacities";
  static const MEE_SEVA_MODIFY_SEVICE_DOCUMENTS_URL="http://210.212.223.83:7000/J2S/j2s//nc/Reports/MSDDocumentsView.jsp?xregNum=";

  //Meeseva -> Load Change
  static const LOAD_CHANGE_REQUEST_URL="$SERVER_IP:5656/NPFDAS/ep/load-change/";
  static const LOAD_CHANGE_REQUEST_OF_SECTION="getLoadChangeRequestsOfSection";

  ///Manage staff ->Saikiran
  static const GET_EMPLOYEE_URL="/NpdclEmployeeWebApi/npemp/api";
  static const SS_BASE_URL="http://210.212.223.88:5656";
  static const SS_MAIN_URL="/NPFDAS/ep/ss/getSSMasterIndex";


  /// DAILY NIL REPORT
 static const DAILY_NIL_URL="$SERVER_IP:5656/NPFDAS/ep/dpms/";
 static const DAILY_NIL="saveNilReport";

 ///ROUTE FROM CCC
  static const ERO_CORRESPONDENCE_URL="$SERVER_IP:5656/NPFDAS/ep/eroCorrespondence/";
  static const CCC_COMPLAINTS_URL="getCCCDivertedComplaints";
  static const GET_USCNO_SERVICE_OF_SECTION="getUscnoServiceOfSection";
  static const CREATE_DISMANTLE="createDismantleService";
  static const GET_DETAILED_TICKET="getDetailedTicket";
}

