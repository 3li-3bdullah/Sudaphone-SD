import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/post.dart';
import 'package:sudaphone_sd/view/screen.dart';
import 'package:sudaphone_sd/view/settings.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

// ignore: must_be_immutable
class BottomNavigation extends GetWidget<ScreenViewModel> {
  BottomNavigation({Key? key}) : super(key: key);
  final List<Widget> screens = [
    Screen(),
    const Categories(),
    const Post(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetX<ScreenViewModel>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: controller.activeIndex!.value,
            showElevation: true,
            onItemSelected: (index) {
              controller.activeIndex!.value = index;
            },
            items: [
              BottomNavyBarItem(
                  icon: const Icon(Icons.apps),
                  title: const Text("Home"),
                  activeColor: Colors.red),
              BottomNavyBarItem(
                  icon: const Icon(Icons.category),
                  title: const Text("Categories"),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: const Icon(Icons.post_add),
                  title: const Text("Posts"),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: const Icon(Icons.settings),
                  title: const Text("Settings"),
                  activeColor: Colors.blue),
            ]),
        body: screens[controller.activeIndex!.value],
      ),
    );
  }
}
