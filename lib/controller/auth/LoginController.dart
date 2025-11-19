import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/controller/auth/NetworkController.dart';
import 'package:magicmate_user/repository/auth_repo.dart';

import 'package:magicmate_user/screen/auth_screen/otp_screen.dart';
import 'package:permission_handler/permission_handler.dart';


class LoginController extends GetxController{
  final api = AuthRepo();
  FocusNode focusNode = FocusNode();
  RxBool isTerms = true.obs;
  RxBool isTerms2 = true.obs;

  RxBool loading=false.obs;
  var isButtonLoginEnabled = false.obs;
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPhoneValid = false.obs;

  void _validatePhone() {
    final phone = phoneController.text;
    isPhoneValid.value = phone.length == 10 && RegExp(r'^\d{10}$').hasMatch(phone);


    isButtonLoginEnabled.value = isPhoneValid.value && isTerms.value;

    if (isPhoneValid.value) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(_validatePhone);
    ever(isTerms, (_) => _validatePhone());
  }
  Future<void> requestCameraAndMediaPermissions() async {
    // Request camera permission
    var cameraStatus = await Permission.camera.request();

    // Request media permissions depending on what you need
    var imageStatus = await Permission.photos.request();



    if (cameraStatus.isGranted && (imageStatus.isGranted)) {
      print("Permissions granted");
    } else {
      print("Permissions denied");
      if (cameraStatus.isPermanentlyDenied ||
          imageStatus.isPermanentlyDenied) {
        await openAppSettings(); // Guide user to settings
      }
    }
  }
  void goToOtpScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      var mobile =phoneController.text;
      final networkController = Get.put(NetworkController());

      if (!networkController.isConnected.value) {
        Get.snackbar(
          "No Internet",
          "Please check your connection.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return; // Skip API call if not connected
      }
      loading.value=true;
      Map datas = {
        "mobile":mobile
      };
      api.sendOTP(datas).then((_value) async{
        loading.value=false;
        print("user" + _value.toString());
        if(_value['status']==true)
        {
          phoneController.text="";
          Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => OtpScreenview(),
              settings: RouteSettings(
                arguments: {
                  "mobile": mobile
                },
              ),
            ),
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
    }
  }


  @override
  void onClose() {
    phoneController.text="";
    phoneController.dispose();

    super.onClose();
  }
  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}