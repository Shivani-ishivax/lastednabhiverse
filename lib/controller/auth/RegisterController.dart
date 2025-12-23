import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/repository/auth_repo.dart';
import 'package:magicmate_user/screen/bottombar_screen.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

class RegisterController extends GetxController {
  final api = AuthRepo();
  FocusNode focusNode = FocusNode();
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>();
   final nameController = TextEditingController();
  RxString selectedUser = 'normal'.obs;
   final emailCon= TextEditingController();

    var device_token ="".obs;
  var selectedItem = ''.obs;
  RxBool loading=false.obs;
  void selectItem(String value) {
    selectedItem.value = value;
  }
  void userRegister(BuildContext context) async {
    Map datas = {
      "name":nameController.text,
      "password":"1234",
      "mobileNo": phoneController.value.text,
      "devicetoken": device_token.value,
      "emailId": emailCon.text,
      "profileType": selectedUser.value
    };
    loading.value=true;
    print("data.."+datas.toString());
    api.register(datas).then((_value) async {
      loading.value=false;
      print("user" + _value.toString());
      if(_value['success']==true)
      {
        LoginUser user = LoginUser.fromJson(_value['user']);
        print("lllllllllllllllllllllllllll"+jsonEncode(_value));
        print("User Name: ${user.name}");
        print("Login ID: ${user.loginid}");
        await SessionManager.saveSessionUserData(user);

        Get.snackbar("Success", _value['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        nameController.text="";
        emailCon.text="";
        selectedUser.value="";
        phoneController.value.text="";
        Get.offAll(BottomBarScreen());
      }
      else
        {
          Get.snackbar("Status", _value['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
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
      else if(error.toString().contains("MobileNo already register"))
        {
          Fluttertoast.showToast(
            msg: "Mobile number already register ...",
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
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
   });
  }
}