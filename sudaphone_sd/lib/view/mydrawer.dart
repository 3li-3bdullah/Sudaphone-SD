import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/aboutapp.dart';
import 'package:sudaphone_sd/view/bottom_navigation.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/posts.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_listtile.dart';
import 'package:sudaphone_sd/view/settings.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';

class MyDrawer extends GetWidget<MyDrawerViewModel> {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink.shade400, Colors.purple.shade900],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Column(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
              child: Column(
                children: [
                  // DrawerHeader(
                  //   curve: Curves.linearToEaseOut,
                  //   child: 
                  //       CircleAvatar(
                  //         radius: 50,
                  //         backgroundImage:
                  //             AssetImage("assets/images/slider/ali1.jpg"),
                  //       ),
                      
                  // ),
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(150))
                    ),
                    child: const Center(
                      child: Image(image: AssetImage("assets/images/slider/ali1.jpg" ),fit:BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<MyDrawerViewModel>(
                    builder:((controller) => CustomText(
                        text: "${controller.name}",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.normal)
                  ),),
                  //  const SizedBox(height: 8),
                  // CustomText(
                  //     text: "SudaphoneSD@gamil.com",
                  //     textAlign: TextAlign.center,
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.normal),

                  const SizedBox(height: 15),
                  BuildListTile(
                      text: "Home",
                      onTap: () {
                        Get.offAll(() => const MyDrawer(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      icon: "assets/images/icons/home.png"),
                  BuildListTile(
                    text: "Categories",
                    onTap: () {
                      Get.to(() => const Categories(),
                          transition: Transition.zoom);
                    },
                    icon: "assets/images/icons/category.png",
                  ),
                  BuildListTile(
                    text: "Posts",
                    onTap: () {
                      Get.to(() => const Posts(),
                          transition: Transition.leftToRightWithFade);
                    },
                    icon: "assets/images/icons/add.png",
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  BuildListTile(
                    text: "About",
                    onTap: () {
                      Get.to(() =>  AboutApp(),
                          transition: Transition.upToDown);
                    },
                    icon: "assets/images/icons/info.png",
                  ),
                  BuildListTile(
                    text: "Settings",
                    onTap: () {
                      Get.to(() => Settings(), transition: Transition.downToUp);
                    },
                    icon: "assets/images/icons/settings.png",
                  ),

                  /// i will Start this when i will try use firebase-------
                  BuildListTile(
                    text: "Logout",
                    onTap: () {
                      Get.defaultDialog(
                        title: "Why :( ,Are you sure dear ?!",
                        middleText:
                            "If you logout, =( you will stop receiving our services.",
                        titleStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        middleTextStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 18),
                        textConfirm: "Yes",
                        textCancel: "No",
                        buttonColor: Colors.purple,
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.green,
                        onConfirm: () {},
                        onCancel: () {
                          Get.back();
                        },
                      );
                    },
                    icon: "assets/images/icons/logout.png",
                  ),
                ],
              ),
            ),
          GetX<MyDrawerViewModel>(
            builder: (controller) => TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: controller.value.value),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              builder: (_, double val, __) {
                return Transform(
                  alignment: Alignment.center,
                  transform: (Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3,
                        200 * val) //This will allows us to translate the screen
                    ..rotateY((pi / 6) * val)),
                  child: BottomNavigation(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
