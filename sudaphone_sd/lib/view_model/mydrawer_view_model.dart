import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyDrawerViewModel extends GetxController {
  /// Declaring Variables
  RxDouble value = 0.0.obs;
  FirebaseFirestore userName = FirebaseFirestore.instance;
  FirebaseAuth drawerAuth = FirebaseAuth.instance;
  String? name;

  /// Some Methods
  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }

  Future getUserName() async {
    await userName
        .collection("username")
        .doc(drawerAuth.currentUser!.uid)
        .get()
        .then((value) => value.data()!['username']);
    return name = userName.toString();
  }
}
