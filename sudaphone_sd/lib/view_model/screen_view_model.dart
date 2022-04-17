import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenViewModel extends GetxController {
  //Declare Variables
  RxInt? activeIndex = 0.obs;
  RxDouble value = 0.0.obs;
  CollectionReference<Map<String, dynamic>> carouselFire = FirebaseFirestore.instance.collection("carousel");
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
  final List<String> imagesCarousel = [
    "assets/images/slider/1.png",
    "assets/images/slider/2.png",
    "assets/images/slider/3.jpg",
    "assets/images/slider/4.jpg",
    "assets/images/slider/5.jpg",
    "assets/images/slider/6.jpg",
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
