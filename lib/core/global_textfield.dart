import 'package:flutter/material.dart';
import 'package:login_signup/core/utils/color_utils.dart';

Widget customTextField(
    {required TextEditingController controller,
    String? hintext,
    bool showVisible = false,
    bool showPw = true,
    onClickBtn}) {
  return TextField(
    obscureText: showPw,
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        filled: true,
        fillColor: ColorConstraint.tfColor,
        contentPadding: const EdgeInsets.all(20.0),
        hintText: hintext,
        suffixIcon: showVisible == true
            ? GestureDetector(
                onTap: onClickBtn,
                child: showPw == false
                    ? const Icon(
                        Icons.visibility_outlined,
                        color: ColorConstraint.tfHintColor,
                      )
                    : const Icon(
                        Icons.visibility_off_outlined,
                        color: ColorConstraint.tfHintColor,
                      ),
              )
            : Container(
                width: 10,
              ),
        hintStyle: const TextStyle(color: ColorConstraint.tfHintColor)),
  );
}
