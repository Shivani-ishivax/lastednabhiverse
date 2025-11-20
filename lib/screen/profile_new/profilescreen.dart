import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';


import 'package:http/http.dart' as http;

import 'package:magicmate_user/controller/profile/ProfileUpdateController.dart';
import 'package:magicmate_user/screen/logout/custom_dialog.dart';
import 'package:magicmate_user/screen/logout/logout_widget.dart';
import 'package:magicmate_user/screen/profile_new/editprofile_screen.dart';
import 'package:magicmate_user/screen/refer/referandearn_screen.dart';
import 'package:magicmate_user/screen/utils/SessionData.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';
class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  ProfileUPdateController controller =Get.put(ProfileUPdateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getStorevalue();
    controller.getUserProfileData();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,

      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
                width: screenWidth,
                height: screenHeight,
                child: ListView(
              shrinkWrap: true,

              children: [
                SizedBox(height: screenHeight * 0.02),
                // Container(
                //   alignment: Alignment.center,
                //   margin: EdgeInsets.only(top: 10,),
                //   child: Text(AppConstants.profile,
                //       textAlign: TextAlign.center,
                //       style: TextStyleClass.textcolorstyle(context, screenWidth * 0.055, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
                //       )
                //   ),
                // ),

                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //
                      //   child: SvgPicture.asset(AppImagesssss.backbtn, width: screenWidth*0.054,height: screenHeight*0.054,),
                      //   onTap: (){
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      Container(

                        margin: EdgeInsets.only(top: 10, ),
                        child:  Text(AppConstants.profile,
                            textAlign: TextAlign.center,
                            style: TextStyleClass.textcolorstyle(context, screenWidth * 0.055, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
                            )
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: screenHeight*0.068,left: 5,),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImagesssss.background_pro,),
                        fit: BoxFit.fill
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*.15,
                          child: Divider(
                            height: screenHeight * 0.017,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Stack(
                        children: [

                          Container(
                            height: screenHeight*0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFFFF56A),
                                  Color(0xFFEBBD48),
                                  Color(0xFFFFFF74),
                                  Color(0xFFC89A2C),
                                ],
                                stops: [0.0, 0.1944, 0.3896, 0.899],
                              ),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(top: 20,left: 20,right: 20),
                              child: Obx((){
                                return Center(
                                  child: ClipOval(child: controller.selectedImage.value == null?Image.asset( AppImagesssss.profileimg, width: 120,
                                    height: 120,): Image.file(controller.selectedImage.value!,fit: BoxFit.cover, width: 120,
                                    height: 120,)),
                                );
                              }),
                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Obx((){
                        return Text(controller.userName.value.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyleClass.textcolorstyle(context, screenWidth * 0.067, ColorHelperClass.getColorFromHex(ColorResources.primary_color),
                            )
                        );
                      }),
                      Obx((){
                        return  Text(controller.email.value.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.034, ColorHelperClass.getColorFromHex(ColorResources.text5color),0.0,FontWeight.w400)
                        );
                      }),

                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const EditprofileScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Align(
                              child: Container(
                                child: Image.asset("assets/edittext_back.png",fit: BoxFit.fill,),
                                width: 160,
                                height: 42,

                              ),
                              alignment: Alignment.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: screenWidth * 0.031),
                                  child: Icon(Icons.edit,color: Colors.white,size: 20,),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 5,top: screenWidth * 0.031),
                                  child: Text(AppConstants.editprofile,
                                      textAlign: TextAlign.center,
                                      style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.038, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.0,FontWeight.w400)
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                      Container(
                        height: screenHeight*0.4,
                        margin: EdgeInsets.only(left: 20, right: 20,top: 50),
                        padding: EdgeInsets.only(top: 20,left: 15,right: 15),
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: ColorHelperClass.getColorFromHex(ColorResources.darkprofile),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              offset: Offset(0, 4.55),
                              blurRadius: 50.03,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Obx((){
                              return controller.profileType.value=="normal"? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) => const ReferandearnScreen(),
                                        ),
                                      );
                                    },
                                    child:  Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, ),
                                          child: SvgPicture.asset(AppImagesssss.drawel_refund,width: 35,height: 35,),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 25, ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(AppConstants.referearn,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.045, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.0,FontWeight.w500)
                                              ),
                                              SizedBox(height: screenHeight * 0.007),
                                              Text(AppConstants.refercode_content,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.029, ColorHelperClass.getColorFromHex(ColorResources.text5color),0.0,FontWeight.w400)
                                              ),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (context) => const ReferandearnScreen(),
                                      ),
                                    );
                                  }, icon: Icon(Icons.keyboard_arrow_right_rounded,size: 35,color: ColorHelperClass.getColorFromHex(ColorResources.text5color),))
                                ],
                              ):Row();
                            }),
                            SizedBox(height: screenHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               GestureDetector(
                                 onTap: (){
                                   showAnimatedDialog(context,LogoutWidget(title: "Logout", desc: AppConstants.logcode, type: '1',),isFlip: false, dismissible: false);
                                 },
                                 child:  Row(
                                   children: [
                                     SvgPicture.asset(AppImagesssss.pr4,width: 60,height: 60,),
                                     Container(
                                       margin: EdgeInsets.only(left: 8, ),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(AppConstants.logout,
                                               textAlign: TextAlign.center,
                                               style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.045, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.0,FontWeight.w500)
                                           ),
                                           SizedBox(height: screenHeight * 0.007),
                                           Text(AppConstants.logout2,
                                               textAlign: TextAlign.center,
                                               style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.029, ColorHelperClass.getColorFromHex(ColorResources.text5color),0.0,FontWeight.w400)
                                           ),

                                         ],
                                       ),
                                     ),

                                   ],
                                 ),
                               ),
                                IconButton(onPressed: (){
                                 showAnimatedDialog(context,LogoutWidget(title: "Logout", desc: AppConstants.logcode, type: '1',),isFlip: false, dismissible: false);
                                }, icon: Icon(Icons.keyboard_arrow_right_rounded,size: 35,color: ColorHelperClass.getColorFromHex(ColorResources.text5color),))
                              ],
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               GestureDetector(
                                 onTap: () async{
                                   showAnimatedDialog(context,LogoutWidget(title: 'Delete', desc: 'Are you sure you want to delete account', type: '2',),isFlip: false, dismissible: false);
                                 },
                                 child:  Row(
                                   children: [
                                     SvgPicture.asset(AppImagesssss.pr1,width: 60,height: 60,),
                                     Container(
                                       margin: EdgeInsets.only(left: 8, ),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text("Delete",
                                               textAlign: TextAlign.center,
                                               style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.045, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.0,FontWeight.w500)
                                           ),
                                           SizedBox(height: screenHeight * 0.007),
                                           Text("Delete my account",
                                               textAlign: TextAlign.center,
                                               style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.029, ColorHelperClass.getColorFromHex(ColorResources.text5color),0.0,FontWeight.w400)
                                           ),

                                         ],
                                       ),
                                     ),

                                   ],
                                 ),
                               ),
                                IconButton(onPressed: (){
                                  //showAnimatedDialog(context,LogoutWidget(title: 'Delete', desc: 'Are you sure you want to delete account', type: '2',),isFlip: false, dismissible: false);
                                }, icon: Icon(Icons.keyboard_arrow_right_rounded,size: 35,color: ColorHelperClass.getColorFromHex(ColorResources.text5color),))
                              ],
                            ),



                          ],
                        ),
                      ),
                      //SizedBox(height: screenHeight * 0.03),


                    ],
                  ),
                )

              ],
            ),

              ),
        ],
      ),
    );
  }


  void LogoutDialog(BuildContext context, String title, String msg,String flag) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [

              SizedBox(width: 10),
              Text(title)
            ],
          ),
          content: Text(msg, style: TextStyle(
              color: Colors.black,
              fontSize: 16
          ),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
               if(flag=="1")
                 {
                   SessionManager.clearSession();
                   controller.selectedImage.value=null;
                   controller.selectedGender.value="";
                   controller.dobselectedDate.value="";
                   controller.email.value="";
                   //Navigator.pushNamedAndRemoveUntil(context!, RouteNames.login_screen, (Route<dynamic> route) => false,);
                 }
               else if(flag=="2")
                 {
                   controller.selectedImage.value=null;
                   controller.selectedGender.value="";
                   controller.dobselectedDate.value="";
                   controller.email.value="";
                  controller.deleteUserAccount();
                 }


              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );



  }


}
