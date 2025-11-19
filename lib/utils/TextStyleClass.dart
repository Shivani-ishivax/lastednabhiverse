import 'package:flutter/material.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';

class TextStyleClass {

 static TextStyle white28style(BuildContext context,double size) {
    return TextStyle(
      fontFamily: "SFProDisplay",
      fontSize: size,
      color: ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
      fontWeight: FontWeight.w700,
      height: 1.3,
      letterSpacing: -0.24,
    );
  }
static TextStyle textcolorstyle(BuildContext context,double size, Color color) {
    return TextStyle(
      fontFamily: "SFProDisplay",
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: 0.3,
    );
  }
  static TextStyle textcolorstyle2(BuildContext context,double size, Color color, double latterspacing, FontWeight w) {
    return TextStyle(
      fontFamily: "SFProDisplay",
      fontSize: size,
      color: color,
      fontWeight: w,
      height: 1.2,
      letterSpacing: latterspacing,
      decoration: TextDecoration.none,
    );
  }
 static TextStyle textcolorfont(BuildContext context,double size, Color color, double latterspacing, FontWeight w) {
    return TextStyle(
      fontFamily: "Blaccious",
      fontSize: size,
      color: color,
      fontWeight: w,
      height: 1.2,
      letterSpacing: latterspacing,
    );
  }



  static TextStyle white30 = TextStyle(
    fontFamily: "SFProDisplay",
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSize30,
    letterSpacing: 0.48,
    height: 1.4,
    color: ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
    fontStyle: FontStyle.normal,

  );
  static TextStyle white18 = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.48,
    height: 1.4,
    color: ColorHelperClass.getColorFromHex(ColorResources.whitecolor),
    fontStyle: FontStyle.normal,

  );
  static TextStyle black = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: ColorHelperClass.getColorFromHex(ColorResources.btn_black_color),
    fontStyle: FontStyle.normal,

  );
  static TextStyle black22 = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w300,
    fontSize: 20,
    color: ColorHelperClass.getColorFromHex(ColorResources.btn_black_color),
    fontStyle: FontStyle.normal,

  );

}