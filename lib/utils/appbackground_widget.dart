import 'package:flutter/material.dart';

class AppbackgroundWidget extends StatelessWidget {
  const AppbackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return  Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"), // Replace with your image path
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
