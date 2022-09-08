import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
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
import 'package:sudaphone_sd/view/home/best_gaming_phones.dart';
import 'package:sudaphone_sd/view/home/data_search.dart';
import 'package:sudaphone_sd/view/home/favorite.dart';
import 'package:sudaphone_sd/view/home/components/build_images_carousel.dart';
import 'package:sudaphone_sd/view/home/components/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view/home/components/categories_title.dart';
import 'package:sudaphone_sd/view/home/components/custom_listtile.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Screen extends GetWidget<ScreenViewModel> {
  const Screen({Key? key}) : super(key: key);
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
              title: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Sudaphone SD",
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                ),
              ),
              elevation: 0,
              actions: [
                GetBuilder<ThemesViewModel>(
                  builder: (control) => Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: Image(
                        image:
                            const AssetImage("assets/images/icons/search.png"),
                        height: 22,
                        width: 22,
                        color: control.theme == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => controller.isMainCarouselHasData.value
                        ? Center(
                            child: Lottie.asset("assets/lotties/loading.json"),
                          )
                        : GridTile(
                            footer: Container(
                              height: 60,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildIndicatorCarousel(
                                    imageLength:
                                        controller.listMainCarousel!.length,
                                  ),
                                ],
                              ),
                            ),
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
                  ),
                ),
                const SizedBox(height: 20),
                CategoriesTitle(
                  text: "Categories",
                  press: () {
                    Get.to(() => const Categories(),
                        duration: const Duration(milliseconds: 50),
                        transition: Transition.zoom);
                  },
                ),
                const SizedBox(height: 10),

                /// Here i should remove the comment and see what's wrong
                // Obx(
                //   () =>
                SizedBox(
                    height: size.height / 2.7,
                    width: size.width,
                    //I've removed Expanded
                    child: Obx(
                      () => controller.isCateHasData.value
                          ? Center(
                              child:
                                  Lottie.asset("assets/lotties/loading.json"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.listCategories!.length,
                              itemBuilder: (context, index) {
                                return CustomListTile(
                                  logo: controller.listCategories![index].logo,
                                  videoUrl: controller
                                      .listCategories![index].videoUrl,
                                  thumbinalUrl: controller
                                      .listCategories![index].thumbinalUrl,
                                  onTap: () {
                                    switch (controller
                                        .listCategories![index].name) {
                                      case "Samsung":
                                        Get.to(() => const Samsung(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Huawei":
                                        Get.to(() => const Huawei(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Iphone":
                                        Get.to(() => const Iphone(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Realme":
                                        Get.to(() => const Realme(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Oppo":
                                        Get.to(() => const Oppo(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Xiaomi":
                                        Get.to(() => const Xiaomi(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Lenovo":
                                        Get.to(() => const Lenovo(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Tecno":
                                        Get.to(() => const Tecno(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Nokia":
                                        Get.to(() => const Nokia(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      case "Vivo":
                                        Get.to(() => const Vivo(),
                                            duration: const Duration(
                                                milliseconds: 50),
                                            transition: Transition.zoom);
                                        break;
                                      default:
                                        Get.to(() => const Categories());
                                    }
                                  },
                                  text: controller.listCategories![index].name,
                                );
                              }),
                    )),
                // ),
                CategoriesTitle(text: "Popular", press: () {}),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection("carousel")
                        .doc("popular")
                        .collection("carousel")
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, __) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(snapshot
                                        .data?.docs[index]
                                        .data()['imageUrl']),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${snapshot.data!.docs[index].data()['name']}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            initialPage: 0,
                            autoPlay: true,
                            scrollDirection: Axis.horizontal,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 200),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Lottie.asset("assets/lotties/loading.json"),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Oops!",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: snapshot.error.toString(),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CategoriesTitle(
                    text: "Best Gaming Phones",
                    press: () {
                      Get.to(() => const BestGamingPhones());
                    }),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future:
                        FirebaseFirestore.instance.collection("forGames").get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, __) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => LastProducDetails(
                                    collection: "forGames",
                                    phoneDoc: snapshot.data!.docs[index].id));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data?.docs[index]
                                          .data()['imageUrl']),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText2(
                                        text:
                                            "${snapshot.data!.docs[index].data()['name']}",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      CustomText2(
                                        text:
                                            "${snapshot.data!.docs[index].data()['ram']}",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      CustomText2(
                                        text:
                                            "${snapshot.data!.docs[index].data()['battery']}",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            initialPage: 0,
                            autoPlay: true,
                            scrollDirection: Axis.horizontal,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 200),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Lottie.asset("assets/lotties/loading.json"),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Oops!",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: snapshot.error.toString(),
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GetBuilder<ThemesViewModel>(
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: controller.theme == ThemeMode.dark
                                  ? Colors.white12
                                  : Colors.black12,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomText(
                            text: "Last Products",
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left,
                          ),
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
                            child: Lottie.asset("assets/lotties/loading.json"),
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
                                    Image.network(controller
                                        .listOfLastProducts![index].imageUrl),
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: CustomText2(
                                            text: controller
                                                .listOfLastProducts![index]
                                                .name,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            color: Colors.white),
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
// ListView(scrollDirection: Axis.horizontal, children: [
//   CustomListTile(
//     image: "assets/images/logo/huawei.png",
//     onTap: () {
//       Get.to(() => const Huawei(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Huawei",
//   ),
//   CustomListTile(
//     image: "assets/images/logo/iphone.jpg",
//     onTap: () {
//       Get.to(() => const Iphone(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Iphone",
//   ),
//   CustomListTile(
//     image: "assets/images/logo/lenovo.png",
//     onTap: () {
//       Get.to(() => const Lenovo(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Lenovo",
//   ),
//   CustomListTile(
//       image: "assets/images/logo/samsung.jpg",
//       onTap: () {
//         Get.to(() => const Samsung(),
//             transition: Transition.zoom);
//       },
//       text: "Samsung"),
//   CustomListTile(
//     image: "assets/images/logo/oppo.jpg",
//     onTap: () {
//       Get.to(() => const Oppo(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Oppo",
//   ),
//   CustomListTile(
//     image: "assets/images/logo/realme.png",
//     onTap: () {
//       Get.to(() => const Realme(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Realme",
//   ),
//   CustomListTile(
//     image: "assets/images/logo/tecno.png",
//     onTap: () {
//       Get.to(() => const Tecno(),
//           duration: const Duration(milliseconds: 50),
//           transition: Transition.zoom);
//     },
//     text: "Tecno",
//   ),
// ]),
