class UserData {
  int? loginId;


  var mobileNo;
  String? email;
  var profileType;
  String? name;
  var referralCode;
  var referralCount;
  var reward;


  String? imagePath;
  String? gender;
  String? dOB;

  String? deviceToken;

  UserData(
      {this.loginId,

        this.mobileNo,
        this.email,
        this.profileType,
        this.name,
        this.referralCode,
        this.referralCount,
this.reward,
        this.imagePath,
        this.gender,
        this.dOB,

        this.deviceToken});

  UserData.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];

    mobileNo = json['mobileNo'];
    email = json['email'];
    profileType = json['profileType'];
    name = json['name'];
    referralCode = json['referralCode'];
    referralCount = json['referralCount'];
    reward =json['reward'];
    imagePath = json['ImagePath'];
    gender = json['gender'];
    dOB = json['dob'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginId'] = this.loginId;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['profileType'] = this.profileType;
    data['name'] = this.name;
    data['referralCode'] = this.referralCode;
    data['referralCount'] = this.referralCount;
    reward= this.reward;

    data['ImagePath'] = this.imagePath;
    data['gender'] = this.gender;
    data['dob'] = this.dOB;
    data['DeviceToken'] = this.deviceToken;
    return data;
  }
}