import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';
import 'package:provider/provider.dart';

Widget customRowAndForgetPassword() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 50,
            child: Consumer<LoginProvider>(
              builder: (context, provider, child) {
                return FlutterSwitch(
                  activeColor: ColorConstraint.primaryColor,
                  value: provider.valueRemember,
                  onToggle: (value) {
                    provider.changeRemember(value);
                  },
                );
              },
            ),
          ),
          Spaces.smallw,
          customTextWidget(text: 'Remember me', fontSize: 14)
        ],
      ),
      customTextWidget(text: 'Forgot Password?', fontSize: 14, decoration: true)
    ],
  );
}
