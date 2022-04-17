import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/phone_list.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';

class Nokia extends GetWidget<CategoriesViewModel> {
  const Nokia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future:
          controller.phonesCategory.doc("allNokia").collection("nokia").get(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return PhoneList(
                isHasData: snapshot,
                collction: "nokia",
                snapshot: snapshot.data!.docs[index],
                docOne: "allNokia");
          },
        );
      },
    );
  }
}
