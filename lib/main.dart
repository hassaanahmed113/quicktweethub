import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/base/base_app.dart';
import 'package:login_signup/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoginApp());
}
