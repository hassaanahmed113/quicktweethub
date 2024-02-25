import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/core/utils/color_utils.dart';

Widget customTextWidget(
    {required String text,
    double? fontSize,
    FontWeight? fontWeight,
    bool? decoration = false,
    Color? decorationColor,
    Color? fontColor}) {
  return Text(text,
      style: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: fontColor ?? ColorConstraint.whiteColor,
          decorationColor: decorationColor ?? ColorConstraint.whiteColor,
          decoration: decoration == true
              ? TextDecoration.underline
              : TextDecoration.none));
}
