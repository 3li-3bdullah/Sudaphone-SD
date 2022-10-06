import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/posts/open_saved_post.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Saved extends GetWidget<PostsViewModel> {
  const Saved({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /*
    * Here I Have Called The Method To Provide Me If Current User
    * Has Saved Any Post Or Not
    */
    controller.isCurrentUserSavedPosts();
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Saved", underLineWidget: 40),
        leading: const Leading(),
        elevation: 0,
      ),
      body: GetBuilder<PostsViewModel>(
        builder: (controller) => controller.isCurrentUserSavedPost.isNotEmpty
            ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .orderBy('dateTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs[index]
                              .data()['usersHaveSaved']['${controller.uid}']) {
                            return InkWell(
                              onTap: () => Get.to(() => OpenSavedPost(
                                  snapshot: snapshot.data!.docs[index])),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: CustomText(
                                        text: snapshot.data!.docs[index]
                                            .data()['userName'],
                                        textAlign: TextAlign.left,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    trailing: PopupMenuButton<SavedItems>(
                                      onSelected: (value) => value ==
                                              SavedItems.unsave
                                          ? controller.unSavePost(
                                              postDoc:
                                                  snapshot.data!.docs[index].id)
                                          : Get.to(() => OpenSavedPost(
                                              snapshot:
                                                  snapshot.data!.docs[index])),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: SavedItems.unsave,
                                          child: CustomText(
                                            text: "Unsave",
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: SavedItems.viewPost,
                                          child: CustomText(
                                            text: "View Post",
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    leading: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: snapshot.data!.docs[index]
                                              .data()['isThereImageUrl']
                                          ? Image.network(
                                              snapshot.data!.docs[index]
                                                  .data()['imageUrl'],
                                              fit: BoxFit.fill,
                                            )
                                          : Container(
                                              height: Get.height / 8,
                                              width: Get.width / 6,
                                              color: Colors.grey,
                                              child: const Icon(Icons.person)),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        });
                  } else {
                    return Center(
                      child: Image.asset('assets/images/loader.gif'),
                    );
                  }
                },
              )
            : Center(
                child: Lottie.asset('assets/lotties/no_data.json'),
              ),
      ),
    );
  }
}
