// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/payment_info.dart';
import '../model/wallet_info.dart';
import '../utils/Custom_widget.dart';
import 'home_controller.dart';

class WalletController extends GetxController implements GetxService {
  TextEditingController amount = TextEditingController();
  HomePageController homePageController = Get.find();

  PaymentInfo? paymentInfo;

  bool isLoading = false;
  WalletInfo? walletInfo;

  String results = "";
  String walletMsg = "";

  String rCode = "";
  String signupcredit = "";
  String refercredit = "";

  getWalletReportData() async {
    try {
      isLoading = false;
      update();
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

      Uri uri = Uri.parse(Config.baseurl + Config.walletReportApi);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        walletInfo = WalletInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  addAmount({String? price}) {
    amount.text = price ?? "";
    update();
  }

  getWalletUpdateData() async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "wallet": amount.text,
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Uri uri = Uri.parse(Config.baseurl + Config.walletUpdateApi);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        results = result["Result"];
        walletMsg = result["ResponseMsg"];
        if (results == "true") {
          getWalletReportData();
          homePageController.getHomeDataApi();
          Get.back();
          amount.text = "";
          showToastMessage(walletMsg);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getReferData() async {
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
      Uri uri = Uri.parse(Config.baseurl + Config.referAndEarn);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        rCode = result["code"];
        signupcredit = result["signupcredit"];
        refercredit = result["refercredit"];
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getpaymentgatewayList() async {
    try {
      isLoading = false;
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Uri uri = Uri.parse(Config.baseurl + Config.paymentgatewayApi);
      var response = await http.post(uri, headers: headers );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        paymentInfo = PaymentInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
