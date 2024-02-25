import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_signup/core/global_elevatedbtn.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/global_textfield.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/core/custom_btm_text.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';
import 'package:login_signup/modules/signup/signup_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spaces.large,
                            Spaces.large,
                            Spaces.large,
                            Align(
                              alignment: Alignment.topCenter,
                              child: customTextWidget(
                                  text: 'Login',
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spaces.large,
                            customTextWidget(
                                text: 'Email',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            Spaces.smallh,
                            customTextField(
                                showPw: false,
                                controller: loginProvider.email,
                                hintext: 'Email Address'),
                            Spaces.mid,
                            customTextWidget(
                                text: 'Password',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            Spaces.smallh,
                            Consumer<LoginProvider>(
                              builder: (context, provider, child) {
                                return customTextField(
                                    controller: loginProvider.password,
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
                            customElevatedBtn(
                                context: context,
                                text: 'Login',
                                onpressed: () {
                                  if (loginProvider.email.text.isNotEmpty &&
                                      loginProvider.password.text.isNotEmpty) {
                                    loginProvider.signInUser(context);
                                  } else {
                                    showText(context, 'Fill the empty fields');
                                  }
                                }),
                            const Spacer(),
                            customBtmText('Don’t have an account? ', 'Signup',
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  ));
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
