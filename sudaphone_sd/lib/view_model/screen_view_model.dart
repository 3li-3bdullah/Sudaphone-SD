import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenViewModel extends GetxController {
  //Declare Variables
  RxInt? activeIndex = 0.obs;
  RxDouble value = 0.0.obs;
  CollectionReference<Map<String, dynamic>> carouselFire = FirebaseFirestore.instance.collection("carousel");
  CollectionReference<Map<String, dynamic>> phonesCategory = FirebaseFirestore.instance.collection("phonesCategory");
  FirebaseFirestore drawerData = FirebaseFirestore.instance;
  Size size = MediaQuery.of(Get.context!).size;
  PageController controllerCarousel =
      PageController(viewportFraction: 0.8, keepPage: true);
  final List<MaterialColor> colors = const [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.pink,
    Colors.blue,
    Colors.amber,
    Colors.purple,
    Colors.brown,
  ];
   final List<String> docOne = const [
    "allHuawei",
    "allIphone",
    "allOppo",
    "allRealme",
    "allXiaomi",
    "allSamsung",
    "allTecno",
    "allNokia",
    "allVivo",
    "allLenovo"
  ];
  final List<String> collectionTwo = const [
    "huawei",
    "iphone",
    "oppo",
    "realme",
    "xiaomi",
    "samsung",
    "tecno",
    "nokia",
    "vivo",
    "lenovo"
  ];



  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }
 
}
