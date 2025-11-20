// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/fav_info.dart';

class FavoriteController extends GetxController implements GetxService {
  List<FevInfo> favList = [];
  bool isLoading = false;
  getFavoriteListApi() async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');
      Map map = {
        "uid": userData?.loginid.toString(),
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Uri uri = Uri.parse(Config.baseurl + Config.favoriteList);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        favList = [];
        for (var element in result["FavEventData"]) {
          favList.add(FevInfo.fromJson(element));
        }
      }
      isLoading = true;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print(e.toString());
    }
  }
}
