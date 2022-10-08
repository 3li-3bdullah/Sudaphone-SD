
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/categories/categories.dart';
import 'package:sudaphone_sd/view/posts/posts.dart';
import 'package:sudaphone_sd/view/home/screen.dart';
import 'package:sudaphone_sd/view/settings/settings.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';


// ignore: must_be_immutable
class BottomNavigation extends GetWidget<ScreenViewModel> {
  BottomNavigation({Key? key}) : super(key: key);
  final List<Widget> screens = [
      Screen(),
    const Categories(),
     const Posts(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScreenViewModel>(
      init: ScreenViewModel(),
      builder: (controller) => Scaffold(
        bottomNavigationBar: GetBuilder<ThemesViewModel>(
          builder:(control) => BottomNavyBar(
            selectedIndex: controller.activeIndex,
            showElevation: true,
            backgroundColor: control.theme == ThemeMode.dark ? kDarkColor : Colors.white,
            onItemSelected: (index) {
              controller.onSelectedItem(index);
            },
            items: [
              BottomNavyBarItem(
                  icon: const Image(
                    image: AssetImage("assets/images/icons/home.png"),
                    color: Colors.red,
                    height: 25,
                    width: 25,
                  ),
                  title: const Text("Home"),
                  activeColor: Colors.red),
              BottomNavyBarItem(
                  icon: const Image(
                    image: AssetImage("assets/images/icons/category.png"),
                    color: Colors.purpleAccent,
                    height: 25,
                    width: 25,
                  ),
                  title: const Text("Categories"),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: const Image(
                    image: AssetImage("assets/images/icons/add.png"),
                    color: Colors.pink,
                    height: 25,
                    width: 25,
                  ),
                  title: const Text("Posts"),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: const Image(
                    image: AssetImage("assets/images/icons/settings.png"),
                    color: Colors.blue,
                    height: 25,
                    width: 25,
                  ),
                  title: const Text("Settings"),
                  activeColor: Colors.blue),
            ],
          ),
        ),
        body: screens[controller.activeIndex],
      ),
    );
  }
}
