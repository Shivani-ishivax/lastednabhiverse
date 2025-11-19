import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:magicmate_user/Api/appexpection/AppExpection.dart';
import 'package:magicmate_user/Api/network/base_api_service.dart';


class NetWorkApiService extends BaseApiService{
  @override
  Future getApi(String url) async {
    dynamic resonseJson;
    try{
      final response = await http.get(Uri.parse(url),
        headers: {
        'Content-Type': 'application/json',
          "Accept": 'application/json',

        },);
      resonseJson= returnResponse(response);
      print("gfgfg"+resonseJson.toString());
    } on SocketException {
      throw InternetExpection("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeOutExpection("Request Timed Out");
    } catch (e) {
      throw FetchDataExpection("Unexpected error: $e");
    }
    return resonseJson;
  }
  dynamic returnResponse(http.Response response)
  {
    switch (response.statusCode){
      case 200:
        dynamic responseJson =json.decode(response.body);
        return responseJson;
      case 400:
        throw ServerExpection("Bad Request: ${response.body}");
        case 401:
          throw ServerExpection("Unauthorized: ${response.body}");
        case 500:
          throw ServerExpection("Internal Server Error: ${response.body}");
          case 409:
          throw ServerExpection("Internal Server Error: ${response.body}");
          case 404:
        throw InvalidExpection("Invalid Url Or Data :${response.body}");
        default: FetchDataExpection("Error communication Ouur: ${response.body}");
    }

  }

  @override
  Future postApi(data, String url) async {
    dynamic resonseJson;
    var header;
    var body;

        header=<String,String> {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip',
          'Accept': 'application/json',
          "User-Agent": "Mozilla/5.0 (Linux; Android 10) Mobile Safari/537.36",
          'Connection': 'keep-alive'
        };
        body=jsonEncode(data);


    try{
      final response = await http.post(Uri.parse(url),
        headers: header,
        body: body
      );
      resonseJson= returnResponse(response);
      print("gfgfg"+resonseJson.toString());
    }  on SocketException {
      throw InternetExpection("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeOutExpection("Request Timed Out");
    } catch (e) {
      throw FetchDataExpection("Unexpected error: $e");
    }
    return resonseJson;
  }


}
