import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: Get.height,
          width: Get.width,
        ),
        Positioned(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: Image.asset(
              'assets/images/logo/app_logo.jpg',
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
            ),
          ),
        ),
        Positioned(
            child: Container(
          color: Colors.white30,
          height: Get.height,
          width: Get.width,
        )),
        Positioned(child: Image.asset('assets/images/logo/app_logo_trans.png'))
      ],
    );
  }
}
