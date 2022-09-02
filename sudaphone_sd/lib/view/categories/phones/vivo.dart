import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/components/phone_list.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';

class Vivo extends GetWidget<CategoriesViewModel> {
  const Vivo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  CustomText(
            text: "Vivo",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center),
              leading:  const Leading(),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future:
            controller.phonesCategory.doc("allVivo").collection("vivo").get(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return PhoneList(
                  isHasData: snapshot,
                  collction: "vivo",
                  snapshot: snapshot.data?.docs[index],
                  docOne: "allVivo");
            },
          );
        },
      ),
    );
  }
}
