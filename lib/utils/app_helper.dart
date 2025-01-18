import 'dart:io';
import 'package:intl/intl.dart';

import 'package:device_info_plus/device_info_plus.dart';


class LoginSdkPrefs {
  static const String loginPrefFile = "in.tsnpdcl.loginSdk.pref";
  static const String apiPrefKey = "API_PREF_KEY";
  static const String tokenPrefKey = "TOKEN_PREF_KEY";
  static const String tokenTimePrefKey = "TOKEN_TIME_PREF_KEY";
  static const String userIdPrefKey = "USER_ID_PREF_KEY";
  static const String npdclUserPrefKey = "NPDCL_USER_PREF_KEY";
}

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

String formatIsoDateForLcRequested(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MM/yy HH:mm").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String checkNull(String? value) => value ?? "N/A";

String formatIsoDateForLcDetails(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yy HH:mm").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForPdmsDetails(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yy").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}



