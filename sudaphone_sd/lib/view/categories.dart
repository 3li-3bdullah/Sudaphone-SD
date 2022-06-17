import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories_pages/huawei.dart';
import 'package:sudaphone_sd/view/categories_pages/iphone.dart';
import 'package:sudaphone_sd/view/categories_pages/lenovo.dart';
import 'package:sudaphone_sd/view/categories_pages/nokia.dart';
import 'package:sudaphone_sd/view/categories_pages/oppo.dart';
import 'package:sudaphone_sd/view/categories_pages/realme.dart';
import 'package:sudaphone_sd/view/categories_pages/samsung.dart';
import 'package:sudaphone_sd/view/categories_pages/tecno.dart';
import 'package:sudaphone_sd/view/categories_pages/vivo.dart';
import 'package:sudaphone_sd/view/categories_pages/xiaomi.dart';
import 'package:sudaphone_sd/view/categories_widgets/categories_card.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///ThemeData(fontFamily: 'Cairo');

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Categories",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),

          /// drawer: MyDrawer(),
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
                    Get.to(() => const Samsung(),
                        transition: Transition.zoom, curve: Curves.bounceInOut);
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/huawei.png",
                  text: "Huawei",
                  onTap: () {
                    Get.to(() => const Huawei());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/apple.jpg",
                  text: "Iphone",
                  onTap: () {
                    Get.to(() => const Iphone());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/oppo.png",
                  text: "Oppo",
                  onTap: () {
                    Get.to(() => const Oppo());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/xiaomi.png",
                  text: "Xiaomi",
                  onTap: () {
                    Get.to(() => const Xiaomi());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/lenovo.png",
                  text: "Lenovo",
                  onTap: () {
                    Get.to(() => const Lenovo());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/realme.png",
                  text: "Realme",
                  onTap: () {
                    Get.to(() => const Realme());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/tecno.png",
                  text: "Tecno",
                  onTap: () {
                    Get.to(() => const Tecno());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/vivo.jpg",
                  text: "Vivo",
                  onTap: () {
                    Get.to(() => const Vivo());
                  },
                ),
                CategoriesCard(
                  imageCat: "assets/images/category/nokia.png",
                  text: "Nokia",
                  onTap: () {
                    Get.to(() => const Nokia());
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
