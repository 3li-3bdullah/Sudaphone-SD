import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/screen_widgets/last_product.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

// ignore: must_be_immutable
class AllProducts extends GetWidget<ScreenViewModel> {
  AllProducts(
      {required this.collection,
      required this.docOne,
      required this.docTwo,
      Key? key})
      : super(key: key);
  String docOne;
  String docTwo;
  String collection;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.phonesCategory
            .doc(docOne)
            .collection(collection)
            .doc(docTwo)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LastProduct(
                imageProduct: snapshot.data?.data()?['imageUrl'],
                text: snapshot.data?.data()!['name'],
                price: snapshot.data?.data()!['price'],
                collection: collection,
                docOne: docOne,
                snapshot: snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset("assets/lotties/loading.json"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purpleAccent,
              ),
            );
          }
        });
  }
}
