import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:magicmate_user/controller/auth/RegisterController.dart';
import 'package:magicmate_user/screen/auth_screen/selectprofile_screen.dart';
import 'package:magicmate_user/screen/auth_screen/widget/CustomButtonWithRipple.dart';
import 'package:magicmate_user/screen/auth_screen/widget/nabhiverse_widget.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';

import '../../utils/AppColors.dart' show ColorResources;
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller=Get.put(RegisterController());
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      controller.phoneController.value.text = args['mobile'].toString();
      print("Received mobile: ${controller.phoneController.value.text}");
    }
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
                                      Icon(Icons.person,color: ColorHelperClass.getColorFromHex(ColorResources.textcolor),),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        color: ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                        height: 30,
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.nameController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyleClass.textcolorstyle(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                  decoration: InputDecoration(
                                    hintText: "Enter your name",
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

                          SizedBox(height: screenHeight * 0.02),
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


                                Obx((){
                                  return TextFormField(
                                    controller: controller.phoneController.value,
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
                                  );
                                })
                              ],
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),
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
                                      Icon(Icons.email,color: ColorHelperClass.getColorFromHex(ColorResources.textcolor),),
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        color: ColorHelperClass.getColorFromHex(ColorResources.textcolor),
                                        height: 30,
                                        width: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyleClass.textcolorstyle(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.textcolor)),
                                  decoration: InputDecoration(
                                    hintText: "Enter your email",
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


                        ],
                      ),
                    ),
                  ),
                )),

                CustomButtonWithRipple(
                  child: Text(AppConstants.next,style: TextStyleClass.black,),

                  onPressed:(){
                    if (controller.formKey.currentState!.validate()) {
                      var name=   controller.nameController.text;
                      var mobile= controller.phoneController.value.text;
                      var email = controller.emailCon.text;
                      if (name.trim().isEmpty) {
                        Get.snackbar("Error", "Please enter your name", backgroundColor: Colors.red[300], colorText: Colors.white);
                      }
                      else if (mobile.trim().isEmpty) {
                        Get.snackbar("Error", "Please enter your mobile", backgroundColor: Colors.red[300], colorText: Colors.white);
                      }
                      else if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
                        Get.snackbar("Error", "Please enter a valid 10-digit mobile number", backgroundColor: Colors.red[300], colorText: Colors.white);
                      }
                      else if (email.trim().isEmpty) {
                        Get.snackbar("Error", "Please enter your email", backgroundColor: Colors.red[300], colorText: Colors.white);
                      }

                      else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
                        Get.snackbar("Error", "Please enter a valid email address", backgroundColor: Colors.red[300], colorText: Colors.white);
                      }
                      else {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => const SelectprofileScreen(),
                          ),
                        );

                      }



                    }
                  },
                  height: isSmallHeight ? screenHeight * 0.075 : screenHeight * 0.062,
                ),
                SizedBox(height: isSmallHeight ? screenHeight * 0.06:screenHeight * 0.05),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
