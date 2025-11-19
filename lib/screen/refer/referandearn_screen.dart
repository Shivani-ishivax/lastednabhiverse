
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/controller/profile/ProfileUpdateController.dart';
import 'package:magicmate_user/screen/refer/claim_widget.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';
import 'package:share_plus/share_plus.dart';



class ReferandearnScreen extends StatefulWidget {
  const ReferandearnScreen({super.key});

  @override
  State<ReferandearnScreen> createState() => _ReferandearnScreenState();
}

class _ReferandearnScreenState extends State<ReferandearnScreen> {
  ProfileUPdateController controller =Get.put(ProfileUPdateController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
    backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Stack(
            children: [
              Container(
                  height: screenHeight*0.5,
                  width: screenWidth,
                  child: Image.asset(AppImagesssss.referback_back,fit: BoxFit.fill,)),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(AppImagesssss.backbtn, width: screenWidth*0.054,height: screenHeight*0.054,),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: screenWidth*0.2),
                          child: Text(AppConstants.referearn,
                              textAlign: TextAlign.center,
                              style: TextStyleClass.textcolorstyle(context, screenWidth * 0.056, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
                              )
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Stack(
                        children: [
                          Container(
                            child: SvgPicture.asset(AppImagesssss.refer_s_back),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40,right: 30,top: 16),
                            child: Text("Asking for a friend... Literally.",
                                textAlign: TextAlign.center,
                                style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.04, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.23,FontWeight.w700)),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: screenHeight*0.3,
                  child:Container(
                    height: screenHeight,
                    width: screenWidth,
                    margin: EdgeInsets.only(bottom: screenHeight*0.24,),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: ColorHelperClass.getColorFromHex(ColorResources.primary_color2),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: ColorHelperClass.getColorFromHex(ColorResources.primary_color2),
                          width: 0.5, // left border width
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                          image: AssetImage(AppImagesssss.greyback_back,),
                          fit: BoxFit.cover
                      ),
                    ),
                    child: Container(

                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 200),
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            child: Text(AppConstants.sharecodedata,
                                textAlign: TextAlign.center,
                                style: TextStyleClass.textcolorstyle(context, screenWidth * 0.044, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),)
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: screenHeight*0.054,
                                width: screenWidth*0.6,
                                padding: EdgeInsets.only(right: 10),
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(AppImagesssss.dots_back,),
                                    GestureDetector(
                                      onTap: () async{
                                        await Clipboard.setData(ClipboardData(text: controller.referralCode.value.toString()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Copied to clipboard")),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: screenWidth*0.056),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Obx((){
                                                return Text(controller.referralCode.value.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.034, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.23,FontWeight.w600)
                                                );
                                              }),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () async{
                                                await Clipboard.setData(ClipboardData(text: controller.referralCode.value.toString()));
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text("Copied to clipboard")),
                                                );
                                              },
                                              icon: Icon(Icons.copy,
                                                color: ColorHelperClass.getColorFromHex(ColorResources.primary_color),
                                                size: 18,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    Share.share('Use My Referral code ${controller.referralCode.value.toString()} while trails registration. ');
                                  },
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(AppImagesssss.editext_back,),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: IconButton(
                                                onPressed: () async{
                                                  Share.share('Use My Referral code ${controller.referralCode.value.toString()} while trails registration. ');
                                                }, icon: Icon(Icons.share, color: ColorHelperClass.getColorFromHex(ColorResources.primary_color),size: 20,)),
                                          ),
                                          Text("Share",
                                              textAlign: TextAlign.center,
                                              style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.038, ColorHelperClass.getColorFromHex(ColorResources.whitecolor),0.23,FontWeight.w600)
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          ClaimWidget(screenHeight: screenHeight,screenWidth: screenWidth,),
                          SizedBox(height: screenHeight * 0.02),
                          // Container(
                          //   width: screenWidth,
                          //   padding: EdgeInsets.only(left: screenWidth*0.05),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         width: 5,
                          //         height: 5,
                          //         margin: EdgeInsets.only(right: 5),
                          //         decoration: BoxDecoration(
                          //           color: ColorHelperClass.getColorFromHex(ColorResources.text3color), // Background color
                          //           shape: BoxShape.circle,
                          //         ),
                          //
                          //       ),
                          //       Text(AppConstants.cashdirectback,
                          //         style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.034, ColorHelperClass.getColorFromHex(ColorResources.text3color),0.23,FontWeight.w500),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: screenHeight * 0.03),
                         // CommonWidget(height: screenHeight,screenWidth: screenWidth,mtext: AppConstants.dashboard,),
                          SizedBox(height: screenHeight * 0.03),
                       //   RefercodeDashboardlistWidget(height: screenHeight * 0.2,screenWidth: screenWidth,),
                          SizedBox(height: screenHeight * 0.03),

                          // GestureDetector(
                          //   onTap: (){
                          //     controller.openWhatsAppApp();
                          //   },
                          //   child: Stack(
                          //     children: [
                          //       Container(
                          //         height: screenHeight*0.058,
                          //         width: screenWidth,
                          //
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(30),
                          //           gradient: LinearGradient(
                          //             begin: Alignment.centerLeft,
                          //             end: Alignment.centerRight,
                          //             colors: [
                          //               Color(0xFFFFF56A),
                          //               Color(0xFFEBBD48),
                          //               Color(0xFFFFFF74),
                          //               Color(0xFFC89A2C),
                          //             ],
                          //             stops: [0.0, 0.2944, 0.5896, 1.0],
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         height: screenHeight*0.058,
                          //         width: screenWidth,
                          //
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             begin: Alignment.topCenter,
                          //             end: Alignment.bottomCenter,
                          //             colors: [
                          //               Color.fromRGBO(47, 47, 47, 0.2),
                          //               Color.fromRGBO(47, 47, 47, 0.2),
                          //             ],
                          //           ),
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(ImageUrls.whatsapp_back,),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(AppConstants.invitewhatsapp,
                          //                 style:  TextStyleClass.textcolorstyle2(context, screenWidth * 0.05, ColorHelperClass.getColorFromHex(ColorResources.text6color),0.45,FontWeight.w500),
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: screenHeight * 0.04),
                          //InviteFriendsWidget(height: screenHeight,screenWidth: screenWidth,)

                        ],
                      ),
                    ),
                  )
              )

            ],
          )

        ],
      ),
    );
  }



}
