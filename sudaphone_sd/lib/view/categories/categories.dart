import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories/phones/huawei.dart';
import 'package:sudaphone_sd/view/categories/phones/iphone.dart';
import 'package:sudaphone_sd/view/categories/phones/lenovo.dart';
import 'package:sudaphone_sd/view/categories/phones/nokia.dart';
import 'package:sudaphone_sd/view/categories/phones/oppo.dart';
import 'package:sudaphone_sd/view/categories/phones/realme.dart';
import 'package:sudaphone_sd/view/categories/phones/samsung.dart';
import 'package:sudaphone_sd/view/categories/phones/tecno.dart';
import 'package:sudaphone_sd/view/categories/phones/vivo.dart';
import 'package:sudaphone_sd/view/categories/phones/xiaomi.dart';
import 'package:sudaphone_sd/view/categories/components/categories_card.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
         text: "Categories",
         textAlign: TextAlign.center,
         fontSize: 20,
         fontWeight: FontWeight.normal,
        ),
         leading: const Leading(),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: [
            CategoriesCard(
              imageCat: "assets/images/category/samsung.png",
              text: "Samsung",
              onTap: () {
                Get.to(() => const Samsung(),duration: const Duration(milliseconds: 50),
                    transition: Transition.zoom, curve: Curves.bounceInOut);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/huawei.png",
              text: "Huawei",
              onTap: () {
                Get.to(() => const Huawei(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/apple.jpg",
              text: "Iphone",
              onTap: () {
                Get.to(() => const Iphone(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/oppo.png",
              text: "Oppo",
              onTap: () {
                Get.to(() => const Oppo(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/xiaomi.png",
              text: "Xiaomi",
              onTap: () {
                Get.to(() => const Xiaomi(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/lenovo.png",
              text: "Lenovo",
              onTap: () {
                Get.to(() => const Lenovo(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/realme.png",
              text: "Realme",
              onTap: () {
                Get.to(() => const Realme(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/tecno.png",
              text: "Tecno",
              onTap: () {
                Get.to(() => const Tecno(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/vivo.jpg",
              text: "Vivo",
              onTap: () {
                Get.to(() => const Vivo(),duration: const Duration(milliseconds: 50),);
              },
            ),
            CategoriesCard(
              imageCat: "assets/images/category/nokia.png",
              text: "Nokia",
              onTap: () {
                Get.to(() => const Nokia(),duration: const Duration(milliseconds: 50),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
