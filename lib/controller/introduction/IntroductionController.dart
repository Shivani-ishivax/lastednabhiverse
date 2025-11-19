import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/screen/auth_screen/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroductionController extends GetxController{
  final pageController = PageController();
  var currentPage = 0.obs;
  BuildContext? context=Get.context;
  void onPageChanged(int index) {
    currentPage.value = index;
  }
  void skipToLast() {
    pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  void nextPage() async {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenIntro', true);

      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (_) => LoginView()),
      );
    }
  }
}