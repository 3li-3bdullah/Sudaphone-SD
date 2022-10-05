import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedbackViewModel extends GetxController {
// ((((((((((((((((((((((( Variables )))))))))))))))))))))))

  TextEditingController textEditingController = TextEditingController();
  GlobalKey textKey = GlobalKey<FormState>();
  final date = DateFormat('M/d/y - kk:mm').format(DateTime.now());
  Size size = MediaQuery.of(Get.context!).size;

// ((((((((((((((((((((((((((( Methods )))))))))))))))))))))))))))

  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  sendFeedback(
      {GlobalKey? key,
      String? text,
      String? uid,
      String? name,
      String? profileUrl}) async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) => Center(
        child: Image.asset("assets/images/loader.gif"),
      ),
    );
    await FirebaseFirestore.instance.collection("Feedbacks").add({
      "Note": text.toString(),
      "Sender Name": name.toString(),
      "Sender Id": uid.toString(),
      "Time": date.toString(),
      "profileUrl": profileUrl.toString()
    }).whenComplete(() => Get.back());
    Get.snackbar("", "Your Feedback Has Sent Successfully, Thanks 😉..",
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.brown,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
    textEditingController.clear();
  }
}
