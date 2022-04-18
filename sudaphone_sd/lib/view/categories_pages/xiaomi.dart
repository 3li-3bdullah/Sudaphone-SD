import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/phone_list.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';

class Xiaomi extends GetWidget<CategoriesViewModel> {
  const Xiaomi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const CustomText(
            text: "Huawei",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            textAlign: TextAlign.center),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: controller.phonesCategory
            .doc("allXiaomi")
            .collection("xiaomi")
            .get(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return PhoneList(
                  isHasData: snapshot,
                  collction: "xiaomi",
                  snapshot: snapshot.data!.docs[index],
                  docOne: "allXiaomi");
            },
          );
        },
      ),
    );
  }
}
