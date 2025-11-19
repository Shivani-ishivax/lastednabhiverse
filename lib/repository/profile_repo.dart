
import 'package:magicmate_user/Api/network/network_api_Service.dart';
import 'package:magicmate_user/model/profile/ProfileUpdateModel.dart';
import 'package:magicmate_user/model/userprofile/UserProfileModel.dart';
import 'package:magicmate_user/screen/utils/Urls.dart';


class ProfileRepository{
  final _apiService  = NetWorkApiService();
  Future<ProfileUpdateModel> userDeleteProfile(data) async {
    dynamic response = await _apiService.postApi(data,AppUrls.deleteAccount_url);
    print("vdgvgdv"+response.toString());
    return ProfileUpdateModel.fromJson(response);

  }
  Future<UserProfileModel> userProfile(userid) async {

    dynamic response = await _apiService.getApi(AppUrls.getUserProfile_url+"?loginId=$userid");
    print("vdgvgdv"+response.toString());
    return UserProfileModel.fromJson(response);

  }


}