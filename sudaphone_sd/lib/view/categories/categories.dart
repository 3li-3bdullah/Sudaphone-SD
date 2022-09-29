import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
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
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Categories extends GetWidget<ThemesViewModel> {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Categories", underLineWidget: 70),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        child: GetBuilder<ThemesViewModel>(
          builder: (controller) => GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/samsung1.jpg" :"assets/images/category/samsung.png",
                text: "Samsung",
                onTap: () {
                  Get.to(() => const Samsung(),duration: const Duration(milliseconds: 50),
                      transition: Transition.zoom, curve: Curves.bounceInOut);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/huawei1.jpg" :"assets/images/category/huawei.png",
                text: "Huawei",
                onTap: () {
                  Get.to(() => const Huawei(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/iphone1.jpg" : "assets/images/category/apple.jpg",
                text: "Iphone",
                onTap: () {
                  Get.to(() => const Iphone(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/oppo1.jpg" : "assets/images/category/oppo.png",
                text: "Oppo",
                onTap: () {
                  Get.to(() => const Oppo(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/xiaomi1.jpg" : "assets/images/category/xiaomi.png",
                text: "Xiaomi",
                onTap: () {
                  Get.to(() => const Xiaomi(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/lenovo1.jpg" : "assets/images/category/lenovo.png",
                text: "Lenovo",
                onTap: () {
                  Get.to(() => const Lenovo(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/realme1.png" : "assets/images/category/realme.png",
                text: "Realme",
                onTap: () {
                  Get.to(() => const Realme(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/tecno1.jpg" : "assets/images/category/tecno.png",
                text: "Tecno",
                onTap: () {
                  Get.to(() => const Tecno(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/vivo1.jpg" :"assets/images/category/vivo.jpg",
                text: "Vivo",
                onTap: () {
                  Get.to(() => const Vivo(),duration: const Duration(milliseconds: 50),);
                },
              ),
              CategoriesCard(
                imageCat: controller.theme == ThemeMode.dark ? "assets/images/category/nokia1.jpg" : "assets/images/category/nokia.png",
                text: "Nokia",
                onTap: () {
                  Get.to(() => const Nokia(),duration: const Duration(milliseconds: 50),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
