import 'package:better_player/better_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/model/home/screen_model.dart';

import '../view/categories/categories.dart';
import '../view/categories/phones/huawei.dart';
import '../view/categories/phones/iphone.dart';
import '../view/categories/phones/lenovo.dart';
import '../view/categories/phones/nokia.dart';
import '../view/categories/phones/oppo.dart';
import '../view/categories/phones/realme.dart';
import '../view/categories/phones/samsung.dart';
import '../view/categories/phones/tecno.dart';
import '../view/categories/phones/vivo.dart';
import '../view/categories/phones/xiaomi.dart';

class ScreenViewModel extends GetxController {
  /*
  * (((((((((((((((((((( Declaring Variables )))))))))))))))))))))))
  */
  int activeIndex = 0;
  RxDouble value = 0.0.obs;
  String? uid;
  CollectionReference<Map<String, dynamic>> favorite =
      FirebaseFirestore.instance.collection("favorite");
  CollectionReference<Map<String, dynamic>> carouselFire =
      FirebaseFirestore.instance.collection("carousel");
  CollectionReference<Map<String, dynamic>> phonesCategory =
      FirebaseFirestore.instance.collection("phonesCategory");
  PageController controllerCarousel =
      PageController(viewportFraction: 0.8, keepPage: true);
  CollectionReference<Map<String, dynamic>> lastProducts =
      FirebaseFirestore.instance.collection("lastProducts");

  late BetterPlayerController betterPlayerController;
  RxString mediaUrl = "".obs;
  Size size = MediaQuery.of(Get.context!).size;

  // ----------- Variables To Get Data From Firebase ----------------
  List<LastProducts>? listOfLastProducts;
  List<BGPhones>? listBGPhones;
  List<Category>? listCategories;
  List<MainCarousel>? listMainCarousel;
  // ------------ Loading --------------------
  RxBool isCateHasData = true.obs;
  RxBool isMainCarouselHasData = true.obs;
  RxBool loading = true.obs;

  final List<Color> colors = const [
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
  ];
  /* 
  *  (((((((((((((((((((( Declaring Methods )))))))))))))))))))))))
  */

  @override
  void onInit() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    retrieveLastProducts();
    retrieveBestGamingPhones();
    retrieveCategoriesData();
    retrieveMainCarouselData();
    initialPlayer();
    super.onInit();
  }

  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }

  void onSelectedItem(int index) {
    activeIndex = index;
    update();
  }

  Future<void> initialPlayer() async {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9, fit: BoxFit.contain);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, mediaUrl.value);
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(dataSource);
  }

  deleteFromFavorite(String id) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(uid)
        .collection("favorite")
        .doc(id)
        .delete();
  }

  /** ------------- When user tap on any category, so this switch will handle
   *     where user has tapped and show up the selected category page --------------- */

  onSelectedCategory({required String categoryName}) {
    switch (categoryName) {
      case "Samsung":
        Get.to(() => const Samsung(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Huawei":
        Get.to(() => const Huawei(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Iphone":
        Get.to(() => const Iphone(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Realme":
        Get.to(() => const Realme(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Oppo":
        Get.to(() => const Oppo(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Xiaomi":
        Get.to(() => const Xiaomi(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Lenovo":
        Get.to(() => const Lenovo(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Tecno":
        Get.to(() => const Tecno(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Nokia":
        Get.to(() => const Nokia(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      case "Vivo":
        Get.to(() => const Vivo(),
            duration: const Duration(milliseconds: 50),
            transition: Transition.zoom);
        break;
      default:
        Get.to(() => const Categories());
    }
  }

  // ------------- Get Last Product Data ------------
  Future<List<LastProducts>> getLastProductsData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("lastProducts").get();

    return snapshot.docs
        .map((querySnapshot) => LastProducts.fromJson(querySnapshot))
        .toList();
  }

  Future<void> retrieveLastProducts() async {
    listOfLastProducts = await getLastProductsData();
    loading.value = false;
  }

  // ---------------- Get Best Gaming Phones Data -------------------
  Future<List<BGPhones>> getBestGamingPhones() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("forGames").get();
    return snapshot.docs
        .map((querySnapshot) => BGPhones.fromJson(querySnapshot))
        .toList();
  }

  Future<void> retrieveBestGamingPhones() async {
    listBGPhones = await getBestGamingPhones();
  }

  // ------------- Get Categories Data --------------
  Future<List<Category>> getCategoriesData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    return snapshot.docs
        .map((querySnapshot) => Category.fromJson(querySnapshot))
        .toList();
  }

  Future<void> retrieveCategoriesData() async {
    listCategories = await getCategoriesData();
    isCateHasData.value = false;
  }

  // ------------- Get Main Carousel Data -------------
  Future<List<MainCarousel>> getMainCasrouselData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("carousel")
        .doc("carouselSlider")
        .collection("carousel")
        .get();
    return snapshot.docs
        .map((querySnapshot) => MainCarousel.fromJson(querySnapshot))
        .toList();
  }

  Future<void> retrieveMainCarouselData() async {
    listMainCarousel = await getMainCasrouselData();
    isMainCarouselHasData.value = false;
  }
}
