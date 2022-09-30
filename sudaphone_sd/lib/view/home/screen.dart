import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/categories/categories.dart';
import 'package:sudaphone_sd/view/categories/phones/huawei.dart';
import 'package:sudaphone_sd/view/categories/phones/iphone.dart';
import 'package:sudaphone_sd/view/categories/phones/lenovo.dart';
import 'package:sudaphone_sd/view/categories/phones/nokia.dart';
import 'package:sudaphone_sd/view/categories/phones/oppo.dart';
import 'package:sudaphone_sd/view/categories/phones/realme.dart';
import 'package:sudaphone_sd/view/categories/phones/samsung.dart';
import 'package:sudaphone_sd/view/categories/phones/tecno.dart';
import 'package:sudaphone_sd/view/categories/phones/vivo.dart';
import 'package:sudaphone_sd/view/categories/phones/xiaomi.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';
import 'package:sudaphone_sd/view/home/components/best_gaming_carousel.dart';
import 'package:sudaphone_sd/view/home/best_gaming_phones.dart';
import 'package:sudaphone_sd/view/home/components/categories_advertising.dart';
import 'package:sudaphone_sd/view/home/components/build_images_carousel.dart';
import 'package:sudaphone_sd/view/home/components/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view/home/components/categories_title.dart';
import 'package:sudaphone_sd/view/home/components/custom_listtile.dart';
import 'package:sudaphone_sd/view/home/data_search.dart';
import 'package:sudaphone_sd/view/home/favorite.dart';
import 'package:sudaphone_sd/view/home/components/popular_carousel.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Screen extends GetWidget<ScreenViewModel> {
  Screen({Key? key}) : super(key: key);
  final PublicData public_data = Get.find<PublicData>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double halfheight = size.height / 2;
    return ElasticDrawer(
      mainColor: Colors.transparent,
      drawerColor: Colors.transparent,
      mainChild: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Column(
                children: [
                  Row(
                    children: [
                      GetBuilder<ThemesViewModel>(
                        builder: (control) => Container(
                          height: 4,
                          width: 30,
                          decoration: BoxDecoration(
                            color: control.theme == ThemeMode.dark
                                ? Colors.grey
                                : Colors.brown,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: "Sudaphone SD",
                        fontSize: 20,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GetBuilder<ThemesViewModel>(
                        builder: (control) => Container(
                          height: 4,
                          width: 30,
                          decoration: BoxDecoration(
                            color: control.theme == ThemeMode.dark
                                ? Colors.grey
                                : Colors.brown,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              elevation: 0,
              actions: [
                GetBuilder<ThemesViewModel>(
                  builder: (control) => Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: Image(
                        image: const AssetImage("assets/images/search1.png"),
                        height: 45,
                        width: 45,
                        color: control.theme == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () => showSearch(context: context, delegate: DataSearch()),
                    ),
                  ),
                ),
              ],
              leading: GetX<MyDrawerViewModel>(
                builder: (controller) => IconButton(
                  onPressed: () {
                    return controller.value.value == 0.0
                        ? controller.valueOne()
                        : controller.valueZero();
                  },
                  iconSize: 30,
                  icon: controller.value.value == 0.0
                      ? GetBuilder<ThemesViewModel>(
                          builder: (control) => Icon(
                            Icons.menu,
                            color: control.theme == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                      : GetBuilder<ThemesViewModel>(
                          builder: (control) => Icon(
                            Icons.menu_open_outlined,
                            color: control.theme == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                ),
              ),
              floating: true,
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => controller.isMainCarouselHasData.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset('assets/images/loader.gif'),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                allowImplicitScrolling: true,
                                controller: controller.controllerCarousel,
                                itemCount: controller.listMainCarousel!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: halfheight,
                                    width: size.width,
                                    child: BuildImagesCarousel(
                                        imagesCarousel: controller
                                            .listMainCarousel![index].imageUrl),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: BuildIndicatorCarousel(
                                imageLength:
                                    controller.listMainCarousel!.length,
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                CategoriesTitle(
                  text: "Categories",
                  underLineWidget: 70,
                  press: () {
                    Get.to(() => const Categories(),
                        duration: const Duration(milliseconds: 50),
                        transition: Transition.zoom);
                  },
                ),
                const SizedBox(height: 10),
                const CategoriesAdvertising(),
                 CategoriesTitle(
                    text: "Popular", press: () {}, underLineWidget: 50),
                    const PopularCarousel(),
                    CategoriesTitle(
                    text: "Best Gaming Phones",
                    underLineWidget: 160,
                    press: () {
                      Get.to(() => const BestGamingPhones());
                    }),
                const SizedBox(
                  height: 10,
                ),
                const BestGamingCarousel(),
                const SizedBox(
                  height: 5,
                ),
                GetBuilder<ThemesViewModel>(
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText(
                                text: "Last Products",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GetBuilder<ThemesViewModel>(
                              builder: (control) => Container(
                                height: 4,
                                width: 100,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: control.theme == ThemeMode.dark
                                        ? Colors.grey
                                        : Colors.brown,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const SizedBox()
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: size.height / 2 + size.height / 7,
                  width: size.width,
                  child: Obx(
                    () => controller.loading.value
                        ? Center(
                            child: Image.asset("assets/images/loader.gif"),
                          )
                        : StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            itemCount: controller.listOfLastProducts!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => LastProducDetails(
                                      collection: "lastProducts",
                                      phoneDoc: controller
                                          .listOfLastProducts![index].docId));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/loader.gif',
                                        image: controller
                                            .listOfLastProducts![index]
                                            .imageUrl,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.brown.withOpacity(0.4),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: CustomText2(
                                              text: controller
                                                  .listOfLastProducts![index]
                                                  .name,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.center,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawerChild: const Favorite(),
    );
  }
}
