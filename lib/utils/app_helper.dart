import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:device_info_plus/device_info_plus.dart';


class LoginSdkPrefs {
  static const String loginPrefFile = "in.tsnpdcl.loginSdk.pref";
  static const String apiPrefKey = "API_PREF_KEY";
  static const String tokenPrefKey = "TOKEN_PREF_KEY";
  static const String tokenTimePrefKey = "TOKEN_TIME_PREF_KEY";
  static const String userIdPrefKey = "USER_ID_PREF_KEY";
  static const String npdclUserPrefKey = "NPDCL_USER_PREF_KEY";
  static const String sectionCodePrefKey = "SECTION_CODE_PREF_KEY";
  static const String circleIdPrefKey = "CIRCLE_ID_PREF_KEY";
  static const String sectionPrefKey = "SECTION_PREF_KEY";
  static const String subDivisionPrefKey="SUBDIVISION_PREF_KEY";
  static const String sectionIdKey = "SECTION_ID_KEY";
  static const String divisionIdKey="DIVISION_ID_KEY";
  static const String designationCodeKey="DESIGNATION_CODE_KEY";
  static const String empNameKey="EMP_NAME_KEY";
  static const String eroId="ERO_ID";

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
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMMM dd, yyyy hh:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yy").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForDiDetails(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMM dd, yyyy h:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yyyy HH:mm").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForDiShippingDetails(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMM dd, yyyy h:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yyyy").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForDtrInspectionDetails(String isoDate) {
  try {
    /// Parse the input string to DateTime
    DateTime dateTime = DateTime.parse(isoDate);

    // Convert to IST (UTC+5:30)
    dateTime = dateTime.toUtc().add(const Duration(hours: 5, minutes: 30));

    // Format the date
    return DateFormat("dd/MM/yyyy hh:mm a").format(dateTime);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForTicketDetails(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yyyy HH:mm").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForTicketDetailsOnlyDate(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("dd/MMM/yyyy").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

String formatIsoDateForTicketDetailsOnlyTime(String isoDate) {
  try {
    // Parse the ISO 8601 date string
    //DateTime parsedDate = DateTime.parse(isoDate);
    DateTime parsedDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(isoDate);

    // Format the date to the desired format: dd/MM/yy HH:mm
    return DateFormat("hh:mm:ss a").format(parsedDate);
  } catch (e) {
    // Handle any parsing errors
    print("Error formatting date: $e");
    return 'N/A';
  }
}

LatLng parseLatLngFromString(String? latLong) {
  if (latLong == null || !latLong.contains(',')) {
    return const LatLng(0.0, 0.0);
  }

  try {
    final parts = latLong.split(',');
    if (parts.length != 2) return const LatLng(0.0, 0.0);

    double parseCoord(String value) {
      value = value.trim().toUpperCase();
      final isNegative = value.contains('S') || value.contains('W');
      final cleaned = value.replaceAll(RegExp(r'[NSEW]'), '');
      final num = double.parse(cleaned);
      return isNegative ? -num : num;
    }

    final lat = parseCoord(parts[0]);
    final lng = parseCoord(parts[1]);

    return LatLng(lat, lng);
  } catch (e) {
    return const LatLng(0.0, 0.0);
  }
}



