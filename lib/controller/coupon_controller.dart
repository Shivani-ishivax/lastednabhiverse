// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/coupon_info.dart';

class CouponController extends GetxController implements GetxService {
  List<CouponInfo> couponList = [];
  bool isLodding = false;

  String copResult = "";
  String couponMsg = "";

  getCouponDataApi({String? sponsoreID}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "sponsore_id": sponsoreID,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponlist);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        couponList = [];
        for (var element in result["couponlist"]) {
          couponList.add(CouponInfo.fromJson(element));
        }
      }
      isLodding = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  checkCouponDataApi({String? cid}) async {
    try {
      isLodding = false;
      update();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "cid": cid,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponCheck);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        copResult = result["Result"];
        couponMsg = result["ResponseMsg"];
      }
      isLodding = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
