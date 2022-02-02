// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sudaphone/view_model/auth_view_model.dart';

// class CategoriesCarousel extends GetWidget<AuthViewModel> {
//    CategoriesCarousel(
//     { required this.productImage1,
//       required this.productImage2,
//        required this.productImage3});
//    String productImage1,productImage2,productImage3;
//   List<String> productImages=[
//     productImge1,
//     productImage2,
//     productImage3
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double halfHeight = height / 2;
//     double increase = halfHeight / 4;
//     return SafeArea(
//         child: Padding(
//       padding: const EdgeInsets.only(top: 30),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [CarouselSlider.builder(
//             itemCount: productImages.length,
//             itemBuilder:,
//             options:CarouselOptions(),
//           )]),
//     ));
//   }
// }
