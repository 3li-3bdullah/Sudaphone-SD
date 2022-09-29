import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class BuildIndicatorCarousel extends GetWidget<ScreenViewModel> {
  const BuildIndicatorCarousel({required this.imageLength, Key? key})
      : super(key: key);
  final int imageLength;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      builder: (control) => SmoothPageIndicator(
        controller: controller.controllerCarousel,
        count: imageLength,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
            width: 32,
            height: 12,
            color: Colors.white,
            rotationAngle: 180,
            verticalOffset: -10,
            borderRadius: BorderRadius.circular(24),
            dotBorder: DotBorder(
              padding: 2,
              width: 2,
              color: control.theme == ThemeMode.dark ? Colors.brown : Colors.black26,
            ),
          ),
          dotDecoration: DotDecoration(
            width: 24,
            height: 12,
            color: Colors.white,
            dotBorder: DotBorder(
              padding: 2,
              width: 2,
              color: control.theme == ThemeMode.dark ? Colors.grey : Colors.black26,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(2)),
            //borderRadius: BorderRadius.circular(16),
            verticalOffset: 0,
          ),
          spacing: 6.0,
          // activeColorOverride: (i) => colors[i],
          inActiveColorOverride: (i) => controller.colors[i],
        ),
      ),
    );
  }
}
