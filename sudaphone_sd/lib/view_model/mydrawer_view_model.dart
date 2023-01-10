import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/view/login/signin.dart';

class MyDrawerViewModel extends GetxController {
  // ((((((((((((((((((((((((((( Declaring Variables )))))))))))))))))))))))))))
  double value = 0.0;
  CollectionReference<Map<String, dynamic>> userInfo =
      FirebaseFirestore.instance.collection("usersInfo");
  SharedPreferences? prefs;
  // ((((((((((((((((((((((((((((((( Declaring Methods )))))))))))))))))))))))))))))))

  void valueOne() {
    value = 1.0;
    update();
  }

  void valueZero() {
    value = 0.0;
    update();
  }

  logOut() async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => Center(
        child: Image.asset("assets/images/loader.gif"),
      ),
    );
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    Get.back();
    Get.off(() => const SignIn());
  }
}
