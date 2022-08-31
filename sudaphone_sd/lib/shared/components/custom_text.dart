import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CustomText extends GetWidget<ThemesViewModel> {
  // ignore: prefer_const_constructors_in_immutables
    CustomText({Key? key, 
   required this.text,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
            builder:(contorller) =>  Text(
        text,
        textAlign: textAlign!,
        style:
            TextStyle(color: controller.theme == ThemeMode.dark ? Colors.white : kDarkColor ,fontSize: fontSize!, fontWeight: fontWeight),
      ),
    );
  }
}