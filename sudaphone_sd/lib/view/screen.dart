import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/screen_widgets/categories_logo.dart';
import 'package:sudaphone_sd/view/screen_widgets/categories_title.dart';
import 'package:sudaphone_sd/view/screen_widgets/data_search.dart';
import 'package:sudaphone_sd/view/screen_widgets/last_product.dart';
import 'dart:core';

import 'package:sudaphone_sd/view_model/screen_view_model.dart';

// ignore: must_be_immutable
class Screen extends GetWidget<ScreenViewModel> {
  // final scontroller = Get.lazyPut(() => ScreenViewModel , fenix:true);

  Screen({Key? key}) : super(key: key);

  final controllerCarousel =
      PageController(viewportFraction: 0.8, keepPage: true);
  final List<MaterialColor> colors = const [
    Colors.green,
    Colors.red,
    Colors.indigo,
    Colors.pink,
    Colors.blue,
    Colors.amber,
  ];
  final List<String> imagesCarousel = [
    "assets/images/slider/1.png",
    "assets/images/slider/2.png",
    "assets/images/slider/3.jpg",
    "assets/images/slider/4.jpg",
    "assets/images/slider/5.jpg",
    "assets/images/slider/6.jpg",
  ];

  Widget buildImage(String imagesCarousel, int index, double width) =>
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                  imagesCarousel,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ));
  Widget buildIndicator() => SmoothPageIndicator(
        controller: controllerCarousel,
        count: imagesCarousel.length,
        effect: CustomizableEffect(
          activeDotDecoration: DotDecoration(
            width: 32,
            height: 12,
            color: Colors.white,
            rotationAngle: 180,
            verticalOffset: -10,
            borderRadius: BorderRadius.circular(24),
            dotBorder: const DotBorder(
              padding: 2,
              width: 2,
              color: Colors.black,
            ),
          ),
          dotDecoration: const DotDecoration(
            width: 24,
            height: 12,
            color: Colors.grey,
            dotBorder: DotBorder(
              padding: 2,
              width: 2,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(2)),
            //borderRadius: BorderRadius.circular(16),
            verticalOffset: 0,
          ),
          spacing: 6.0,
          // activeColorOverride: (i) => colors[i],
          inActiveColorOverride: (i) => colors[i],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double halfheight = size.height / 2;
    double partOfHeight = size.height / 8;
    return ElasticDrawer(
      mainColor: Colors.transparent,
      drawerColor: Colors.transparent,
      mainChild: MaterialApp(
          title: "Sudaphone",
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sudaphone SD",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.green),
                          onPressed: () {
                            showSearch(
                                context: context, delegate: DataSearch());
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart_outlined,
                              color: Colors.yellow.shade800),
                          onPressed: () {},
                        ),
                      ]),
                )
              ],
              leading: IconButton(
                onPressed: () {
                  return controller.value.value == 0.0
                      ? controller.valueOne()
                      : controller.valueZero();
                },
                icon: const Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            body: ListView(children: [
              SizedBox(
                height: halfheight,
                width: size.width,
                child: GridTile(
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    controller: controllerCarousel,
                    itemCount: imagesCarousel.length,
                    itemBuilder: (context, index) {
                      String imagesCar = imagesCarousel[index];
                      return SizedBox(
                          height: size.height / 2,
                          width: size.width,
                          child: buildImage(imagesCar, index, size.width));
                    },
                  ),
                  footer: Container(
                    height: 60,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
              CategoriesTitle(
                  text: "Categories",
                  text2: "more",
                  press: () {
                    Get.to(() => const Categories(), transition:Transition.zoom);
                  }),
              SizedBox(
                  height: 120,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/huawei.png",
                      text: "Huawei",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/iphone.jpg",
                      text: "Apple",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/realme.png",
                      text: "Realme",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/lenovo.png",
                      text: "Lenovo",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/vivo.png",
                      text: "Vivo",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/samsung.jpg",
                      text: "Samsung",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/xiaomi.png",
                      text: "Xiaomi",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/oppo.jpg",
                      text: "Oppo",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/tecno.png",
                      text: "Tecno",
                      onTap: () {},
                    ),
                    CategoriesLogo(
                      imageLogo: "assets/images/logo/nokia.jpg",
                      text: "Nokia",
                      onTap: () {},
                    ),
                  ])),
              CategoriesTitle(text: "Most Used", text2: "more", press: () {}),
              Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, bottom: 10, right: 5),
                  height: size.height / 3,
                  child: CarouselSlider(
                      items: [
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/carousel/1.jpg'),
                                    fit: BoxFit.cover)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Enjoy Your Eyes",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                        "Open Your Eyes And See The World As You Will See As A Last Moment",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        )),
                                  ),
                                ]))
                      ],
                      options: CarouselOptions(
                          height: size.height / 3,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 250)))),
              CategoriesTitle(
                text: "Lastest Phones",
                text2: "< Pull",
                press: () {},
              ),
              SizedBox(
                height: halfheight + partOfHeight,
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
                    ]),
              ),
            ]),
          )),
      drawerChild: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          title: const Text("Under Testing" , style:TextStyle(color:Colors.black)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: const Center(
          child: Text("Don't wait do it right now."),
        ),
      ),
    );
  }
}