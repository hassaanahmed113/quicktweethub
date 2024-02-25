import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/core/model/user_model.dart';
import 'package:login_signup/modules/dashboard/dashboard.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';

class SignupProvider extends ChangeNotifier {
  bool showPw = true;
  TextEditingController username = TextEditingController();
  TextEditingController emailSignup = TextEditingController();
  TextEditingController passwordSignup = TextEditingController();
  TextEditingController name = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  void changePasswordShow(bool val) {
    showPw = val;
    notifyListeners();
  }

  Future<User?> signUpUser(BuildContext context) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: emailSignup.text, password: passwordSignup.text);
      List<String> friend = [""];
      UserModel data = UserModel(
          email: emailSignup.text,
          name: name.text,
          username: username.text,
          friend: friend,
          id: userCred.user!.uid);
      await db.collection('users').doc(userCred.user!.uid).set(data.toJson());
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ));
      username.clear();
      emailSignup.clear();

      passwordSignup.clear();
      name.clear();

      return userCred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        // ignore: use_build_context_synchronously
        showText(context, 'invalid email');
      } else if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        showText(context, 'weak password');
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        showText(context, 'user already exist');
      } else if (e.code == 'operation-not-allowed') {
        // ignore: use_build_context_synchronously
        showText(context, 'operation-not-allowed');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
