import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/constants.dart';
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
        decoration: BoxDecoration(
          color: controller.theme == ThemeMode.dark ? kDarkColor : kBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/loader.gif',
            image: imagesCarousel,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
