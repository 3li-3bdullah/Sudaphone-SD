import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CategoriesCard extends GetWidget<ThemesViewModel> {
  // ignore: use_key_in_widget_constructors
  const CategoriesCard({
    required this.imageCat,
    required this.onTap,
  });
  final String imageCat;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: controller.theme == ThemeMode.dark ? Colors.black38 : Colors.black12,
                   blurRadius: 6.0, offset: const Offset(8, 8)),
             const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 6.0,
                  offset: Offset(-8, -8)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: GetBuilder<ThemesViewModel>(
              builder: (control) => Card(
                color: control.theme == ThemeMode.light
                    ? Colors.white
                    : kDarkColor,
                child: SizedBox(
                  height: 170,
                  child: Image.asset(
                    imageCat,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
