import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:magicmate_user/controller/profile/ProfileUpdateController.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
class LogoutWidget extends StatelessWidget {
  String title;
  String desc;
  String type;
   LogoutWidget({super.key,required  this.title,required this.desc, required this.type});

  @override
  Widget build(BuildContext context) {
    ProfileUPdateController controller =Get.put(ProfileUPdateController());
    return Center(
      child: Stack(
        children: [
          Container(
            height: 400,
            width: 340,
            decoration: BoxDecoration(
              color: ColorHelperClass.getColorFromHex(ColorResources.logoutcolor),
              image: DecorationImage(
                  image: AssetImage(AppImagesssss.backgrounditem,),
                  fit: BoxFit.fill
              ),
              borderRadius: BorderRadius.circular(20),
            ),


            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 10),
                    child: Text(desc,
                       textAlign: TextAlign.center,
                       style: TextStyleClass.textcolorstyle2(context, 20, ColorHelperClass.getColorFromHex(ColorResources.primary_color),0.34,FontWeight.w600)
                    ),
                  ) ,
                  Text(AppConstants.youillmissed,
                      style: TextStyleClass.textcolorstyle2(context, 14, ColorHelperClass.getColorFromHex(ColorResources.txt9color),0.34,FontWeight.w600)
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      child: SvgPicture.asset(AppImagesssss.sadface_back)),
                  SizedBox(height: 20,),
                  GestureDetector(
                      onTap: () async{
                         if(type=="1")
                           {
                             controller.clearAll(context);
                           }
                         else
                           {
                              controller.deleteUserAccount();
                           }
                        },
                    child: Center(
                      child: Text(title,
                          style: TextStyleClass.textcolorstyle2(context, 18, ColorHelperClass.getColorFromHex(ColorResources.primary_color),0.34,FontWeight.w600)
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFFF56A),
                                Color(0xFFEBBD48),
                                Color(0xFFFFFF74),
                                Color(0xFFC89A2C),
                              ],
                              stops: [0.0, 0.2944, 0.5896, 1.0],
                            ),
                          ),
                        ),
                        Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(47, 47, 47, 0.2),
                                  Color.fromRGBO(47, 47, 47, 0.2),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(AppConstants.cancel,
                                style: TextStyleClass.textcolorstyle2(context, 16, ColorHelperClass.getColorFromHex(ColorResources.txt10color),0.34,FontWeight.w600)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
