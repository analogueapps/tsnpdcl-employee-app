import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String userId = 'user-id';
  static const String authToken = 'auth-token';

  static const String password = 'password';
  static const String fcmToken = 'fcm-token';

  static SharedPreferences? _preferences;

  /// Initialize the SharedPreferences instance.
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _prefs {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized. Call init() first.");
    }
    return _preferences!;
  }

  ///Method that saves the [FCM token].
  static Future<bool> setFCMToken(String value) async =>
      _prefs.setString(fcmToken, value);

  ///Method that returns the [FCM token].
  static String getFCMToken() => _prefs.getString(fcmToken) ?? '';

  ///Method that saves the [isLogin].
  static Future<bool> setLoginStatus(bool value) async =>
      _prefs.setBool('isLogin', value);

  ///Method that returns the [isLogin].
  static bool getLoginStatus() => _prefs.getBool('isLogin') ?? false;

  ///Method that saves the [Auth token].
  static Future<bool> setAuthToken(String value) async =>
      _prefs.setString(authToken, value);

  ///Method that returns the [Auth token].
  static String getAuthToken() => _prefs.getString(authToken) ?? '';

  ///Method that saves the [String Value].
  static Future<bool> setStringValue(String tag, String value) async =>
      _prefs.setString(tag, value);

  ///Method that returns the [String Value].
  static String getStringValue(String tag) => _prefs.getString(tag) ?? '';

  ///Method that saves the [int Value].
  static Future<bool> setIntValue(String tag, int value) async =>
      _prefs.setInt(tag, value);

  ///Method that returns the [int Value].
  static int getIntValue(String tag) => _prefs.getInt(tag) ?? -1;

  ///Method that saves the [Bool Value].
  static Future<bool> setBoolValue(String tag, bool value) async =>
      _prefs.setBool(tag, value);

  ///Method that returns the [Bool Value].
  static bool getBoolValue(String tag) => _prefs.getBool(tag) ?? false;

  /// Clears all stored data.
  static Future<bool> clearData() async {
    String? retainedValue = _prefs.getString(fcmToken) ?? '';
    bool success = await _prefs.clear();
    await _prefs.setString(fcmToken, retainedValue);
    return success;
  }
}