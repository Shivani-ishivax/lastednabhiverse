import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Api/config.dart';
import '../model/msg_otp_model.dart';

class MsgOtpController extends GetxController implements GetxService {

  SmsTypeModel? smsTypeModel;

  Future msgOtpApi({required String mobile}) async{
    Map body = {
      "mobile": mobile
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',

    };
    var response = await http.post(Uri.parse(Config.baseurl + Config.msgOtp),body: jsonEncode(body),headers: headers);

    print("+++++++ ${response.body}");
    print("----- ${body}");

    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      if(data["Result"] == "true"){
        smsTypeModel = smsTypeModelFromJson(response.body);
        if(smsTypeModel!.result == "true"){
          update();
          print("///////////////// ${data}");
          return data;
        }
        else{
          Fluttertoast.showToast(msg: smsTypeModel!.result.toString());
        }
      }
      else{
        Fluttertoast.showToast(msg: "${data["ResponseMsg"]}",);
      }
    }else{
      Fluttertoast.showToast(msg: "Please update the content from the backend panel. It appears that the correct data was not uploaded, or there may be issues with the data that was added.",);
    }
  }
}