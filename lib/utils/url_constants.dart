import 'package:tsnpdcl_employee/preference/shared_preference.dart';

import 'app_helper.dart';

class UrlConstants {
  // dashboard name
  static const String onlineLTConsCheckUrl = "http://210.212.223.83:9000/EBS/Consumer%20Management/OnlineLTConsCheck.jsp";
  static const String foccUrl = "http://ccc.npdcl.com:9000/ConVoxCCS/index.php";
  static const String ebsUrl = "http://210.212.223.83:9000/EBS/";
  static const String matsUrl = "http://210.212.223.83:7000/MATS2/";
  static const String viewSaidiUrl = "http://210.212.223.83:7000/NpdclEmployeeWebApi/viewSaidiSaifiv2.jsp?";
  static const String viewReportUrl = "http://210.212.223.82/ATS/login/1/mis/reports/InterruptionRpt?interruptionFlag=&secMaster.divisionId=&fromDate=2024-04-08&toDate=2024-04-08&result=AppFDRAbst";
  static  String dListReportUrl="http://210.212.223.83:7000/NpdclEmployeeWebApi/dlistReport.jsp?cid=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.circleIdPrefKey)}&id=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.divisionIdKey)}";


}