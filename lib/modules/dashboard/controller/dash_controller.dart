import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/core/model/user_model.dart';

class DashProvider extends ChangeNotifier {
  TextEditingController post = TextEditingController();
  late UserModel data;
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<String> friendList = [];

  void friendAdded(List<dynamic> data) {
    for (var i = 0; i < data.length; i++) {
      friendList.add(data[i]);
    }
    notifyListeners();
  }

  void updateUser(UserModel user) {
    data = user;
    notifyListeners();
  }

  void getUserData() async {
    if (auth.currentUser != null) {
      DocumentSnapshot userData =
          await db.collection('users').doc(auth.currentUser!.uid).get();
      data = UserModel(
        name: userData.get('name'),
        username: userData.get('username'),
        id: userData.get('id'),
      );
      notifyListeners(); // Move this line outside of the build phase
    } else {
      print('User signout');
    }
  }
}
