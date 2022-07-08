import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PublicData extends GetxController {
  late String userName;
  late String imageUrl;
  late Map<String, dynamic> map;

  Future<void> getUserInfo(String userDoc) async {
    FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(userDoc)
        .get()
        .then((docSnapshot) => map = docSnapshot.data()!);
    userName = map['userName'];
    imageUrl = map['profileUrl'];
  }
}
