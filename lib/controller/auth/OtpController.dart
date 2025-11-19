import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/repository/auth_repo.dart';
import 'package:magicmate_user/screen/auth_screen/register_view.dart';
import 'package:magicmate_user/screen/bottombar_screen.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otpcontroller extends GetxController {
  final api = AuthRepo();
  final List<TextEditingController> otpcontrollers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpfocusNodes = List.generate(6, (_) => FocusNode());
  final RxInt focusedIndex = (-1).obs;
  var lastFocusedIndex = (-1).obs;
  RxBool isTerms = true.obs;
  RxBool isTerms2 = true.obs;
  RxInt remainingSeconds = 60.obs;
  RxBool isTimerRunning = true.obs;
  Timer? _timer;
  var mobile=''.obs;
  final formKey = GlobalKey<FormState>();
  RxBool loading=false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
    for (int i = 0; i < otpfocusNodes.length; i++) {
      otpfocusNodes[i].addListener(() {
        otpfocusNodes[i].addListener(() {
          if (otpfocusNodes[i].hasFocus) {
            lastFocusedIndex.value = i;
            focusedIndex.value = i;
          }
        });
      });
    }
  }

  void startTimer() {
    remainingSeconds.value = 60;
    isTimerRunning.value = true;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        isTimerRunning.value = false;
        _timer?.cancel();
      }
    });
    }

  void resendOtp() {
    Map datas = {
      "mobile":mobile.value
    };
    api.sendOTP(datas).then((_value) async{
      loading.value=false;
      print("user" + _value.toString());
      if(_value['status']==true)
      {
        Fluttertoast.showToast(
          msg: "Otp Send successfully...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }


    }).onError((error, strack) {
      loading.value=false;
      print("error" + error.toString());
      if (error.toString().contains("No Internet Connection")) {
        Fluttertoast.showToast(
          msg: "No Internet Connect...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else
      {
        Fluttertoast.showToast(
          msg: "Something went wrong...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

    });

    print("OTP resent!");
    startTimer();
  }
  String get otp => otpcontrollers.map((c) => c.text).join();



  void clearAllOTP() {
    for (var controller in otpcontrollers) {
      controller.clear();
    }
    if (lastFocusedIndex.value != -1) {
      FocusScope.of(Get.context!).requestFocus(otpfocusNodes[lastFocusedIndex.value]);
    }
  }

  void onChangedOTP(String value, int index) {
    if (value.length == 1 && index < 5) {
      otpfocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      otpfocusNodes[index - 1].requestFocus();
    }
    if (otpcontrollers.every((controller) => controller.text.isNotEmpty)) {
      FocusScope.of(Get.context!).unfocus();
    }
  }

  void goToProfileScreen(BuildContext context) {
    final enteredOtp = otp;


      if (enteredOtp.length==6) {
        verifyOtp(otp, context);
      } else {
        Get.snackbar("Error", "Please Enter 6 digit  OTP",backgroundColor: Colors.red[400], colorText: Colors.white,);
        //clearAllOTP();
      }
  }


  @override
  void onClose() {
    for (final controller in otpcontrollers) {
      controller.clear();
    }
    for (var c in otpcontrollers) {
      c.dispose();
    }
    for (var f in otpfocusNodes) {
      f.dispose();
    }
    super.onClose();
  }

   void verifyOtp(String otp, BuildContext context) async {
    Map datas = {
       "mobile":mobile.value,
       "otp": otp
     };
    loading.value=true;
     print("data.."+datas.toString());
     api.verifyOTP(datas).then((_value) async {
       loading.value=false;
       print("user" + _value.toString());
       if(_value['userExist']==true)
       {

         LoginUser user = LoginUser.fromJson(_value['user']);
         print("User Name: ${user.name}");
         print("Login ID: ${user.loginid}");
         await SessionManager.saveSessionUserData(user);
         SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setBool('seenIntro', true);
         Get.snackbar("Success", _value['message'],
           backgroundColor: Colors.green,
           colorText: Colors.white,
         );
         clearAllOTP();
         Get.offAll(BottomBarScreen());
       }
       else
       {
         Get.offAll(RegisterView(),arguments: {
           "mobile":mobile
         });

       }


     }).onError((error, strack) {
       loading.value=false;
       print("error" + error.toString());
       if (error.toString().contains("No Internet Connection")) {
         Fluttertoast.showToast(
           msg: "No Internet Connect...",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0,
         );
       }
       else if(error.toString().contains("OTP Expired, Please Resend OTP"))
         {
           Fluttertoast.showToast(
             msg: "OTP Expired, Please Resend OTP",
             gravity: ToastGravity.CENTER,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0,
           );
         }
       else if(error.toString().contains("Invalid OTP."))
         {
           Fluttertoast.showToast(
             msg: "Invalid OTP.",
             gravity: ToastGravity.CENTER,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0,
           );
         }
       else
         {
           Fluttertoast.showToast(
             msg: "Something went wrong...",
             gravity: ToastGravity.CENTER,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0,
           );
         }
     });
   }
}