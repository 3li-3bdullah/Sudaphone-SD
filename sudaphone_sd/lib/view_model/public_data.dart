import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PublicData extends GetxController {
  String? getUserName;
  late Map<String, dynamic> map;
  String? getProfileUrl;
  String? getEmail;
   String? uid;
   
  @override
  onInit() {
   uid = FirebaseAuth.instance.currentUser!.uid;
    userInfo();
    super.onInit();
  }
  Future<void> userInfo() async {
    map = await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(uid)
        .get()
        .then((docSnapshot) => docSnapshot.data()!);
    getUserName = map['userName'];
    getProfileUrl = map['profileUrl'];
    getEmail = map['email'];
    update();
  }
}
