import 'dart:async';
import 'dart:convert';

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/auth_screen/login_view.dart';
import 'package:magicmate_user/screen/bottombar_screen.dart';
import 'package:magicmate_user/screen/intro/introduction_screen.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
            child: Center(
              child: Image.asset(AppImagesssss.logoImage, width: size.width),
            ),
          ),
        ],
      ),
    );
  }

  void checkUser() async {
    var userId = 0;
    LoginUser? userData = await SessionManager.getSession();
    print('User ID: ${userData?.loginid.toString()}');
    print('User Name: ${userData?.email.toString()}');
    // await Future.delayed(const Duration(milliseconds: 500), () async {
    //   final token = await FirebaseMessaging.instance.getToken();
    //   //await PushNotificationService().initialise();
    //   if (token != null) {
    //
    //
    //   }
    //   await Permission.notification.isDenied.then((value) {
    //     if (value) {
    //       Permission.notification.request();
    //     }
    //   });
    // });
    Timer(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final seenIntro = prefs.getBool('seenIntro') ?? false;
      // print(
      //   'login debuggggggggggggggggg ${jsonEncode(userData)} ${userData?.loginid.toString()} ${jsonEncode(seenIntro)}',
      // );
      if (!seenIntro) {
        // Show intro screen once

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => IntroductionScreen()),
        );
      } else if (userData?.loginid == null || userData?.loginid == 0) {
        // this conditon is redundent remove in future by kripal singh
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomBarScreen()),
        );

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => LoginView()),
        // );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomBarScreen()),
        );
      }
    });
    //----old-code---------------this-was-used-before----------------------
    // Timer(Duration(seconds: 3), () async{
    //   final prefs = await SharedPreferences.getInstance();
    //   final seenIntro = prefs.getBool('seenIntro') ?? false;
    //   if (!seenIntro) {
    //     // Show intro screen once
    //
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (_) => IntroductionScreen()),
    //     );
    //   }
    //   else if (userData?.loginid.toString()==null && userId =="") {
    //
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (_) => LoginView()),
    //     );
    //   } else {
    //
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (_) => BottomBarScreen()),
    //     );
    //   }
    //
    // });
  }
}
