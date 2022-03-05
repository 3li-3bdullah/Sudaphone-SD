import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnakbar {
  static void showSnakBar(
      {required BuildContext? context,
      required String title,
      required String message,
      required Color backgroundColor}) {
    Get.snackbar(title, message,
        backgroundGradient: const LinearGradient(
          colors: [Colors.pinkAccent, Colors.purpleAccent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        colorText: Colors.black,
        borderRadius: 10,
        margin: const EdgeInsets.all(16),);
  }
}
