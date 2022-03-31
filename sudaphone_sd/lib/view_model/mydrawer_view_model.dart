import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyDrawerViewModel extends GetxController {
  /// Declaring Variables
  RxDouble value = 0.0.obs;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // RxString? userName;
  DocumentReference<Map<String, dynamic>> userName = FirebaseFirestore.instance
      .collection("posts")
      .doc(FirebaseAuth.instance.currentUser?.uid);

  /// Some Methods
  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }

  //  getUserInfo() async {
  //    DocumentReference<Map<String, dynamic>> getUser =
  //         FirebaseFirestore.instance.collection("usersInfo")
  //       .doc(_auth.currentUser?.uid);
  //      userName?.value =  await getUser.get().then((value) => value.data()?['userName']);

  //       // return getUser;
  // }
}
