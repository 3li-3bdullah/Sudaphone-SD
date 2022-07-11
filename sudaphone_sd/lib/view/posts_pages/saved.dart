import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';

// ignore: must_be_immutable
class Saved extends GetWidget<PostsViewModel> {
   Saved({Key? key}) : super(key: key);
  var publicData = Get.find<PublicData>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                publicData.getUserInfo(snapshot.data!.docs[index].id);
                if (snapshot.data!.docs[index].data()['userHasSaved']
                        [controller.uid] ==
                    true) {
                  return Column(
                    children: [
                      ListTile(
                        title: CustomText(
                            text: publicData.getUserName,
                            textAlign: TextAlign.left,
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz)),
                        leading: Container(
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: snapshot.data!.docs[index]
                                  .data()['isThereImageUrl']
                              ? Image.network(
                                  snapshot.data!.docs[index].data()['imageUrl'],
                                  fit: BoxFit.contain,
                                )
                              : const Icon(Icons.person),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Lottie.asset("assets/lotties/empty_saved.json");
                }
              });
            } else if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomText(
                    text: snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset("assets/lotties/loading.json"));
            }
          }),
    );
  }
}
