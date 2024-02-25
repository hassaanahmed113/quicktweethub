import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/modules/dashboard/dashboard.dart';

class LoginProvider extends ChangeNotifier {
  bool valueRemember = false;
  bool showPw = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void changeRemember(bool val) {
    valueRemember = val;
    notifyListeners();
  }

  void changePasswordShow(bool val) {
    showPw = val;
    notifyListeners();
  }

  Future<User?> signInUser(BuildContext context) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ));
      email.clear();
      password.clear();
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code.toString());
      if (e.code == 'user-not-found') {
        // ignore: use_build_context_synchronously
        showText(context, 'User not Found');
      } else if (e.code == 'invalid-email') {
        // ignore: use_build_context_synchronously
        showText(context, 'Invalid Email');
      } else if (e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        showText(context, 'wrong password');
      } else if (e.code == 'user-disabled') {
        // ignore: use_build_context_synchronously
        showText(context, 'User disabled');
      } else if (e.code == 'invalid-credential') {
        // ignore: use_build_context_synchronously
        showText(context, 'invalid credential');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

void showText(BuildContext context, data) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(data),
    backgroundColor: Colors.red,
  ));
}
