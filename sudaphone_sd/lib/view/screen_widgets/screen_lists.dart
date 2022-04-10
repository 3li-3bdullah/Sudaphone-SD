import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories_pages/huawei.dart';
import 'package:sudaphone_sd/view/categories_pages/iphone.dart';
import 'package:sudaphone_sd/view/categories_pages/lenovo.dart';
import 'package:sudaphone_sd/view/categories_pages/oppo.dart';
import 'package:sudaphone_sd/view/categories_pages/realme.dart';
import 'package:sudaphone_sd/view/categories_pages/samsung.dart';
import 'package:sudaphone_sd/view/categories_pages/tecno.dart';

class ScreenLists{
    static final controllerCarousel =
      PageController(viewportFraction: 0.8,initialPage: 0, keepPage: true);
  static const List<MaterialColor> colors = [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.pink,
    Colors.blue,
    Colors.amber,
  ];
   static const List<String> imagesCarousel = [
    "assets/images/slider/1.png",
    "assets/images/slider/2.png",
    "assets/images/slider/3.jpg",
    "assets/images/slider/4.jpg",
    "assets/images/slider/5.jpg",
    "assets/images/slider/6.jpg",
  ];
  static const List<String> imagesCateLogo = [
    "assets/images/logo/huawei.png",
    "assets/images/logo/iphone.jpg",
    "assets/images/logo/lenovo.png",
    "assets/images/logo/samsung.jpg",
    "assets/images/logo/oppo.jpg",
    "assets/images/logo/realme.png",
    "assets/images/logo/tecno.png",
  ];
  static const List<String> text = [
   "Huawei",
   "Iphone",
   "Lenovo",
   "Samsung",
   "Oppo",
   "Realme",
   "Tecno",
  ];
  static final List<dynamic> ontap = [
    Get.to(() => Huawei()),
    Get.to(() => Iphone()),
    Get.to(() => Lenovo()),
    Get.to(() => Samsung()),
    Get.to(() => Oppo()),
    Get.to(() => Realme()),
    Get.to(() => Tecno()),
  ];
}