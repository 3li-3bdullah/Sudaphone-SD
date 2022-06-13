import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedbackViewModel extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey textKey = GlobalKey<FormState>();
  String? uId;
  Map<String, dynamic>? uInfo;
  final date = DateFormat('M/d/y - kk:mm').format(DateTime.now());

  @override
  void onInit() {
    uId = FirebaseAuth.instance.currentUser!.uid;
    getUserInfo();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.clear();
    super.onClose();
  }

  getUserInfo() async {
    uInfo = await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(uId.toString())
        .get()
        .then((value) => value.data());
  }

  sendFeedback({GlobalKey? key, String? text}) async {
    await FirebaseFirestore.instance.collection("Feedbacks").add({
      "Note": text.toString(),
      "Sender Name": uInfo!['username'].toString(),
      "Sender Id": uId.toString(),
      "Time": date.toString(),
    });
  }
}
