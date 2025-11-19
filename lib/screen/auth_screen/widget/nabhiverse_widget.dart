import 'package:flutter/material.dart';
import 'package:magicmate_user/utils/AppConstants.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';

class NabhiverseWidget extends StatelessWidget {
  TextAlign center;
  MainAxisAlignment mainAxisAlignment;
   NabhiverseWidget({super.key, required this.center,required this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;


    final isSmallHeight = screenHeight < 700;
    return  Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Image.asset("assets/star.png", height: isSmallHeight ? screenHeight * 0.05 : screenHeight * 0.07, width: isSmallHeight ? screenWidth * 0.1 : screenWidth * 0.1),
        Padding(
          padding:  EdgeInsets.only(left: 8.0),
          child: Text(
            AppConstants.appName,
            style: TextStyleClass.white30,
            textAlign: center,
          ),
        ),
      ],
    );
  }
}
