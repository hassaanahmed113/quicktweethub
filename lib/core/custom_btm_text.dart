import 'package:flutter/material.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';

Widget customBtmText(String text1, String text2, onClickBtn) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customTextWidget(
            text: text1,
            fontSize: 17,
          ),
          GestureDetector(
            onTap: onClickBtn,
            child: customTextWidget(
              text: text2,
              fontColor: ColorConstraint.primaryColor,
              decorationColor: ColorConstraint.primaryColor,
              fontSize: 17,
              decoration: true,
            ),
          ),
        ],
      ),
    ),
  );
}
