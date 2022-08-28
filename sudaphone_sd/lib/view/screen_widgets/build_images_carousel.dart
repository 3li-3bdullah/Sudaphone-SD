import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class BuildImagesCarousel extends StatelessWidget {
  const BuildImagesCarousel({Key? key, required this.imagesCarousel})
      : super(key: key);
  final String imagesCarousel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      builder: (controller) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        color: controller.theme == ThemeMode.dark ? kDarkColor : Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                imagesCarousel,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
