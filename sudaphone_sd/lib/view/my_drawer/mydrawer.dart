import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/about_app/aboutapp.dart';
import 'package:sudaphone_sd/view/bottom_nav_bar/bottom_navigation.dart';
import 'package:sudaphone_sd/view/categories/categories.dart';
import 'package:sudaphone_sd/view/feedback/feedbacks.dart';
import 'package:sudaphone_sd/view/my_drawer/components/build_listtile.dart';
import 'package:sudaphone_sd/view/no_internet_connection/no_internet_connection.dart';
import 'package:sudaphone_sd/view/posts/posts.dart';
import 'package:sudaphone_sd/view/posts/saved.dart';
import 'package:sudaphone_sd/view/settings/settings.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';


class MyDrawer extends GetWidget<MyDrawerViewModel> {
   const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.internetConnectionChecker.value == 1 ? Stack(
          children: [
            GetBuilder<ThemesViewModel>(
              builder: (controller) => Positioned(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: controller.theme == ThemeMode.dark
                        ? const LinearGradient(
                            colors: [Colors.black, Colors.grey],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.pink.shade400,
                              Colors.purple.shade900
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white12,
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.9,
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<PublicData>(
                    builder: (control) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                                radius: 65,
                                backgroundImage: NetworkImage(
                                  control.getProfileUrl.toString(),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText2(
                              text: control.getUserName.toString(),
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            CustomText2(
                                text: control.getEmail.toString(),
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
      
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        BuildListTile(
                            text: "Home",
                            onTap: () {
                              // Get.offAll(() => const MyDrawer(),
                              //     transition: Transition.rightToLeftWithFade);
                            },
                            icon: "assets/images/icons/home.png"),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        BuildListTile(
                          text: "Categories",
                          onTap: () {
                            Get.to(() => const Categories(),
                                transition: Transition.zoom);
                          },
                          icon: "assets/images/icons/category.png",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        BuildListTile(
                          text: "Saved",
                          onTap: () {
                            Get.to(() => const Saved(),
                                transition: Transition.zoom);
                          },
                          icon: "assets/images/icons/saved.png",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                          icon: "assets/images/icons/info.png",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        BuildListTile(
                          text: "Settings",
                          onTap: () {
                            Get.to(() => Setting(),
                                transition: Transition.downToUp);
                          },
                          icon: "assets/images/icons/settings.png",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        BuildListTile(
                          text: "Feedback",
                          onTap: () {
                            Get.to(() => const Feedbacks(),
                                transition: Transition.zoom);
                          },
                          icon: "assets/images/icons/feedback.png",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
      
                        /// i will Start this when i will try use firebase-------
                        BuildListTile(
                          text: "Logout",
                          onTap: () {
                            Get.defaultDialog(
                              title: "Why :( ? Are you sure dear ?!",
                              middleText:
                                  "If you logout =( , you will stop receiving our services.",
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
                              onConfirm: ()  {
                                 controller.logOut();
                              },
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
                ),
              ),
            ),
            
            GetX<MyDrawerViewModel>(
              builder: (controller) => TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: controller.value.value),
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
        ) : const NoInternetConnection(),
      ),
    );
  }
}
/* 
FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            future: controller.userInfo.doc(controller.uid).get(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                   return Column(
                                children: [
                                  const SizedBox(height: 20,),
                                   CircleAvatar(
                                     radius: 65,
                                     backgroundImage: NetworkImage(
                                          snapshot.data!.data()!['profileUrl']),
                                   ),
                                   const SizedBox(height: 10,),
                                  CustomText2(
                                    text:
                                        "${snapshot.data?.data()!['userName']}",
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText2(
                                      text:
                                          "${snapshot.data?.data()!['email']}",
                                      textAlign: TextAlign.center,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ],
                              );
                           
                              }else{
                                return Lottie.asset("assets/lotties/loading.json");
                              }
                            },
                          ),
*/