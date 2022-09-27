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
import 'package:sudaphone_sd/view/home/best_gaming_phones.dart';
import 'package:sudaphone_sd/view/home/components/build_images_carousel.dart';
import 'package:sudaphone_sd/view/home/components/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view/home/components/categories_title.dart';
import 'package:sudaphone_sd/view/home/components/custom_listtile.dart';
import 'package:sudaphone_sd/view/home/data_search.dart';
import 'package:sudaphone_sd/view/home/favorite.dart';
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
                      Container(
                        height: 7,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const CustomText2(
                        text: "Sudaphone SD",
                        color: Colors.black,
                        fontSize: 20,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        height: 7,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1,),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child:
                    //  Container(
                    //   height: 5,
                    //   width: 70,
                    //   margin: const EdgeInsets.only(left: 60),
                    //   decoration: const BoxDecoration(
                    //     color: Colors.brown,
                    //     borderRadius: BorderRadius.all(Radius.circular(10))
                    //   ),
                    // ),
                  // )
                ],
              ),
              elevation: 0,
              actions: [
                GetBuilder<ThemesViewModel>(
                  builder: (control) => Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: Image(
                        image: const AssetImage("assets/images/search.png"),
                        height: 28,
                        width: 28,
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
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => controller.isMainCarouselHasData.value
                            ? Center(
                                child: Image.asset("assets/images/loader.gif"),
                              )
                            : PageView.builder(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BuildIndicatorCarousel(
                        imageLength: controller.listMainCarousel!.length,
                      ),
                    ),
                  ],
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
                 SizedBox(
                      height: size.height / 2.7,
                      width: size.width,
                      child: Obx(
                        () => controller.isCateHasData.value
                            ? Center(
                                child:
                                    Image.asset("assets/images/loader.gif"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.listCategories!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:6),
                                    child: CustomListTile(
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
                                    ),
                                  );
                                },),
                      ),),
                CategoriesTitle(
                    text: "Popular", press: () {}, underLineWidget: 50),
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
                            return SizedBox(
                              width: size.width,
                              height: size.height / 4,
                              child: Column(children: [
                                Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loader.gif',
                                      image: snapshot.data?.docs[index]
                                          .data()['imageUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${snapshot.data!.docs[index].data()['name']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
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
                          child: Image.asset("assets/images/loader.gif"),
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
                // const SizedBox(
                //   height: 10,
                // ),
                CategoriesTitle(
                    text: "Best Gaming Phones",
                    underLineWidget: 160,
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
                                  //ToDo : Here i should added FadeImage......
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
                          child: Image.asset("assets/images/loader.gif"),
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
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText2(
                                text: "Last Products",
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 4,
                              width: 100,
                              alignment: Alignment.centerLeft,
                              decoration: const BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
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
