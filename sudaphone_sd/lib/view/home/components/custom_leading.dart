import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerViewModel>(
      builder: (controller) => IconButton(
        onPressed: () {
          return controller.value == 0.0
              ? controller.valueOne()
              : controller.valueZero();
        },
        iconSize: 30,
        icon: GetBuilder<ThemesViewModel>(
                builder: (control) => Icon(
                 controller.value == 0.0 ? Icons.menu : Icons.menu_open_outlined ,
                  color: control.theme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
      ),
    );
  }
}
