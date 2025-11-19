

import 'package:magicmate_user/Api/network/network_api_Service.dart';
import 'package:magicmate_user/screen/utils/Urls.dart';

class AuthRepo {

  final _apiService  = NetWorkApiService();
  Future<dynamic> sendOTP(data) async {
    dynamic response = await _apiService.postApi(data,AppUrls.sendOtp_url);
    print("vdgvgdv" + response.toString());
    return response;
  }
  Future<dynamic> verifyOTP(data) async {
    dynamic response = await _apiService.postApi(data,AppUrls.verifyOtp_url);
    print("vdgvgdv" + response.toString());
    return response;
  }
  Future<dynamic> register(data) async {
    dynamic response = await _apiService.postApi(data,AppUrls.register_url);
    print("vdgvgdv" + response.toString());
    return response;
  }

}