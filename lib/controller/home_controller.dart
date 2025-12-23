// ignore_for_file: avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';
import 'package:magicmate_user/screen/utils/Urls.dart';

import '../Api/config.dart';
import '../Api/data_store.dart';
import '../helpar/routes_helpar.dart';
import '../model/home_info.dart';
import '../model/map_info.dart';

import '../screen/home_screen.dart';
import 'eventdetails_controller.dart';

class HomePageController extends GetxController implements GetxService {
  EventDetailsController eventDetailsController = Get.find();
  PageController pageController = PageController();

  List<MapInfo> mapInfo = [];

  bool isLoading = false;
  HomeInfo? homeInfo;

  CameraPosition kGoogle = CameraPosition(
    target: LatLng(21.2381962, 72.8879607),
    zoom: 5,
  );

  List<Marker> markers = <Marker>[];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  HomePageController() {
    getDynamicUrl();

  }
  //event url

  void getDynamicUrl() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

    };
    Uri uri = Uri.parse(AppUrls.eventapp_url);
    var response = await http.get(
      uri,
      headers: headers,

    );
    print(uri);

    print("::::::::::________::::::::::" + response.body.toString());
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(":::RR:::::::________::::::::::" + result.toString());
      Config.imageUrl = result['data']['url'].toString();
      Config.razorpaykey = result['data']['razorpay_key'].toString();
      print("gdfgdgyuyyudf${Config.imageUrl}");
      getHomeDataApi();
    }
  }

  getHomeDataApi() async {
    try {
      LoginUser? userData = await SessionManager.getSession();
      print('User ID: ${userData?.loginid.toString()}');

      Map map = {
        "uid": userData?.loginid.toString(),
        "lats": "26.912434",
        "longs": "75.787270",
      };
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.homeDataApi);
      var response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(map),
      );
      print(uri);

      print("::::::::::________::::::::::" + response.body.toString());
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(":::RR:::::::________::::::::::" + result.toString());
        for (var element in result["HomeData"]["nearby_event"]) {
          mapInfo.add(MapInfo.fromJson(element));
        }
        homeInfo = HomeInfo.fromJson(result);
        update();
        var maplist = mapInfo.reversed.toList();
        print(":::MMM:::::::________::::::::::" + result.toString());
        for (var i = 0; i < maplist.length; i++) {
          final Uint8List markIcon = await getImages("assets/MapPin.png", 100);
          markers.add(
            Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(
                double.parse(mapInfo[i].eventLatitude),
                double.parse(mapInfo[i].eventLongtitude),
              ),
              icon: BitmapDescriptor.fromBytes(markIcon),
              onTap: () {
                pageController.animateToPage(i, duration: Duration(seconds: 1), curve: Curves.decelerate);
                update();
              },
              infoWindow: InfoWindow(
                title: mapInfo[i].eventTitle,
                snippet: mapInfo[i].eventPlaceName,
                onTap: () async {
                  await eventDetailsController.getEventData(
                    eventId: mapInfo[i].eventId,
                  );
                  Get.toNamed(
                    Routes.eventDetailsScreen,
                    arguments: {
                      "eventId": mapInfo[i].eventId,
                      "bookStatus": "1",
                    },
                  );
                },
              ),
            ),
          );
          kGoogle = CameraPosition(
            target: LatLng(
              double.parse(maplist[i].eventLatitude),
              double.parse(maplist[i].eventLongtitude),
            ),
            zoom: 8,
          );
        }
        currency = result["HomeData"]["Main_Data"]["currency"];
        wallet1 = result["HomeData"]["wallet"];
      }
      isLoading = true;
      print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
      update();
    } catch (e) {
      print(e.toString());
    }
  }



}
