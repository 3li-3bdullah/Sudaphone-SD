import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/phone_list.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';

class Realme extends GetWidget<CategoriesViewModel> {
  const Realme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future:
          controller.phonesCategory.doc("allRealme").collection("realme").get(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return PhoneList(
                isHasData: snapshot,
                collction: "realme",
                snapshot: snapshot.data!.docs[index],
                docOne: "allRealme");
          },
        );
      },
    );
  }
}
