// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/notification_info.dart';

class NotificationController extends GetxController implements GetxService {
  NotificationInfo? notificationInfo;
  bool isLoading = false;
  NotificationController() {
    getNotificationData();
  }
  getNotificationData() async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Uri uri = Uri.parse(Config.baseurl + Config.notificationApi);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        notificationInfo = NotificationInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
