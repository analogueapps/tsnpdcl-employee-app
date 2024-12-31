import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if(Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // The Android ID
    return androidInfo.id;
  } else if(Platform.isAndroid) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // The iOS ID
    return iosInfo.identifierForVendor;
  }
  return "in.tsnpdcl.npdclemployee";
}

class LoginSdkPrefs {
  static const String loginPrefFile = "in.tsnpdcl.loginSdk.pref";
  static const String apiPrefKey = "API_PREF_KEY";
  static const String tokenPrefKey = "TOKEN_PREF_KEY";
  static const String tokenTimePrefKey = "TOKEN_TIME_PREF_KEY";
  static const String userIdPrefKey = "USER_ID_PREF_KEY";
  static const String npdclUserPrefKey = "NPDCL_USER_PREF_KEY";
}

