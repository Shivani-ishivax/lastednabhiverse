import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magicmate_user/Api/internet/InternetConnectionService.dart';

class NetworkController extends GetxController {

  final isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    InternetConnectionService().initialize();

    InternetConnectionService().onConnectionChange.listen((status) {
      if (status != isConnected.value) {
        isConnected.value = status;

        // Show snackbar when connection changes
        Get.snackbar(
          status ? "Back Online" : "You're Offline",
          status
              ? "Internet connection restored"
              : "Please check your internet",
          backgroundColor: status ? Colors.green : Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10),
          borderRadius: 8,
        );
      }
    });

    _initConnection();
  }

  Future<void> _initConnection() async {
    bool status = await InternetConnectionService().checkConnection();
    isConnected.value = status;
  }
}