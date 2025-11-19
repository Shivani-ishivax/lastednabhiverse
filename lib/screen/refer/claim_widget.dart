
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/controller/profile/ProfileUpdateController.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';



class ClaimWidget extends StatelessWidget {
  double screenHeight;
  double screenWidth;
   ClaimWidget({super.key,required this.screenHeight,required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(ProfileUPdateController());
    return   Container(
      width: screenWidth,

      padding: EdgeInsets.only(left: screenWidth*0.05),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImagesssss.backgrounditem,),
            fit: BoxFit.fill
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Text("Referral Count",
            style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.042, ColorHelperClass.getColorFromHex(ColorResources.text3color),0.23,FontWeight.w400),
          ),
          SizedBox(height: screenHeight * 0.007),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Obx((){
               return  Text(
                 "   ${controller.referralCount.value.toString()}",
                 style: TextStyleClass.textcolorstyle2(
                   context,
                   screenWidth * 0.1,
                   ColorHelperClass.getColorFromHex(ColorResources.primary_color),
                   0.23,
                   FontWeight.w700,
                 ),
               );
             }),
              // Opacity(
              //   opacity: controller.amount == 0 ? 0.4 : 1.0,
              //   child: IgnorePointer(
              //     ignoring: controller.amount == 0, // disables clicks when amount is 0
              //     child: GestureDetector(
              //       onTap: () {
              //
              //         print("Claiming amount...");
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: Stack(
              //           children: [
              //             Container(
              //               height: screenHeight * 0.058,
              //               width: screenWidth*0.37,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 gradient: LinearGradient(
              //                   begin: Alignment.centerLeft,
              //                   end: Alignment.centerRight,
              //                   colors: [
              //                     Color(0xFFFFF56A),
              //                     Color(0xFFEBBD48),
              //                     Color(0xFFFFFF74),
              //                     Color(0xFFC89A2C),
              //                   ],
              //                   stops: [0.0, 0.2944, 0.5896, 1.0],
              //                 ),
              //               ),
              //             ),
              //             Container(
              //               height: screenHeight * 0.058,
              //               width: screenWidth*0.37,
              //               decoration: BoxDecoration(
              //                 gradient: LinearGradient(
              //                   begin: Alignment.topCenter,
              //                   end: Alignment.bottomCenter,
              //                   colors: [
              //                     Color.fromRGBO(47, 47, 47, 0.2),
              //                     Color.fromRGBO(47, 47, 47, 0.2),
              //                   ],
              //                 ),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   AppConstants.cliam,
              //                   style: TextStyleClass.textcolorstyle2(
              //                     context,
              //                     screenWidth * 0.05,
              //                     ColorHelperClass.getColorFromHex(ColorResources.text6color),
              //                     0.45,
              //                     FontWeight.w500,
              //                   ),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),


          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: screenWidth*0.05),
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Obx((){
              return Text(controller.referContent.value.toString(),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyleClass.textcolorstyle2(context, screenWidth * 0.032,

                      ColorHelperClass.getColorFromHex(ColorResources.text3color),0.45,
                      FontWeight.w700));






            }),),
          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }
}
