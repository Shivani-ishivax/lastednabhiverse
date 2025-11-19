import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/controller/auth/LoginController.dart';
import 'package:magicmate_user/screen/auth_screen/widget/CustomButtonWithRipple.dart';
import 'package:magicmate_user/screen/auth_screen/widget/nabhiverse_widget.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';

import 'package:magicmate_user/utils/appbackground_widget.dart';


import '../../utils/AppColors.dart' show ColorResources;
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginController controller=Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //controller.requestCameraAndMediaPermissions();


  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isSmallHeight = screenHeight < 700;
    print("fgfggg"+isSmallHeight.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  child: Container(
                    child:  Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isSmallHeight ? screenHeight * 0.09 : screenHeight * 0.098),
                          NabhiverseWidget(center: TextAlign.start,mainAxisAlignment: MainAxisAlignment.start,),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            AppConstants.login_content,
                            style: TextStyleClass.white28style(context,Dimensions.fontSize21),
                          ),
                          Text(
                            AppConstants.appName,
                            style: TextStyleClass.white30,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          SizedBox(
                            width: screenWidth,
                            height: isSmallHeight ? screenHeight * 0.075 : screenHeight * 0.07,
                            child: Stack(
                              children: [
                                Image.asset("assets/edittext_back.png",width: screenWidth,fit: BoxFit.fill,),
                                Container(

                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                  child: Row(
                                    children: [
                                      Text("+91",
                                        style: TextStyleClass.textcolorstyle(context, Dimensions.fontSize18,ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        color: ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                        height: 30,
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                ),


                                TextFormField(
                                  controller: controller.phoneController,
                                  validator: (value) {
                                    if (value == null || value.length != 10 || !RegExp(r'^\d{10}$').hasMatch(value)) {
                                      return 'Enter a valid 10-digit number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly, // Restrict input to digits
                                  ],

                                  style: TextStyleClass.textcolorstyle(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                  decoration: InputDecoration(
                                    hintText: "Drop your number here",
                                    hintStyle: TextStyleClass.textcolorstyle(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                    filled: true,

                                    fillColor: Colors.transparent, // Show background image
                                    border: OutlineInputBorder(

                                      borderSide: BorderSide.none, // Remove underline
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Center(
                            child: Text(
                              AppConstants.refercode_content,
                              style: TextStyleClass.textcolorstyle(context,18,ColorHelperClass.getColorFromHex(ColorResources.text2color)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: screenWidth*0.48,
                              margin: EdgeInsets.only(top: 3),
                              alignment: Alignment.center,
                              height: 2,
                              child: Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

                Container(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.isTerms.value = !controller.isTerms.value;
                                    },
                                    child: Obx(() {
                                      return Icon(
                                        controller.isTerms.value ? Icons.check_box : Icons.check_box_outline_blank,
                                        size: screenHeight * 0.037,
                                        color: controller.isTerms.value
                                            ? ColorHelperClass.getColorFromHex(ColorResources.primary_color)
                                            : Colors.white,
                                      );
                                    }),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyleClass.textcolorstyle(
                                              context,
                                              screenWidth * 0.033,
                                              ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
                                            ),
                                            children: [
                                              TextSpan(text: 'I agree to the '),
                                              TextSpan(
                                                text: 'Terms & Conditions',
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextSpan(text: ' and '),
                                              TextSpan(
                                                text: 'Privacy Policy',
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          AppConstants.login2_content,
                                          style: TextStyleClass.textcolorstyle(
                                            context,
                                            screenWidth * 0.026,
                                            ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),


                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  controller.isTerms2.value = !controller.isTerms2.value;
                                },
                                child: Obx((){
                                  return Icon(
                                    controller.isTerms2.value ? Icons.check_box : Icons.check_box_outline_blank,
                                    size: screenHeight * 0.037,
                                    color: controller.isTerms2.value ? ColorHelperClass.getColorFromHex(ColorResources.primary_color) : Colors.white,
                                  );
                                }),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3, ),
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(AppConstants.login3_content,
                                          style: TextStyleClass.textcolorstyle(context, screenWidth * 0.033, ColorHelperClass.getColorFromHex(ColorResources.whitecolor)),),

                                      ],
                                    ),
                                    Text("  "+
                                        AppConstants.login4_content,
                                      style: TextStyleClass.textcolorstyle(context, screenWidth * 0.026, ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )



                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      Obx(() => CustomButtonWithRipple(
                        child: controller.loading.value
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ):Text(AppConstants.getotp,style: TextStyleClass.black,),
                        isEnabled: controller.isButtonLoginEnabled.value,
                        onPressed: controller.isButtonLoginEnabled.value
                            ? () => controller.goToOtpScreen(context)
                            : () {},
                        height: isSmallHeight ? screenHeight * 0.075 : screenHeight * 0.062,
                      )
                      ),
                      SizedBox(height: isSmallHeight ? screenHeight * 0.06:screenHeight * 0.05),
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
}
