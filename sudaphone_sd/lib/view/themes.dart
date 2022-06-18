import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Themesx extends GetWidget<ThemesViewModel> {
  const Themesx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const CustomText(
        text: "Dark mode",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      trailing: CupertinoSwitch(
        value: Get.isDarkMode,
        onChanged: (value) {
          if (Get.isDarkMode) {
            controller.changeThemeMode(ThemeMode.light);
            controller.saveTheme(false);
          } else {
            controller.changeThemeMode(ThemeMode.dark);
            controller.saveTheme(true);
          }
        },
      ),
    );
  }
}
