import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';

class SanckToUploadImages {
  static void showTheSnack({required Function gallery, required Function camera}) {
    Get.defaultDialog(
      content: const CustomText2(
        text: "Upload an image from : ",
        textAlign: TextAlign.center,
        color: Colors.brown,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      title: "",
      textCancel: "Gallery",
      textConfirm: "Camera",
      onCancel: () {
        gallery();
      },
      onConfirm: () {
        camera();
      },
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.brown,
      buttonColor: Colors.brown,
    );
  }
}