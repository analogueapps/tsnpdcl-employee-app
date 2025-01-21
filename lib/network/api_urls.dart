
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

  /// CONSUMER RELATED
  static const NPDCL_EMP_URL = "NpdclEmployeeWebApi/npemp/api";

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
  static const REQUEST_OTP_URL = "requestOtp";
  static const REQUEST_UN_AUTH_OTP_URL = "requestUnAuthOtp";
  static const VERIFY_OTP_URL = "verifyOTP";
  static const UPDATE_POLE_INDENT_URL = "updatePoleIndent";
  static const FORWARD_POLE_INDENT_TO_STORES_URL = "forwardPoleIndentToStores";


}