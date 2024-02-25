import 'package:flutter/material.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';

Widget customLoginWithContainer(BuildContext context, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 1,
        width: ScreenSize.screenWidth(context) * 0.27,
        color: ColorConstraint.whiteColor,
      ),
      Spaces.smallw,
      customTextWidget(text: text),
      Spaces.smallw,
      Container(
        height: 1,
        width: ScreenSize.screenWidth(context) * 0.27,
        color: ColorConstraint.whiteColor,
      ),
    ],
  );
}
