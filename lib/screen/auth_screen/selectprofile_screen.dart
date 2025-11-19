import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate_user/controller/auth/RegisterController.dart';
import 'package:magicmate_user/screen/auth_screen/widget/CustomButtonWithRipple.dart';
import 'package:magicmate_user/screen/auth_screen/widget/nabhiverse_widget.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';

class SelectprofileScreen extends StatefulWidget {
  const SelectprofileScreen({super.key});

  @override
  State<SelectprofileScreen> createState() => _SelectprofileScreenState();
}

class _SelectprofileScreenState extends State<SelectprofileScreen> {
  var screenSize;
  var screenHeight;
  var  screenWidth;
  var isSmallHeight;
  RegisterController controller=Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
     screenSize = MediaQuery.of(context).size;
     screenHeight = screenSize.height;
     screenWidth = screenSize.width;
     isSmallHeight = screenHeight < 700;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
            height: screenHeight,
            width: screenWidth,
            margin: EdgeInsets.only(left: 20,right: 20),
            child: SingleChildScrollView(
              child: Container(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: isSmallHeight ? screenHeight * 0.09 : screenHeight * 0.098),
                    NabhiverseWidget(center: TextAlign.start,mainAxisAlignment: MainAxisAlignment.center,),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      AppConstants.selectprofile,
                      style: TextStyleClass.white28style(context,screenWidth*0.07),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    selectUser("normal",AppImagesssss.newuser),
                    selectUser("business",AppImagesssss.businessuser),
                    SizedBox(height: screenHeight * 0.01),
                    Obx((){
                      return CustomButtonWithRipple(
                        isEnabled: !controller.loading.value,
                        child: controller.loading.value
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : Text(
                          AppConstants.submit,
                          style: TextStyleClass.black, // Or any other appropriate style
                        ),
                        onPressed: () {
                          print("grfertgggggggggggggggggtyu");
                          controller.userRegister(context);

                        },
                        height: isSmallHeight ? screenHeight * 0.075 : screenHeight * 0.062,
                      );
                    }),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
  Widget selectUser(String user, String UserImage)
  {
    return GestureDetector(
      onTap: (){
        controller.selectedUser.value = user;

      },
      child: Column(
        children: [
          Container(
            child: Image.asset(UserImage,),
          ),
          Center(
            child: Obx((){
              return Radio<String>(
                value: user,
                groupValue: controller.selectedUser.value,
                onChanged: (value) {
                  controller.selectedUser.value = value!;

                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
