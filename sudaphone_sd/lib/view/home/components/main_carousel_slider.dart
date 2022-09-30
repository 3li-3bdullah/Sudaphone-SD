import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/home/components/build_images_carousel.dart';
import 'package:sudaphone_sd/view/home/components/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class MainCarouselSlider extends GetWidget<ScreenViewModel> {
  const MainCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height / 2,
          width: Get.width,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            allowImplicitScrolling: true,
            controller: controller.controllerCarousel,
            itemCount: controller.listMainCarousel!.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: Get.height / 2,
                width: Get.width,
                child: BuildImagesCarousel(
                    imagesCarousel:
                        controller.listMainCarousel![index].imageUrl),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: BuildIndicatorCarousel(
            imageLength: controller.listMainCarousel!.length,
          ),
        ),
      ],
    );
  }
}
