import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CutomLeading extends StatelessWidget {
  const CutomLeading({super.key});

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
