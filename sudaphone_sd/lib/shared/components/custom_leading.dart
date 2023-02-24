import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreensLeading extends StatelessWidget {
  const ScreensLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ));
  }
}
