import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CustomContainer extends GetWidget<SettingsViewModel> {
  const CustomContainer(
      {required this.color,
      required this.ontap,
      required this.text,
      required this.icon,
      Key? key})
      : super(key: key);

  final Function ontap;
  final String text;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => ontap(),
      child: Container(
        alignment: Alignment.centerLeft,
        height: size.height / 10,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: GetBuilder<ThemesViewModel>(
          builder: (controll) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText2(
                text: text,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 35,
              )
            ],
          ),
        ),
      ),
      
    );
  }
}
