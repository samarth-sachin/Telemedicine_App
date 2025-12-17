import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User Profile
  static Future<void> setUserName(String name) async {
    await _prefs?.setString('user_name', name);
  }

  static String getUserName() {
    return _prefs?.getString('user_name') ?? 'User';
  }

  static Future<void> setUserAge(int age) async {
    await _prefs?.setInt('user_age', age);
  }

  static int getUserAge() {
    return _prefs?.getInt('user_age') ?? 0;
  }

  static Future<void> setUserGender(String gender) async {
    await _prefs?.setString('user_gender', gender);
  }

  static String getUserGender() {
    return _prefs?.getString('user_gender') ?? 'Not specified';
  }

  // Onboarding
  static Future<void> setOnboardingComplete(bool completed) async {
    await _prefs?.setBool('onboarding_complete', completed);
  }

  static bool isOnboardingComplete() {
    return _prefs?.getBool('onboarding_complete') ?? false;
  }

  // App Settings
  static Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs?.setBool('notifications_enabled', enabled);
  }

  static bool areNotificationsEnabled() {
    return _prefs?.getBool('notifications_enabled') ?? true;
  }

  static Future<void> setDarkMode(bool enabled) async {
    await _prefs?.setBool('dark_mode', enabled);
  }

  static bool isDarkModeEnabled() {
    return _prefs?.getBool('dark_mode') ?? false;
  }

  // First launch
  static Future<void> setFirstLaunch(bool isFirst) async {
    await _prefs?.setBool('first_launch', isFirst);
  }

  static bool isFirstLaunch() {
    return _prefs?.getBool('first_launch') ?? true;
  }

  // Last consultation time
  static Future<void> setLastConsultationTime(DateTime time) async {
    await _prefs?.setString('last_consultation', time.toIso8601String());
  }

  static DateTime? getLastConsultationTime() {
    String? timeStr = _prefs?.getString('last_consultation');
    return timeStr != null ? DateTime.parse(timeStr) : null;
  }

  // Clear all preferences
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  // Check if profile is complete
  static bool isProfileComplete() {
    return getUserName() != 'User' && getUserAge() > 0;
  }
}
