import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/phone_list.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';

import '../../home/components/custom_leading.dart';

class Oppo extends GetWidget<CategoriesViewModel> {
  const Oppo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  CustomTitle(text: "Oppo", underLineWidget: 50,showUnderLine: false),
          leading:  const CustomLeading(),
          centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future:
            controller.phonesCategory.doc("allOppo").collection("oppo").get(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return PhoneList(
                  isHasData: snapshot,
                  collction: "oppo",
                  snapshot: snapshot.data?.docs[index],
                  docOne: "allOppo");
            },
          );
        },
      ),
    );
  }
}
