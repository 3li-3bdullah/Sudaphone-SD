import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts_pages/comments.dart';
import 'package:sudaphone_sd/view/posts_pages/write_post.dart';
import 'package:sudaphone_sd/view/posts_widgets/card_view.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Posts extends GetWidget<PostsViewModel> {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const WritePost(),
              curve: Curves.bounceInOut, transition: Transition.zoom);
        },
        child: const Icon(Icons.add, size: 20),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.postsCollections
            .orderBy("dateTime", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  // return CardView(data: snapshot.data!.docs[index]);
                  return Card(
                    color: Colors.brown[100],
                    child: Column(
                      children: [
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.userInfoCollection
                                .doc(snapshot.data!.docs[index]
                                    .data()['ownerUid'])
                                .snapshots(),
                            builder: (context, _snapshot) {
                              [controller.auth!.currentUser!.uid];
                              if (_snapshot.hasData) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    // Doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                                    backgroundImage: NetworkImage(
                                        _snapshot.data?.data()!['profileUrl']),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: CustomText(
                                          // Doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
                                          text: _snapshot.data
                                              ?.data()!['userName'],
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      CustomText(
                                        text: snapshot.data!.docs[index]
                                            .data()['dateTime'],
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        textAlign: TextAlign.right,
                                      )
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    onPressed: () {
                                      Get.bottomSheet(
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                        ),
                                      );
                                    },
                                  ),
                                  isThreeLine: true,
                                  subtitle: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: snapshot.data!.docs[index]
                                            .data()['text'],
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      snapshot.data!.docs[index]
                                                  .data()['isThereImageUrl'] ==
                                              true
                                          ? InkWell(
                                              child: Image.network(
                                                "${snapshot.data!.docs[index].data()['imageUrl']}",
                                                fit: BoxFit.cover,
                                              ),
                                              onTap: () {
                                                Get.to(
                                                    () => DownloadImages(
                                                        image: snapshot.data!
                                                                .docs[index]
                                                                .data()[
                                                            'imageUrl']),
                                                    transition: Transition.zoom,
                                                    curve: Curves.easeInExpo);
                                              },
                                            )
                                          : const SizedBox(
                                              height: 0.0,
                                              width: 0.0,
                                            ),
                                    ],
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  child: Lottie.asset(
                                      "assets/lotties/loading.json"),
                                );
                              }
                            }),
                        Divider(color: Colors.grey.withOpacity(0.2)),
                        //============================================================
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // IconButton(
                                //   onPressed: () {
                                //     controller.handlePostLikes(firstDocsSnapshot: data);
                                //   }, //'usersLiked.${controller.auth!.currentUser!.uid}'
                                //   icon: data.data()['usersLiked'][
                                //               controller.auth!.currentUser!.uid.toString()] ==
                                //           true
                                //       ? const Icon(Icons.favorite, color: Colors.pink)
                                //       : const Icon(Icons.favorite_border_outlined,
                                //           color: Colors.pink),
                                // ),
                                // const SizedBox(width: 10),
                                snapshot.data!.docs[index].data()['usersLiked'][
                                            controller
                                                .auth!.currentUser!.uid] ==
                                        true
                                    ?
                                    //    LikeButton(

                                    //   likeBuilder: (isTapped) {
                                    //     log("1111111111111");
                                    //     // controller.handlePostLikes(currentPostDocData: snapshot.data!.docs[index]);
                                    //      Icon(
                                    //       Icons.favorite,
                                    //       color: isTapped ? Colors.orange: Colors.red,
                                    //   //     isTapped? data.data()['usersLiked']
                                    //   // [controller.auth!.currentUser!.uid] == null || false ? Colors.orange : Colors.grey  :data.data()['usersLiked']
                                    //   // [controller.auth!.currentUser!.uid] == null ? Colors.grey : data.data()['usersLiked']
                                    //   // [controller.auth!.currentUser!.uid.toString()] == true  ? Colors.orange  : Colors.grey,
                                    //       size: 30,
                                    //     );
                                    //     controller.handlePostLikes(currentPostDocData: snapshot.data!.docs[index]);
                                    //   },
                                    //   size: 30,
                                    //  )
                                    IconButton(
                                        onPressed: () {
                                          controller.handlePostLikes(
                                              currentPostDocData:
                                                  snapshot.data!.docs[index]);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.pink,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          controller.handlePostLikes(
                                              currentPostDocData:
                                                  snapshot.data!.docs[index]);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.grey,
                                        )),

                                const SizedBox(width: 10),
                                InkWell(
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        .data()['likesCount']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: snapshot.data!.docs[index]
                                                        .data()['usersLiked'][
                                                    controller
                                                        .auth!.currentUser!.uid
                                                        .toString()] ==
                                                true
                                            ? Colors.pink
                                            : Colors.grey.shade600),
                                  ),
                                  onTap: () {
                                    Get.to(
                                        () => PeopleHaveLIked(
                                              peopleWhoLiked: snapshot
                                                  .data!.docs[index]
                                                  .data()['usersLiked']
                                                  .keys
                                                  .toList(),
                                              currentDoc: snapshot
                                                  .data!.docs[index]
                                                  .data()['usersLiked'],
                                            ),
                                        transition: Transition.zoom);
                                  },
                                )
                              ],
                            )),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => Comments(
                                            firstDocSnapshot:
                                                snapshot.data!.docs[index],
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.comment_outlined,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection("posts")
                                          .doc(snapshot.data!.docs[index].id)
                                          .collection("comments")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        return CustomText(
                                          text: "${snapshot.data?.docs.length}",
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/lotties/loading.json"));
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.brown,
                  ));
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Lottie.asset("assets/lotties/loading.json"));
          } else if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Lottie.asset("assets/images/no_data.json")],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
