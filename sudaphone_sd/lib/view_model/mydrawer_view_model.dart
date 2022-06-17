import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyDrawerViewModel extends GetxController {
  /// Declaring Variables
  RxDouble value = 0.0.obs;
  RxString uid = "".obs;
  Future<void> logOut = FirebaseAuth.instance.signOut();
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // RxString? userName;
  CollectionReference<Map<String, dynamic>> userName = FirebaseFirestore.instance
      .collection("usersInfo");
      // .doc(FirebaseAuth.instance.currentUser!.uid);

  /// Some Methods
  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }
  @override
  void onInit() {
    uid.value = FirebaseAuth.instance.currentUser!.uid;
    super.onInit();
  }

  //  getUserInfo() async {
  //    DocumentReference<Map<String, dynamic>> getUser =
  //         FirebaseFirestore.instance.collection("usersInfo")
  //       .doc(_auth.currentUser?.uid);
  //      userName?.value =  await getUser.get().then((value) => value.data()?['userName']);

  //       // return getUser;
  // }
}
