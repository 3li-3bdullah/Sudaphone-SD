import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/screen_pages/data_search.dart';
import 'package:sudaphone_sd/view/screen_pages/drawer_child.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_images_carousel.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view/screen_widgets/carousel_most_used.dart';
import 'package:sudaphone_sd/view/screen_widgets/categories_title.dart';
import 'package:sudaphone_sd/view/screen_widgets/last_product.dart';
import 'package:sudaphone_sd/view/screen_widgets/screen_lists.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class Screen extends GetWidget<ScreenViewModel> {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double halfheight = size.height / 2;
    double partOfHeight = size.height / 8;
    return ElasticDrawer(
      mainColor: Colors.transparent,
      drawerColor: Colors.transparent,
      mainChild: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sudaphone",
        home: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sudaphone SD",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: const Image(
                        image: AssetImage("assets/images/icons/search.png"),
                        height: 22,
                        width: 22,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                    ),
                  ),
                ],
                leading: GetX<MyDrawerViewModel>(
                 builder:  (controller) => IconButton(
                    onPressed: () {
                      return controller.value.value == 0.0
                          ? controller.valueOne()
                          : controller.valueZero();
                    },
                    icon: controller.value.value == 0.0
                        ? const Icon(
                            Icons.menu,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.menu_open_outlined,
                            color: Colors.black,
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
                    child: GridTile(
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        controller: controller.controllerCarousel,
                        itemCount: controller.imagesCarousel.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: halfheight,
                            width: size.width,
                            child: BuildImagesCarousel(
                                imagesCarousel:
                                    controller.imagesCarousel[index]),
                          );
                        },
                      ),
                      footer: Container(
                        height: 60,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            BuildIndicatorCarousel(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CategoriesTitle(
                    text: "Categories",
                    text2: "more",
                    press: () {
                      Get.to(() => const Categories(),
                          duration: const Duration(milliseconds: 50),
                          transition: Transition.zoom);
                    },
                  ),
                  SizedBox(
                    height: 120,
                    //I've removed Expanded
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ScreenLists.imagesCateLogo.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 90,
                          width: 70,
                          margin: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              ScreenLists.ontap[index];
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ScreenLists.imagesCateLogo[index]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    ScreenLists.text[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ), 
                  CategoriesTitle(
                      text: "Most Used", text2: "more", press: () {}),
                      const SizedBox(height: 10,),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 3,
                  //   width: MediaQuery.of(context).size.height / 3,
                  //   child: const CarouselMostUsed()),
                 const SizedBox(height: 5,),
                  CategoriesTitle(
                    text: "Lastest Phones",
                    text2: "< Pull",
                     press: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 +
                        MediaQuery.of(context).size.height / 8,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: [
                        LastProduct(
                            imageProduct: "assets/images/product/huawei.jpg",
                            text: "Huawei Mate 40 Pro : 1000\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/samsung.jpg",
                            text: "Samsung S20 Ultra : 999\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/iphone.jpg",
                            text: "iPhone 12 pro max : 1170\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/xiaomi.jpg",
                            text: "Xiaomi Mi 10T  : 950\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/oppo.jpg",
                            text: "Oppo F17 Pro : 975\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/lenovo.jpg",
                            text: "Lenovo K12 Pro : 800\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/nokia.jpg",
                            text: "Nokia G300 : 750\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/realme.jpg",
                            text: "Realme race teaser : 900\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/tecno.jpg",
                            text: "Tecno Spark6 : 850\$",
                            onTap: () {}),
                        LastProduct(
                            imageProduct: "assets/images/product/vivo.jpeg",
                            text: "Vivo Y53s : 950\$",
                            onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawerChild: const DrawerChild(),
    );
  }
}
