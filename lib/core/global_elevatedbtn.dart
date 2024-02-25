import 'package:flutter/material.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';

Widget customElevatedBtn(
    {required BuildContext context,
    required String text,
    onpressed,
    Color? color}) {
  return GestureDetector(
    onTap: onpressed,
    child: Container(
        alignment: Alignment.center,
        height: ScreenSize.screenHeight(context) * 0.08,
        width: ScreenSize.screenWidth(context),
        decoration: BoxDecoration(
            color: color ?? ColorConstraint.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        child: customTextWidget(
            text: text, fontSize: 20, fontWeight: FontWeight.bold)),
  );
}
