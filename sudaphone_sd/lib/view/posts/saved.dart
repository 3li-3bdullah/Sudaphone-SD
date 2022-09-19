import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/posts/open_saved_post.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Saved extends GetWidget<PostsViewModel> {
  const Saved({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // controller.getCurretUserPostsHasSaved();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Saved",
          fontSize: 20,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        leading: const Leading(),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("posts").orderBy('dateTime',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data!.docs[index].data().isNotEmpty &&
                      snapshot.data!.docs[index].data()['usersHaveSaved']
                          ['${controller.uid}']) {
                    return InkWell(
                      onTap: () => Get.to(() => OpenSavedPost(
                                    snapshot: snapshot.data!.docs[index])),
                      child: Column(
                        children: [
                          ListTile(
                            title: CustomText(
                                text:
                                    snapshot.data!.docs[index].data()['userName'],
                                textAlign: TextAlign.left,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                            trailing: PopupMenuButton<SavedItems>(
                              onSelected: (value) => value == SavedItems.unsave
                                  ? controller.unSavePost(
                                      postDoc: snapshot.data!.docs[index].id)
                                  : Get.to(() => OpenSavedPost(
                                      snapshot: snapshot.data!.docs[index])),
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
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: snapshot.data!.docs[index]
                                      .data()['isThereImageUrl']
                                  ? Image.network(
                                      snapshot.data!.docs[index]
                                          .data()['imageUrl'],
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      height: size.height / 8,
                                      width: size.width / 6,
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
              ),
            );
          } else {
            return Center(child: Lottie.asset("assets/lotties/no_data.json"));
          }
        },
      ),
    );
  }
}
/* 
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                if (snapshot.data!.docs[index].data()['usersHasSaved']
                        [controller.uid] ==
                    true) {
                  return Column(
                    children: [
                      ListTile(
                        title: CustomText(
                            text: "publicData.getUserName",
                            textAlign: TextAlign.left,
                            fontSize: 14,
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
                  return Container(
                    height: size.height,
                    width: size.width,
                    alignment: Alignment.center,
                    child: const Text("")
                    );
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
                    fontSize: 18,),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset("assets/lotties/loading.json"));
            }
          }),
*/
//222222222222222222222222222222222222222222222222222222222
/* 
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data!.docs[index].data().isNotEmpty &&
                      snapshot.data!.docs[index].data()['usersHaveSaved'] ==
                          true) {
                    return Column(
                      children: [
                        ListTile(
                          title: CustomText(
                              text:
                                  snapshot.data!.docs[index].data()['userName'],
                              textAlign: TextAlign.left,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          trailing: PopupMenuButton<SavedItems>(
                            onSelected: (value) => value == SavedItems.unsave
                                ? controller.unSavePost(
                                    postDoc: snapshot.data!.docs[index].id)
                                : OpenSavedPost(
                                    snapshot: snapshot.data!.docs[index]),
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
                            height: MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.width / 6,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: snapshot.data!.docs[index]
                                    .data()['isThereImageUrl']
                                ? Image.network(
                                    snapshot.data!.docs[index]
                                        .data()['imageUrl'],
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                                    height: size.height / 8,
                                    width: size.width / 6,
                                    color: Colors.grey,
                                    child: const Icon(Icons.person)),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        )
                      ],
                    );
                  } else {
                    return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Lottie.asset("assets/lotties/no_data.json"));
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
              ),
            );
          } else {
            return Center(child: Lottie.asset("assets/lotties/no_data.json"));
          }
        },
      ),
*/

//-----------------------------
/*
GetBuilder<PostsViewModel>(
          builder: (controller) => ListView.builder(
            /**
             *ToDo: Come on man, Here absolutely i should add the new idea ,,, let's planing .... 
             */
              itemCount: controller.listOfSavedPosts!.length ,
              itemBuilder: (_, indexo) {
                log("${controller.listOfSavedPosts!.length } yyyyyyy");
                return controller.listOfSavedPosts!.isNotEmpty ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .doc(controller.listOfSavedPosts![indexo].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          log("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                          if (snapshot.hasData && snapshot.data!.exists) {
                            // if (snapshot.data!.docs[index].data()['usersHaveSaved']['${controller.uid}'].isNotEmpty) {
                            return snapshot.data!.data()!['usersHaveSaved']
                                        ['${controller.uid}'] ==
                                    true
                                ? Column(
                                    children: [
                                      ListTile(
                                        title: CustomText(
                                            text: snapshot.data!
                                                .data()!['userName'],
                                            textAlign: TextAlign.left,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        subtitle: snapshot.data!
                                                    .data()!['text'] !=
                                                null
                                            ? Text(
                                                snapshot.data!.data()!['text'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : const SizedBox(),
                                        trailing: PopupMenuButton<SavedItems>(
                                          onSelected: (value) => value ==
                                                  SavedItems.unsave
                                              ? controller.unSavePost(
                                                  postDoc: controller
                                                      .listOfSavedPosts![indexo])
                                              : OpenSavedPost(
                                                  snapshot: snapshot.data!),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: snapshot.data!
                                                  .data()!['isThereImageUrl']
                                              ? Image.network(
                                                  snapshot.data!
                                                      .data()!['imageUrl'],
                                                  fit: BoxFit.fill,
                                                )
                                              : Container(
                                                  height: size.height / 8,
                                                  width: size.width / 6,
                                                  color: Colors.grey,
                                                  child:
                                                      const Icon(Icons.person)),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                : snapshot.data!.data()!['usersHaveSaved']
                                            ['${controller.uid}'] ==
                                        null
                                    ? Container(
                                        height: size.height * 0.9,
                                        width: size.width,
                                        alignment: Alignment.center,
                                        child: Lottie.asset(
                                            "assets/lotties/no_data.json"))
                                    : Center(
                                        child: Lottie.asset(
                                            "assets/lotties/no_data.json"));
                            // } else {
                            //   return Container(
                            //       alignment: Alignment.center,
                            //       height: MediaQuery.of(context).size.height,
                            //       width: MediaQuery.of(context).size.width,
                            //       child: Lottie.asset("assets/lotties/no_data.json"));
                            // }

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
                              ),
                            );
                          } else {
                            return Center(
                                child: Lottie.asset(
                                    "assets/lotties/no_data.json"));
                          }
                        },
                      ) : Center(
                                child: Lottie.asset(
                                    "assets/lotties/no_data.json"));
              })),
*/
//! The one after added alittle update

/*
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                if (snapshot.data!.docs[index].data()['usersHaveSaved']
                        [controller.uid]) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical:10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: CustomText(
                              text: "${snapshot.data!.docs[index].data()['userName']}",
                              textAlign: TextAlign.left,
                              fontSize: 14,
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
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: size.height,
                    width: size.width,
                    alignment: Alignment.center,
                    child: const Text("")
                    );
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
                    fontSize: 18,),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset("assets/lotties/loading.json"));
            }
          }),
*/