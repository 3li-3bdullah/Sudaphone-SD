import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories/categories.dart';
import 'package:sudaphone_sd/view/home/best_gaming_phones.dart';
import 'package:sudaphone_sd/view/home/components/best_gaming_carousel.dart';
import 'package:sudaphone_sd/view/home/components/categories_advertising.dart';
import 'package:sudaphone_sd/view/home/components/categories_title.dart';
import 'package:sudaphone_sd/view/home/components/custom_leading.dart';
import 'package:sudaphone_sd/view/home/components/last_products_carousel.dart';
import 'package:sudaphone_sd/view/home/components/main_carousel_slider.dart';
import 'package:sudaphone_sd/view/home/components/popular_carousel.dart';
import 'package:sudaphone_sd/view/home/components/screen_app_bar.dart';
import 'package:sudaphone_sd/view/home/components/search_icon.dart';
import 'package:sudaphone_sd/view/home/favorite.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class Screen extends GetWidget<ScreenViewModel> {
  Screen({Key? key}) : super(key: key);
  final PublicData public_data = Get.find<PublicData>();
  @override
  Widget build(BuildContext context) {
    return ElasticDrawer(
      mainColor: Colors.transparent,
      drawerColor: Colors.transparent,
      mainChild: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverAppBar(
              title: ScreenAppBar(),
              elevation: 0,
              actions: [
                SearchIcon()
              ],
              leading: CustomLeading(),
              floating: true,
            ),
          ],
          body: SingleChildScrollView( 
            child: Column(
              children: [
                const SizedBox(height: 20),
                Obx(
                  () => controller.isMainCarouselHasData.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('assets/images/loader.gif'),
                        )
                      : const MainCarouselSlider(),
                ),
                const SizedBox(height: 20),
                CategoriesTitle(
                  text: "Categories",
                  underLineWidget: 70,
                  showViewAll: true,
                  press: () {
                    Get.to(() => const Categories(),
                        duration: const Duration(milliseconds: 50),
                        transition: Transition.zoom);
                  },
                ),
                const SizedBox(height: 10),
                const CategoriesAdvertising(),
                CategoriesTitle(
                  text: "Popular",
                  press: () {},
                  underLineWidget: 50,
                  showViewAll: true,
                ),
                const PopularCarousel(),
                CategoriesTitle(
                    text: "Best Gaming Phones",
                    showViewAll: true,
                    underLineWidget: 160,
                    press: () {
                      Get.to(() => const BestGamingPhones());
                    }),
                const SizedBox(height: 10),
                const BestGamingCarousel(),
                const SizedBox(height: 5),
                CategoriesTitle(
                    underLineWidget: 70, press: () {}, text: "Last Products"),
                const SizedBox(height: 10),
                const LastProductsCarousel(),
              ],
            ),
          ),
        ),
      ),
      drawerChild: const Favorite(),
    );
  }
}
