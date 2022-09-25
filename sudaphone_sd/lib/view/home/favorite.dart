import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/details/details.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Favorite extends GetWidget<ScreenViewModel> {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "Favorite",
            fontSize: 22,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center),
        elevation: 0,
        leading: GetBuilder<ThemesViewModel>(
            builder: (controller) => IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: controller.theme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ))),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.favorite
              .doc(controller.uid)
              .collection("favorite")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
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
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loader.gif',
                            image:  snapshot.data?.docs[i].data()['imageUrl'],)
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
                    onLongPress: () {
                      Get.defaultDialog(
                        content: CustomText(
                          text:
                              "Do you want to remove it \n from your favorite?",
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        title: "",
                        textCancel: "No",
                        textConfirm: "Yes",
                        onCancel: () {
                          Get.back();
                        },
                        onConfirm: () {
                          controller
                              .deleteFromFavorite(snapshot.data!.docs[i].id);
                          Get.back();
                        },
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.brown,
                        buttonColor: Colors.brown,
                      );
                    },
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset("assets/lotties/favorite.json"));
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset("assets/lotties/no_data.json"));
            }
          }),
    );
  }
}
/*
   return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15,
                      itemBuilder: (context, i) {
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3,
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    snapshot.data?.docs[index]['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  color: Colors.grey[100],
                                  child: CustomText(
                                    text: "${snapshot.data?.docs[index]['name']}",
                                    textAlign: TextAlign.center,
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: (){
                            Get.to(() => Details(snapshot: snapshot, docOne: controller.uid.toString(), collction: "favorite"));
                          },
                        );
                      },
                      staggeredTileBuilder: (indexo) =>
                          const StaggeredTile.fit(1),
                    ); 
*/