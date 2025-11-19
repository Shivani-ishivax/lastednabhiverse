import 'package:flutter/material.dart';

import 'package:magicmate_user/utils/AppColors.dart';
import 'package:magicmate_user/utils/ColorHelperClass.dart';
class CustomButtonWithRipple extends StatelessWidget {
  final Widget child; // ✅ Changed from String text to Widget child
  final VoidCallback onPressed;
  final double height;
  final bool isEnabled;

  const CustomButtonWithRipple({
    super.key,
    required this.child,
    required this.onPressed,
    required this.height,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null, // disable tap when not enabled
      borderRadius: BorderRadius.circular(50),
      splashColor: Colors.amber.withOpacity(0.7),
      highlightColor: Colors.amber.withOpacity(0.5),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: isEnabled
              ? ColorHelperClass.getColorFromHex(ColorResources.primary_color)
              : ColorHelperClass.getColorFromHex(ColorResources.disablecolor),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(child: child),
      ),
    );
  }
}
