import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories_pages/huawei.dart';
import 'package:sudaphone_sd/view/categories_pages/iphone.dart';
import 'package:sudaphone_sd/view/categories_pages/lenovo.dart';
import 'package:sudaphone_sd/view/categories_pages/oppo.dart';
import 'package:sudaphone_sd/view/categories_pages/realme.dart';
import 'package:sudaphone_sd/view/categories_pages/samsung.dart';

class ScreenViewModel extends GetxController {
  //Declare Variables
  RxInt? activeIndex = 0.obs;
  RxDouble value = 0.0.obs;
  PageController controllerCarousel =
      PageController(viewportFraction: 0.8, keepPage: true);
  final List<MaterialColor> colors = const [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.pink,
    Colors.blue,
    Colors.amber,
  ];
  final List<String> imagesCarousel = [
    "assets/images/slider/1.png",
    "assets/images/slider/2.png",
    "assets/images/slider/3.jpg",
    "assets/images/slider/4.jpg",
    "assets/images/slider/5.jpg",
    "assets/images/slider/6.jpg",
  ];
  final List<String> imagesCateLogo = [
    "assets/images/logo/huawei.png",
    "assets/images/logo/iphone.jpg",
    "assets/images/logo/lenovo.png",
    "assets/images/logo/samsung.jpg",
    "assets/images/logo/oppo.jpg",
    "assets/images/logo/realme.png",
    "assets/images/logo/tecno.png",
  ];
  final List<String> text = [
   "Huawei",
   "Iphone",
   "Lenovo",
   "Samsung",
   "Oppo",
   "Realme",
   "Tecno",
  ];
  final List<dynamic> ontap = [
    Get.to(() => Huawei()),
    Get.to(() => Iphone()),
    Get.to(() => Lenovo()),
    Get.to(() => Samsung()),
    Get.to(() => Oppo()),
    Get.to(() => Realme()),
    Get.to(() => Tecno()),
  ];

  final List<String> images = [
    'assets/images/carousel/1.jpg',
    'assets/images/carousel/1.jpg',
    'assets/images/carousel/1.jpg',
    'assets/images/carousel/1.jpg'
  ];



  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }
 
}

class Tecno {
}
