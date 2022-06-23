import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Themesx extends GetWidget<ThemesViewModel> {
  const Themesx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      builder: (controller) => ListTile(
        title: const Text(
          "Dark mode",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: CupertinoSwitch(
          value: Get.isDarkMode,
          onChanged: (value) {
            log(value.toString());
            value = Get.isDarkMode;
            log("=============");
            log(value.toString());
            if (Get.isDarkMode) {
              controller.changeThemeMode(ThemeMode.dark);
              controller.saveTheme(true);
              log("dark theme");
            } else {
              controller.changeThemeMode(ThemeMode.light);
              controller.saveTheme(false);
              log("light theme");
            }
          },
        ),
      ),
    );
  }
}
