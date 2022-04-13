import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/widget/dialog/custom_text.dart';

showCustomSnackbar(
  BuildContext context,
  String? text, {
  Color? backColor,
  Color? textColor,
}) {
  var snackBar = SnackBar(
    backgroundColor: backColor ?? ColorSty.primaryDark,
    content: CustomText(
      text: text,
      color: textColor ?? Colors.white,
      isBold: true,
      fontSize: 16.sp,
    ),
    duration: const Duration(milliseconds: 1500),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
