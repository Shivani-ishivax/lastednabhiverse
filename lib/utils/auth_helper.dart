import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/screen/auth_screen/login_view.dart';

import '../screen/utils/SessionData.dart';

/// Authentication Helper Class
/// Use this helper to check if user is logged in before performing actions
class AuthHelper {
  /// Check if user is logged in and execute callback if true
  /// Otherwise navigate to login screen
  ///
  /// Usage:
  /// ```dart
  /// onTap: () => AuthHelper.checkAuthAndExecute(
  ///   context: context,
  ///   onAuthenticated: () {
  ///     // Your code here
  ///     print("User is logged in");
  ///   },
  /// ),
  /// ```
  /// //---------kripal------------this-is-wokring-and-used-------------------------
  static Future<void> checkAuthAndExecute({
    required BuildContext context,
    required VoidCallback onAuthenticated,
    VoidCallback? onNotAuthenticated,
  }) async {
    var isLoggedInData = await SessionManager.getSession();
    bool isUserLoggedIn = isLoggedInData!.loginid != null && isLoggedInData.loginid != 0;
    print('debugggggggggggggggggggg ${jsonEncode(isLoggedInData.loginid != null || isLoggedInData.loginid != 0)}');
    if (isUserLoggedIn) {
      // User is logged in, execute the callback
      onAuthenticated();
    } else {
      // User is not logged in, navigate to login
      if (onNotAuthenticated != null) {
        onNotAuthenticated();
      } else {
        // Default behavior: Navigate to login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      }
    }
  }

  /// GetX version - Check auth and execute callback
  ///
  /// Usage:
  /// ```dart
  /// onTap: () => AuthHelper.checkAuthAndExecuteGetX(
  ///   onAuthenticated: () {
  ///     Get.to(() => SomeScreen());
  ///   },
  /// ),
  /// ```
  static Future<void> checkAuthAndExecuteGetX({
    required VoidCallback onAuthenticated,
    VoidCallback? onNotAuthenticated,
  }) async {
    bool isLoggedIn = await SessionManager.isLoggedIn();

    if (isLoggedIn) {
      onAuthenticated();
    } else {
      if (onNotAuthenticated != null) {
        onNotAuthenticated();
      } else {
        Get.offAll(() => LoginView());
      }
    }
  }

  /// Simple boolean check - returns true if logged in
  ///
  /// Usage:
  /// ```dart
  /// if (await AuthHelper.isLoggedIn()) {
  ///   // Do something
  /// }
  /// ```
  static Future<bool> isLoggedIn() async {
    return await SessionManager.isLoggedIn();
  }

  /// Show login required dialog and navigate to login on confirmation
  static Future<void> showLoginRequiredDialog({
    required BuildContext context,
    String title = "Login Required",
    String message = "Please login to continue",
  }) async {
    bool isLoggedIn = await SessionManager.isLoggedIn();

    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginView()),
                  );
                },
                child: Text("Login"),
              ),
            ],
          );
        },
      );
    }
  }
}

/// Extension method on Widget to make auth checks even easier
extension AuthWidget on Widget {
  /// Wrap any widget with authentication check
  ///
  /// Usage:
  /// ```dart
  /// InkWell(
  ///   onTap: () {
  ///     // Your code
  ///   },
  ///   child: Text("Click me"),
  /// ).requireAuth(context)
  /// ```
  Widget requireAuth(BuildContext context, {VoidCallback? onNotAuthenticated}) {
    return FutureBuilder<bool>(
      future: SessionManager.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return this;
          } else {
            return GestureDetector(
              onTap: () {
                if (onNotAuthenticated != null) {
                  onNotAuthenticated();
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginView()),
                  );
                }
              },
              child: this,
            );
          }
        }
        return this;
      },
    );
  }
}