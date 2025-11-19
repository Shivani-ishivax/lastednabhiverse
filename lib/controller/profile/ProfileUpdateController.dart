import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:magicmate_user/model/login/LoginUser.dart';
import 'package:magicmate_user/model/profile/ProfileUpdateModel.dart';
import 'package:magicmate_user/model/userprofile/UserProfileModel.dart';
import 'package:magicmate_user/repository/profile_repo.dart';
import 'package:magicmate_user/screen/auth_screen/login_view.dart';
import 'package:magicmate_user/screen/bottombar_screen.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';
import 'package:magicmate_user/screen/utils/Urls.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
class ProfileUPdateController extends GetxController{
  RxBool light = true.obs;
  var dobselectedDate = ''.obs;
  var selectedGender = ''.obs;
  var userName= ''.obs;
  var email=''.obs;
  var profileType="".obs;
  RxBool loading=false.obs;
  final ImagePicker _picker = ImagePicker();
  BuildContext? context=Get.context;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  double amount = 0;
  RxList<Map<String, String>> referList = [
    {"title": "Refer 1 friend \n and earn ", "image": AppImagesssss.shareamount_back,"amount":"₹200 "},
    {"title": "Refer 2 friend\n and earn ", "image": AppImagesssss.shareamount_back,"amount":"₹400 "},
    {"title": "Refer 3 friend \n and earn", "image": AppImagesssss.shareamount_back,"amount":"₹600 "},

  ].obs;
  RxString referralCode = "".obs;
  RxString referralCount = "".obs;
  RxString referContent ="".obs;

  Future<void> openWhatsAppApp() async {
    final uri = Uri.parse("https://api.whatsapp.com/send?text=Hello there!");
    if(await canLaunchUrl(uri))
    {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    else {
      throw "WhatsApp is not installed or can't be launched.";
    }
  }



  final api = ProfileRepository();
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  var imagePath="".obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  Future<void> pickDate() async {
    DateTime today = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(today.year - 18, today.month, today.day);

    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1800),
      lastDate: eighteenYearsAgo,
      initialEntryMode: DatePickerEntryMode.calendar,

      // Apply Theme Customization
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:   ColorHelperClass.getColorFromHex(ColorResources.primary_color),
            hintColor:  ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
            colorScheme: ColorScheme.light(
              primary:  ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      dobselectedDate.value = "${date.day}/${date.month}/${date.year}";

    }
  }
  void getStorevalue() async{
    LoginUser? userData = await SessionManager.getSession();
    print('User ID: ${userData?.loginid.toString()}');
    print('User email: ${userData?.email.toString()}');
    if(userData?.profileType.toString()!=null)
    {
      profileType.value = userData?.profileType??"";
    }


    if (userData?.imagePath.toString() != null) {
      fetchImageFromServer(userData!.imagePath.toString());
    }

  }
  Future<void> fetchImageFromServer(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));

      print("Status Code: ${response.statusCode}");
      print("Content-Type: ${response.headers['content-type']}");
      print("Image URL: $imageUrl");

      if (response.statusCode == 200 &&
          response.headers['content-type']?.startsWith('image/') == true) {

        final Directory tempDir = Directory.systemTemp;
        final String filePath = '${tempDir.path}/downloaded_image.jpg';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        selectedImage.value = file;
      } else {
        print("Not a valid image or status != 200");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
  Future<void> clearAll(BuildContext context) async {
   selectedImage.value=null;
   selectedGender.value="";
   dobselectedDate.value="";
   email.value="";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
   Get.offAll(LoginView());
   // Navigator.pushNamedAndRemoveUntil(context, RouteNames.login_screen, (Route<dynamic> route) => false,);
  }

  Future<void> updateProfile(String username, String gender, String dob, String mobileNo, String imagepath) async {
    loading.value = true;
    LoginUser? userData = await SessionManager.getSession();
    print('User ID: ${userData?.loginid.toString()}');

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var request = http.MultipartRequest('POST', Uri.parse(AppUrls.updateProfile_url));
        var data = {
          'name': username,
          'emailId': emailController.text,
          'gender': gender,
          'loginId': userData!.loginid.toString(),
          'dob': dob
        };
        print("ffshddaaaaaaaaaaaaaag"+data.toString());
        print("imageurl:::::"+imagepath.toString());
        request.fields.addAll(data);

        // Check if the image exists at the given path
        var imageFile = File(imagepath);
        // if (imageFile.existsSync()) {
        //   request.files.add(await http.MultipartFile.fromPath('file', imagepath));
        // } else {
        //   print('Image file not found: $imagepath');
        //   Fluttertoast.showToast(
        //     msg: "Image file not found. Please select a valid file.",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );
        //   loading.value = false;
        //   return;
        // }
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          loading.value = false;
          Fluttertoast.showToast(
            msg: "Profile updated successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          String responseBody = await response.stream.bytesToString();
          Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
          print("Error: $jsonResponse");
            getUserProfileData();
          Get.offAll(BottomBarScreen());


        } else {
          print("Error: ${response.statusCode} - ${response.reasonPhrase}");
          Fluttertoast.showToast(
            msg: "Failed to update profile. Please try again."+await response.stream.bytesToString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          loading.value = false;
        }
      } else {
        print('No internet connection');
        loading.value = false;
      }
    } on SocketException catch (_) {
      print('No internet connection');
      loading.value = false;
      Fluttertoast.showToast(
        msg: "No internet connection. Please check your network.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error: ${e.toString()}');
      loading.value = false;
      Fluttertoast.showToast(
        msg: "An unexpected error occurred. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void deleteUserAccount() async{

    LoginUser? userData = await SessionManager.getSession();
    print('User ID: ${userData?.loginid.toString()}');
    Map<String,dynamic> datas={
      "loginId":userData?.loginid.toString(),
    };
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        api.userDeleteProfile(datas).then((ProfileUpdateModel _value) async{

          selectedImage.value=null;
          selectedGender.value="";
          dobselectedDate.value="";
          email.value="";
          print("user"+_value.toString());
          Fluttertoast.showToast(
              msg: "Delete Account Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );

          SessionManager.clearSession();
          Navigator.pushReplacement(
            context!,
            MaterialPageRoute(builder: (_) => LoginView()),
          );

        }).onError((error,strack) {
          loading.value=false;
          print("error"+error.toString());
          if(error.toString().contains("No Internet Connection"))
          {
            Fluttertoast.showToast(
              msg: "No Internet Connect...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          else
          {
            Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }

        });
      }
    } on SocketException catch (_) {
      print('not connected');

      Fluttertoast.showToast(
        msg: "No Internet Connect...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value=pickedFile.path;
      selectedImage.value = File(pickedFile.path);
    }
  }
  Future<void> takePhotoWithCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50,);
    if (pickedFile != null) {
      imagePath.value=pickedFile.path;
      selectedImage.value = File(pickedFile.path);


    }

  }
  Future<void> getUserProfileData() async {
    loading.value=true;
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        LoginUser? userData = await SessionManager.getSession();
        print('User ID: ${userData?.loginid.toString()}');

        api.userProfile(userData?.loginid.toString()).then((UserProfileModel response) async{
          loading.value=false;
          if(response.isSuccess==true) {

            var datata = response.data;
           userName.value = datata?.name.toString()??"";
           firstnameController.text= datata?.name.toString()??"";
           email.value = datata?.email.toString()??"";
           print("fgdghfEmail${ datata?.email.toString()}");
            emailController.text = datata?.email.toString()??"";
           if(datata?.dOB.toString()!=null && datata?.dOB.toString()!="")
            {
              DateTime dateTime = DateTime.parse(datata!.dOB.toString());
              String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
              dobselectedDate.value = formattedDate;
            }
            else
            {
              dobselectedDate.value="";
            }
            if(datata?.gender.toString()!=null)
            {
              selectedGender.value=datata?.gender.toString()??"";
            }
            else
            {
              selectedGender.value="";
            }
            print("datessssssss"+datata!.referralCode.toString());
            referralCode.value = datata!.referralCode.toString();
            referralCount.value = datata!.referralCount.toString();
            referContent.value = datata!.reward.toString();

          }



        }).onError((error,strack) {
          loading.value=false;
          print("error"+error.toString());
        });
      }
    } on SocketException catch (_) {

      loading.value=false;
    }
  }

}
