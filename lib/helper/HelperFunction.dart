import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceNameKey = "USERNAMEKEY";
  static String sharedPreferenceEmailKey = "USEREMAILKEY";
  static String sharedPreferenceIdKey = "USERIDKEY";

  // Saving LoggedIn data to shared preferences
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceLoggedInKey, isUserLoggedIn);
  }

  // Saving username to shared preferences
  static Future<bool> saveUserFNameSharedPreference(String fname) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceNameKey, fname);
  }

  static Future<bool> saveUserLNameSharedPreference(String lname) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceNameKey, lname);
  }

  static Future<bool> saveUserIdSharedPreference(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceIdKey, userId);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceEmailKey, userEmail);
  }

  // Getting data in shared preferences
  static Future<String?> getUserIdSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceIdKey);
  }

  static Future<bool?> getUserLoggedInSharedPreference() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceLoggedInKey);
  }

  static Future<String?> getUserNameSharedPreference() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceNameKey);
  }

  static Future<String?> getUserEmailSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceEmailKey);
  }

  static Future<bool> logOutSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
