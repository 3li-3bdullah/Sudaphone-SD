import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Leading extends GetWidget<ThemesViewModel> {
  const Leading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
          builder: (control) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color:
                  control.theme == ThemeMode.dark ? Colors.white : kDarkColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        );
  }
}