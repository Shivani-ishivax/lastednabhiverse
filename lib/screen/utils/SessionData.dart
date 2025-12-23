import 'dart:convert';


import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = "is_logged_in";
  static const String _keyUserToken = "user_token";
  static const String _sessionKey = 'session_data';

  /// Save session data
  static Future<void> saveSessionToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserToken, token);
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Retrieve user token
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserToken);
  }

  /// Clear session
  static Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserToken);

    await prefs.remove(_sessionKey);
  }
  static Future<void> saveSessionUserData(LoginUser sessionData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionJson = jsonEncode(sessionData.toJson());
    await prefs.setString(_sessionKey, sessionJson);
  }
  static Future<LoginUser?> getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionJson = prefs.getString(_sessionKey);
    if (sessionJson != null) {
      Map<String, dynamic> sessionMap = jsonDecode(sessionJson);
      return LoginUser.fromJson(sessionMap);
    }
    else{
      // Dummy user when no session exists
      print("dummy data");
      return LoginUser(
        loginid: 0,
        name: "Guest",
        email: "",
        role: 0,
        gender: "",
        dob: "",
        imagePath: "",
        mobileNo: "",
        profileType: 0,
        referralCode: "",
        trialAddress: "",
        referralCount: 0,
        reward: 0,
      );

    }
    return null;
  }




}