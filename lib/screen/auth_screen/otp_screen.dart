import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:magicmate_user/controller/auth/OtpController.dart';
import 'package:magicmate_user/screen/auth_screen/widget/CustomButtonWithRipple.dart';
import 'package:magicmate_user/screen/auth_screen/widget/nabhiverse_widget.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';


class OtpScreenview extends StatefulWidget {
  const OtpScreenview({super.key});

  @override
  State<OtpScreenview> createState() => _OtpScreenviewState();
}

class _OtpScreenviewState extends State<OtpScreenview> {
  Otpcontroller controller=Get.put(Otpcontroller());
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      controller.mobile.value = args['mobile'];
      print("Received mobile: ${controller.mobile.value}");
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isSmallHeight = screenHeight < 700.00;
    print("fgfggg"+isSmallHeight.toString()+""+screenHeight.toString());
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
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isSmallHeight ? screenHeight * 0.09 : screenHeight * 0.098),
                        NabhiverseWidget(center: TextAlign.start,mainAxisAlignment: MainAxisAlignment.start,),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          AppConstants.enterotp,
                          style: TextStyleClass.white28style(context,screenWidth*0.08),
                        ),
                        SizedBox(height: screenHeight * 0.004),
                        Text("Send to:- +91${controller.mobile.value}",
                          style: TextStyleClass.textcolorstyle(context,screenWidth*0.035,ColorHelperClass.getColorFromHex(ColorResources.text2color).withOpacity(0.8) ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(6, (index) {
                              int focused = controller.focusedIndex.value;
                              bool isSelectedBackground = index <= focused;
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 3.2),
                                    child: SvgPicture.asset(
                                      isSelectedBackground
                                          ? "assets/select_otp.svg"
                                          : "assets/unselect_otp.svg",
                                      width: screenWidth * 0.139,
                                      height: screenHeight * 0.064,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.139,
                                    height: screenHeight * 0.065,
                                    child: Center(
                                      child: TextField(

                                        controller: controller.otpcontrollers[index],
                                        focusNode: controller.otpfocusNodes[index],
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly, // Restrict input to digits
                                        ],
                                        maxLength: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 16, color: Colors.white),
                                        decoration: const InputDecoration(
                                          counterText: '',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          controller.onChangedOTP(value, index);
                                          if (value.isNotEmpty && index < 5) {
                                            controller.focusedIndex.value = index + 1;
                                            FocusScope.of(context).requestFocus(controller.otpfocusNodes[index + 1]);
                                          }
                                        },
                                        onTap: () {
                                          controller.focusedIndex.value = index;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          )),
                        ),

                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Obx(() => Text(
                              controller.isTimerRunning.value
                                  ? "Resend OTP in ${controller.remainingSeconds.value}s"
                                  : "Didn't receive OTP?",
                              style: TextStyleClass.textcolorstyle(context,screenWidth*0.035,ColorHelperClass.getColorFromHex(ColorResources.text2color).withOpacity(0.8) ),
                            )),

                            Obx(() => TextButton(
                              onPressed: controller.isTimerRunning.value
                                  ? null
                                  : () => controller.resendOtp(),
                              child: Text(AppConstants.clicktoresent,
                                style: TextStyle(
                                  fontSize: screenWidth*0.035,
                                  fontFamily: "SFProDisplay",
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                    letterSpacing: 0.3,
                                  color: controller.isTimerRunning.value ? Colors.grey : ColorHelperClass.getColorFromHex(ColorResources.primary_color2).withOpacity(0.8) ,
                                ),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.0089),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              AppConstants.changeno,
                              style: TextStyleClass.textcolorstyle(context,18,ColorHelperClass.getColorFromHex(ColorResources.text2color)),
                              textAlign: TextAlign.center,
                            ),
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
                        ):Text(AppConstants.verify,style: TextStyleClass.black,),
                        isEnabled: controller.isTerms.value && controller.isTerms2.value,
                        onPressed: (controller.isTerms.value && controller.isTerms2.value)
                            ? () => controller.goToProfileScreen(context)
                            : () {},
                        height: isSmallHeight ? screenHeight * 0.075 : screenHeight * 0.062,
                      )),
                      SizedBox(height: isSmallHeight ? screenHeight * 0.06:screenHeight * 0.05),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: BottomInternetBanner(),
          // ),


        ],
      ),
    );
  }
}
