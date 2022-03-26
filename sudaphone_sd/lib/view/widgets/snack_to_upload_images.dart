import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

class SanckToUploadImages {
  static void showTheSnack({required Function gallery, required Function camera}) {
    Get.defaultDialog(
      content: const CustomText(
        text: "Choose an image from : ",
        textAlign: TextAlign.center,
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      title: "Upload an image",
      textCancel: "Gallery",
      textConfirm: "Camera",
      onCancel: () {
        gallery();
      },
      onConfirm: () {
        camera();
      },
    );
  }
}