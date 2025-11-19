import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/AppImagesssss.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
import 'package:magicmate_user/utils/Dimensions.dart';
import 'package:magicmate_user/utils/TextStyleClass.dart';


class CustomTextFormFieldss extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextFormFieldss({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppImagesssss.EditTextImage,),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          style: TextStyleClass.textcolorstyle2(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.whitecolor),1.2,FontWeight.w400),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:   TextStyleClass.textcolorstyle2(context,Dimensions.fontSize14,ColorHelperClass.getColorFromHex(ColorResources.whitecolor),1.2,FontWeight.w400),
            filled: true,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            fillColor: Colors.transparent, // Show background image
            border: OutlineInputBorder(
              borderSide: BorderSide.none, // Remove underline
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
        ),
      ],
    );
  }
}

