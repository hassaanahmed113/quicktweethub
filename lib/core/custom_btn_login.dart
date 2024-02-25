import 'package:flutter/material.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:svg_flutter/svg.dart';

Widget customLoginWithBtn(BuildContext context) {
  return SizedBox(
    width: ScreenSize.screenWidth(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 55,
          alignment: Alignment.center,
          width: ScreenSize.screenWidth(context) * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: ColorConstraint.greyColor,
          ),
          child: SvgPicture.asset('assets/svg/icons_google.svg'),
        ),
        Spaces.smallw,
        Container(
          height: 55,
          alignment: Alignment.center,
          width: ScreenSize.screenWidth(context) * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: ColorConstraint.greyColor,
          ),
          child: SvgPicture.asset('assets/svg/icons_apple.svg'),
        ),
        Spaces.smallw,
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: ColorConstraint.greyColor,
          ),
          alignment: Alignment.center,
          width: ScreenSize.screenWidth(context) * 0.27,
          child: SvgPicture.asset('assets/svg/icons_fb.svg'),
        ),
      ],
    ),
  );
}
