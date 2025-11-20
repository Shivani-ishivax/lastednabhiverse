// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/mtticket_info.dart';
import '../model/order_info.dart';
import '../utils/Custom_widget.dart';

class MyBookingController extends GetxController implements GetxService {
  OrderInfo? orderInfo;
  MyTicketInfo? myTicketInfo;
  bool isLoading = false;

  String status = "";
  TextEditingController ratingText = TextEditingController();

  double tRate = 1.0;

  totalRateUpdate(double rating) {
    tRate = rating;
    update();
  }

  myOrderHistory({String? statusWise}) async {
    try {
      isLoading = false;
      status = statusWise ?? "";
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "status": statusWise,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.myOrderHistory);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderInfo = OrderInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  ticketInformetionApi({String? ticketId}) async {
    try {
      isLoading = false;
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "ticket_id": ticketId,

      };
      Uri uri = Uri.parse(Config.baseurl + Config.ticketInformetion);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print("gdfgdff${response.body}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        myTicketInfo = MyTicketInfo.fromJson(result);
        print("fghdsgfhdsh${response.body}");
      }
      else
        {
          print("fghdsgfhdsh${response.statusCode}");
        }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  cancleOrder({String? orderId1, reason}) async {
    try {
      isLoading = false;
      update();
      LoginUser? userData = await SessionManager.getSession();
      Map map = {
        "uid": userData?.loginid.toString(),
        "ticket_id": orderId1,
        "cancle_comment": reason,
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.ticketCancle);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result["Result"] == "true") {
          myOrderHistory(statusWise: 'Active');
          Get.back();
        }
        showToastMessage(result["ResponseMsg"]);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  orderReviewApi({String? orderID}) async {
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
        "ticket_id": orderID,
        "total_star": tRate.toString(),
        "review_comment": ratingText.text != "" ? ratingText.text : "",
      };

      print("!!!!!!!!!!!!!!!!" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.orderReview);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        tRate = 1.0;
        ratingText.text = "";
        Get.back();
        ticketInformetionApi(ticketId: orderID);
        showToastMessage(result["ResponseMsg"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
