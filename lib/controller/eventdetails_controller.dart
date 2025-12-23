// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../helpar/routes_helpar.dart';
import '../model/catwise_event.dart';
import '../model/event_info.dart';
import '../model/ticket_info.dart';
import 'favorites_controller.dart';

class EventDetailsController extends GetxController implements GetxService {
  FavoriteController favoriteController = Get.find();
  EventInfo? eventInfo;
  TicketInfo? ticketInfo;
  List<CatWiseInfo> catWiseInfo = [];
  bool isLoading = false;

  List<String> menberList = [];

  String ticketID = "";
  String ticketType = "";
  String ticketPrice = "";
  String totalTicke = "";

  var mTotal = 0.0;
  int totalTicket = 0;
  Map<int, int> ticketCount = {};
  getTotal({double? total}) {
    mTotal = total ?? 0.0;
    update();
  }
  void increaseTicket(int index, double price) {
    ticketCount[index] = (ticketCount[index] ?? 0) + 1;

    totalTicket++;
    mTotal += price;

    update();
  }

  void decreaseTicket(int index, double price) {
    if ((ticketCount[index] ?? 0) > 0) {
      ticketCount[index] = ticketCount[index]! - 1;

      totalTicket--;
      mTotal -= price;

      update();
    }
  }
  getEventData({String? eventId}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');
      Map map = {
        "uid": userData?.loginid.toString(),
        "event_id": eventId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.eventDetails);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print("+++++++map+++++++ $map");
      log("++++response+++++ ${response.body}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        menberList = [];
        for (var element in result["EventData"]["member_list"]) {
          menberList.add("${Config.imageUrl}" + element);
        }
        eventInfo = EventInfo.fromJson(result);
        print("fhgfgfghh${eventInfo?.eventData.toString()}");
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getEventTicket({String? eventId}) async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      isLoading = false;
      Map map = {
        "uid": userData?.loginid.toString(),
        "event_id": eventId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.ticketApi);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print("gdfydgf${response.body}");
      if (response.statusCode == 200) {
        print("sucess");
        var result = jsonDecode(response.body);
        ticketInfo = TicketInfo.fromJson(result);
        // mTotal = double.parse((ticketInfo?.eventTypePrice.first.ticketPrice).toString());
        // totalTicket = 1;
        // ticketCount[0] = 1;

        update();
        print("sucess${ticketInfo?.eventTypePrice.first.ticketPrice.toString()}");
      }
      else
        {
          print("error");
        }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getCatWiseEvent({String? catId, title, img}) async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');
      isLoading = false;
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Map map = {
        "uid": userData?.loginid.toString(),
        "cat_id": catId,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.catWiseEvent);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        catWiseInfo = [];
        for (var element in result["CatEventData"]) {
          catWiseInfo.add(
            CatWiseInfo.fromJson(element),
          );
        }
        Get.toNamed(Routes.catWiseEventScreen, arguments: {
          "title": title,
          "catImag": img,
        });
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getFavAndUnFav({String? eventID}) async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');
      Map map = {
        "uid":userData?.loginid.toString(),
        "eid": eventID,
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      Uri uri = Uri.parse(Config.baseurl + Config.favORUnFav);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print("--------------- ${map}");
      print("+++++++++++++ ${response.body}");
      if (response.statusCode == 200) {
        getEventData(eventId: eventID);
        favoriteController.getFavoriteListApi();
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  clearEventTicketData() {
    ticketID = "";
    ticketType = "";
    ticketPrice = "";
    totalTicke = "";
    update();
  }

  getEventTicketData(String ticketId1, ticketType1, ticketPrice1, totalTicket1) {
    ticketID = ticketId1 ?? "";
    ticketType = ticketType1 ?? "";
    ticketPrice = ticketPrice1 ?? "";
    totalTicke = totalTicket1 ?? "";
    update();
  }
}
