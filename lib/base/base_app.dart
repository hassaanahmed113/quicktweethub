import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/modules/dashboard/controller/dash_controller.dart';
import 'package:login_signup/modules/dashboard/dashboard.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';
import 'package:login_signup/modules/login/login_screen.dart';
import 'package:login_signup/modules/signup/controller/signup_provider.dart';
import 'package:provider/provider.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DashboardPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
