import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_signup/core/custom_btm_text.dart';
import 'package:login_signup/core/custom_btn_login.dart';
import 'package:login_signup/core/custom_login_cont.dart';
import 'package:login_signup/core/global_elevatedbtn.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/global_textfield.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';
import 'package:login_signup/modules/login/login_screen.dart';
import 'package:login_signup/modules/signup/controller/signup_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: ScreenSize.screenHeight(context),
            width: ScreenSize.screenWidth(context),
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: ScreenSize.screenHeight(context),
              width: ScreenSize.screenWidth(context),
            ),
          ),
          Container(
            height: ScreenSize.screenHeight(context),
            width: ScreenSize.screenWidth(context),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.8),
                  Colors.black
                ])),
          ),
          SizedBox(
            height: ScreenSize.screenHeight(context),
            width: ScreenSize.screenWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.large,
                    Spaces.large,
                    Align(
                      alignment: Alignment.topCenter,
                      child: customTextWidget(
                          text: 'Signup',
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    Spaces.large,
                    customTextWidget(
                        text: 'User Name',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    Spaces.smallh,
                    customTextField(
                        showPw: false,
                        controller: signupProvider.username,
                        hintext: 'User Name'),
                    Spaces.mid,
                    customTextWidget(
                        text: 'Email',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    Spaces.smallh,
                    customTextField(
                        showPw: false,
                        controller: signupProvider.emailSignup,
                        hintext: 'Email Address'),
                    Spaces.mid,
                    customTextWidget(
                        text: 'Name',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    Spaces.smallh,
                    customTextField(
                        showPw: false,
                        controller: signupProvider.name,
                        hintext: 'Your Name'),
                    Spaces.mid,
                    customTextWidget(
                        text: 'Password',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    Spaces.smallh,
                    Consumer<SignupProvider>(
                      builder: (context, provider, child) {
                        return customTextField(
                            controller: signupProvider.passwordSignup,
                            hintext: 'Password',
                            showPw: provider.showPw,
                            onClickBtn: () {
                              if (provider.showPw == true) {
                                provider.changePasswordShow(false);
                              } else {
                                provider.changePasswordShow(true);
                              }
                            },
                            showVisible: true);
                      },
                    ),
                    Spaces.large,
                    Spaces.smallh,
                    customElevatedBtn(
                        context: context,
                        text: 'Signup',
                        onpressed: () {
                          if (signupProvider.emailSignup.text.isNotEmpty &&
                              signupProvider.passwordSignup.text.isNotEmpty &&
                              signupProvider.name.text.isNotEmpty &&
                              signupProvider.username.text.isNotEmpty) {
                            signupProvider.signUpUser(context);
                          } else {
                            showText(context, 'Fill the empty fields');
                          }
                        }),
                    Spaces.mid,
                    customBtmText('Already have an account! ', 'Login', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
