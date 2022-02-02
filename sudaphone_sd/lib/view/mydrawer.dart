import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/aboutapp.dart';
import 'package:sudaphone_sd/view/bottom_navigation.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_listtile.dart';
import 'package:sudaphone_sd/view/settings.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
class MyDrawer extends GetWidget<ScreenViewModel> {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade900],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          SafeArea(
            child: Container(
              width: 220.0,
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                DrawerHeader(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/images/slider/ali.jpg"),
                    ),
                    SizedBox(height: 10),
                    CustomText(
                        text: "Ali Abdullah",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.normal),
                    CustomText(
                        text: "SudaphoneSD@gamil.com",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    SizedBox(height: 10),
                  ],
                )),
                Expanded(
                  child: ListView(
                    children: [
                      BuildListTile(
                        text: "Home",
                        onTap: () {
                          Get.offAll(() => const MyDrawer(),
                              transition: Transition.rightToLeftWithFade);
                        },
                        icon: Icons.home,
                      ),
                      BuildListTile(
                        text: "Categories",
                        onTap: () {
                          Get.to(() => const Categories(),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 100));
                        },
                        icon: Icons.category,
                      ),
                      // BuildListTile(
                      //   text: "Posts",
                      //   onTap: () {
                      //     Get.to(() => const Post(),
                      //         transition: Transition.leftToRightWithFade);
                      //   },
                      //   icon: Icons.post_add,
                      // ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      BuildListTile(
                        text: "About",
                        onTap: () {
                          Get.to(() => const AboutApp(),
                              transition: Transition.upToDown);
                        },
                        icon: Icons.info,
                      ),
                      BuildListTile(
                        text: "Settings",
                        onTap: () {
                          Get.to(() => const Settings(),
                              transition: Transition.downToUp);
                        },
                        icon: Icons.settings,
                      ),
                      BuildListTile(
                          text: "Logout",
                          onTap: () {
                            // Get.to(() => LogIn());
                          },
                          icon: Icons.login),

                      /// i will Start this when i will try use firebase-------
                      // BuildListTile(
                      //   text: "تسجيل الخروج",
                      //   onTap: () {
                      //     Get.defaultDialog(
                      //         title: "Why :( ,Are you sure dear ?!",
                      //         middleText:
                      //             "If you logoff, you will stop receiving our services.",
                      //         titleStyle: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 24,
                      //             fontWeight: FontWeight.bold),
                      //         middleTextStyle: TextStyle(
                      //             color: Colors.grey.shade800, fontSize: 18),
                      //         textConfirm: "نعم",
                      //         textCancel: "لا",
                      //         buttonColor: Colors.purple,
                      //         confirmTextColor: Colors.white,
                      //         cancelTextColor: Colors.green,
                      //         onConfirm: () {},
                      //         onCancel: () {
                      //           Get.back();
                      //         });
                      //   },
                      //   icon: Icons.exit_to_app,
                      // ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          GetX<ScreenViewModel>(
            builder: (controller) => TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: controller.value.value),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                builder: (_, double val, __) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: (Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(
                          0,
                          3,
                          200 *
                              val) //This will allows us to translate the screen
                      ..rotateY((pi / 6) * val)),
                    child: BottomNavigation(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}