import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/view/signin.dart';

class MyDrawerViewModel extends GetxController {
  // ((((((((((((((((((((((((((( Declaring Variables )))))))))))))))))))))))))))
  RxDouble value = 0.0.obs;
  CollectionReference<Map<String, dynamic>> userInfo =
      FirebaseFirestore.instance.collection("usersInfo");
  RxInt internetConnectionChecker = 0.obs;
  late StreamSubscription<InternetConnectionStatus> listener;
  SharedPreferences? prefs;
  // ((((((((((((((((((((((((((((((( Declaring Methods )))))))))))))))))))))))))))))))
  @override
  void onInit() {
    listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          internetConnectionChecker.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          internetConnectionChecker.value = 0;
          break;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }

  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }

  logOut() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    Get.offAll(() => const SignIn());
  }
}
