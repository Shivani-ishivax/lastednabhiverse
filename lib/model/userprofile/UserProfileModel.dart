

import 'package:magicmate_user/model/userprofile/UserProfileData.dart';

class UserProfileModel {
  bool? isSuccess;
  String? message;
  UserData? data;

  UserProfileModel({this.isSuccess, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
