import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/categories.dart';
import 'package:sudaphone_sd/view/categories_pages/huawei.dart';
import 'package:sudaphone_sd/view/categories_pages/iphone.dart';
import 'package:sudaphone_sd/view/categories_pages/lenovo.dart';
import 'package:sudaphone_sd/view/categories_pages/oppo.dart';
import 'package:sudaphone_sd/view/categories_pages/realme.dart';
import 'package:sudaphone_sd/view/categories_pages/samsung.dart';
import 'package:sudaphone_sd/view/categories_pages/tecno.dart';
import 'package:sudaphone_sd/view/screen_pages/data_search.dart';
import 'package:sudaphone_sd/view/screen_pages/drawer_child.dart';
import 'package:sudaphone_sd/view/screen_widgets/all_products.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_images_carousel.dart';
import 'package:sudaphone_sd/view/screen_widgets/build_indicator_carousel.dart';
import 'package:sudaphone_sd/view/screen_widgets/carousel_most_used.dart';
import 'package:sudaphone_sd/view/screen_widgets/categories_title.dart';
import 'package:sudaphone_sd/view/screen_widgets/custom_listtile.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
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
                  builder: (controller) => IconButton(
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
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: controller.carouselFire
                          .doc("carouselSlider")
                          .collection("carousel")
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridTile(
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              allowImplicitScrolling: true,
                              controller: controller.controllerCarousel,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: halfheight,
                                  width: size.width,
                                  child: BuildImagesCarousel(
                                      imagesCarousel: snapshot.data!.docs[index]
                                          .data()['imageUrl']),
                                );
                              },
                            ),
                            footer: Container(
                              height: 60,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BuildIndicatorCarousel(
                                    imageLength: snapshot.data!.docs.length,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child:
                                Lottie.asset("assets/lottie/please_wait.json"),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: CustomText(
                              text: "Oops! no data found",
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return Center(
                            child:
                                Lottie.asset("assets/lottie/please_wait.json"),
                          );
                        }
                      },
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
                  SizedBox(
                    height: 130,
                    //I've removed Expanded
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      CustomListTile(
                        image: "assets/images/logo/huawei.png",
                        onTap: () {
                          Get.to(() => const Huawei(),
                              transition: Transition.zoom);
                        },
                        text: "Huawei",
                      ),
                      CustomListTile(
                        image: "assets/images/logo/iphone.jpg",
                        onTap: () {
                          Get.to(() => const Iphone(),
                              transition: Transition.zoom);
                        },
                        text: "Iphone",
                      ),
                      CustomListTile(
                        image: "assets/images/logo/lenovo.png",
                        onTap: () {
                          Get.to(() => const Lenovo(),
                              transition: Transition.zoom);
                        },
                        text: "Lenovo",
                      ),
                      CustomListTile(
                          image: "assets/images/logo/samsung.jpg",
                          onTap: () {
                            Get.to(() => const Samsung(),
                                transition: Transition.zoom);
                          },
                          text: "Samsung"),
                      CustomListTile(
                        image: "assets/images/logo/oppo.jpg",
                        onTap: () {
                          Get.to(() => const Oppo(),
                              transition: Transition.zoom);
                        },
                        text: "Oppo",
                      ),
                      CustomListTile(
                        image: "assets/images/logo/realme.png",
                        onTap: () {
                          Get.to(() => const Realme(),
                              transition: Transition.zoom);
                        },
                        text: "Realme",
                      ),
                      CustomListTile(
                        image: "assets/images/logo/tecno.png",
                        onTap: () {
                          Get.to(() => const Tecno(),
                              transition: Transition.zoom);
                        },
                        text: "Tecno",
                      ),
                    ]),
                  ),
                  CategoriesTitle(
                      text: "Most Used", press: () {}),
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
                       if(snapshot.hasData){ return CarouselSlider.builder(
                          itemCount: snapshot.data?.docs.length,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Enjoy Your Eyes",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${snapshot.data!.docs[index].data()['name']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                child: Lottie.asset(
                                    "assets/lottie/please_wait.json"),
                              );
                            } else if (snapshot.hasError) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: "Oops!",
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: snapshot.error.toString(),
                                    color: Colors.black,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CustomText(
                          text: "Last Products",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                        
                        // const Spacer(),
                        // ElevatedButton.icon(
                        //     onPressed: () {},
                        //     icon: const Icon(Icons.arrow_back),
                        //     label: const CustomText(
                        //       text: "Pull",
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.normal,
                        //       color: Colors.white,
                        //       textAlign: TextAlign.center,
                        //     )),
                      ],
                    ),
                  ),
                  // CategoriesTitle(
                  //   text: "Lastest Phones",
                  //   text2: "< Pull",
                  //   press: () {},
                  // ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 +
                        MediaQuery.of(context).size.height / 8,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: [
                        AllProducts(
                            collection: "huawei",
                            docOne: "allHuawei",
                            docTwo: "AxMzs7IShYFwBfw7hSYm"),
                        AllProducts(
                            collection: "iphone",
                            docOne: "allIphone",
                            docTwo: "kgCtXk3jHTz5tJHV3VNe"),
                        AllProducts(
                            collection: "realme",
                            docOne: "allRealme",
                            docTwo: "E620Lr8NMpLdYCIVvWJe"),
                        AllProducts(
                            collection: "vivo",
                            docOne: "allVivo",
                            docTwo: "cYg4hOV1jC7AGykbnHZY"),
                        AllProducts(
                            collection: "xiaomi",
                            docOne: "allXiaomi",
                            docTwo: "uG5hyJeFkL2KbxuufVIP"),
                        AllProducts(
                            collection: "samsung",
                            docOne: "allSamsung",
                            docTwo: "OoPjLoRUIxo2tF1GsoDD"),
                        AllProducts(
                            collection: "oppo",
                            docOne: "allOppo",
                            docTwo: "AfTtdDT9u4J3hDpwGf7n"),
                        AllProducts(
                            collection: "lenovo",
                            docOne: "allLenovo",
                            docTwo: "1IUPh51OJVPBEoBQt1Lg"),
                        AllProducts(
                            collection: "tecno",
                            docOne: "allTecno",
                            docTwo: "ph2AiHJOeuSQHcOKMabs"),
                        AllProducts(
                            collection: "nokia",
                            docOne: "allNokia",
                            docTwo: "cJ9YAF2gv0m34L3LS49f"),
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
