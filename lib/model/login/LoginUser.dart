class LoginUser {
  var loginid;
  String? name;
  String? email;
  var role;
  String? gender;
  String? dob;
  String? imagePath;
  var mobileNo;
  var profileType;
  var referralCode;
  var trialAddress;
  var referralCount;
  var reward;

  LoginUser(
      {this.loginid,
        this.name,
        this.email,
        this.role,
        this.gender,
        this.dob,
        this.imagePath,
        this.mobileNo,
        this.profileType,
        this.referralCode,
        this.trialAddress,
        this.referralCount,
        this.reward

      });

  LoginUser.fromJson(Map<String, dynamic> json) {
    loginid = json['loginid'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    gender = json['gender'];
    dob = json['dob'];
    imagePath = json['imagePath'];
    mobileNo = json['mobileNo'];
    profileType = json['profileType'];
    referralCode =json['referralCode'];
    trialAddress =json['trialAddress'];
    referralCount =json['referralCount'];
    reward =json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginid'] = this.loginid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['imagePath'] = this.imagePath;
    data['mobileNo'] = this.mobileNo;
    data['profileType'] = this.profileType;
     data['referralCode'] = this.referralCode;
     data['trialAddress'] = this.trialAddress;
     data['reward'] = this.reward;

    return data;
  }
}