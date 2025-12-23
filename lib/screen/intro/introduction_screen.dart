import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magicmate_user/controller/introduction/IntroductionController.dart';
import 'package:magicmate_user/screen/auth_screen/widget/nabhiverse_widget.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';
import 'package:magicmate_user/utils/appbackground_widget.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final IntroductionController controller = Get.put(IntroductionController());
  final List<Map<String, String>> _pages = [
    {
      'title': 'Say hello to\nSuper UPI',
      'description': 'Where UPI payments are designed to reward you with SUPER coins - India’s new multipurpose currency',
      'image': AppImagesssss.intro_1,
    },
    {
      'title': 'Refer & Earn',
      'description': 'Where UPI payments are designed to reward you with SUPER coins - India’s new multipurpose currency',
      'image': AppImagesssss.intro_2,
    },
    {
      'title': 'Super App UPI',
      'description': 'Where UPI payments are designed to reward you with SUPER coins - India’s new multipurpose currency',
      'image': AppImagesssss.intro_3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isSmallHeight = screenHeight < 700.00;
   print("ffff"+isSmallHeight.toString());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppbackgroundWidget(),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: isSmallHeight ? screenHeight * 0.05 : screenHeight * 0.08),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Welcome to',
                    style: TextStyleClass.white28style(context,Dimensions.fontSize28),
                    textAlign: TextAlign.center,
                  ),
                ),
                NabhiverseWidget(center: TextAlign.center,mainAxisAlignment: MainAxisAlignment.center,),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: _pages.length,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Use screen height to determine the size of elements

                          SizedBox(height: screenHeight * 0.02),
                          Image.asset(
                            page['image']!,
                            height: isSmallHeight ? screenHeight * 0.25 : screenHeight * 0.31,
                            width: isSmallHeight ? screenWidth * 0.8 : screenWidth * 0.9,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            page['title']!,
                            style: TextStyle(
                              fontSize: isSmallHeight ? screenHeight * 0.03 : screenHeight * 0.04,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: "SFProDisplay"
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.013),
                          Container(
                            padding: EdgeInsets.only(left: 30,right: 30,),
                            child: Text(
                              page['description']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProDisplay",
                                fontSize: isSmallHeight ? screenHeight * 0.02 : screenHeight * 0.02,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentPage.value == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index ? Colors.amber : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: screenHeight * 0.03),
                  child: Obx(() {
                    bool isLogin = controller.currentPage.value == 2;

                    return isLogin
                        ? ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(13),
                        minimumSize: Size(double.infinity, screenHeight*0.03),
                        backgroundColor: ColorHelperClass.getColorFromHex(ColorResources.primary_color),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(AppConstants.next,
                        style: TextStyleClass.black,
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: controller.skipToLast,
                          child: Text(AppConstants.skip, style: TextStyleClass.white18),
                        ),
                        ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth*0.28, screenHeight*0.03),
                            padding: EdgeInsets.all(13),
                            backgroundColor: ColorHelperClass.getColorFromHex(ColorResources.primary_color),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text('NEXT',
                            style: TextStyleClass.black
                          ),
                        ),
                      ],
                    );
                  }),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
