import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/details/details.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class DrawerChild extends GetWidget<ScreenViewModel> {
  const DrawerChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Favorite",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.favorite
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("favorite")
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (_, i) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: GridTile(
                        child: Image.network(
                            snapshot.data?.docs[i].data()['imageUrl']),
                        footer: Container(
                          height: 20,
                          color: Colors.black.withOpacity(0.3),
                          child: CustomText2(
                            text: snapshot.data?.docs[i].data()['name'],
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(
                          () => Details(
                              docTwo: snapshot.data!.docs[i].id,
                              docOne: FirebaseAuth.instance.currentUser!.uid
                                  .toString(),
                              collction: "favorite"),
                          transition: Transition.zoom);
                    },
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Image.asset("assets/images/loader.gif"));
            } else if (!snapshot.hasData) {
              return Center(child: Lottie.asset("assets/images/no_data.json"));
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText2(
                    text: "Oops",
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  CustomText2(
                    text: "${snapshot.error}",
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
