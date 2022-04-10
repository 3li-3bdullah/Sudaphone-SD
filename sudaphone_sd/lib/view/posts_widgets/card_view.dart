import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/posts_pages/comments.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class CardView extends GetWidget<PostsViewModel> {
  CardView({Key? key, required this.data, required this.index})
      : super(key: key);
  var data;
  int index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(data.id)
            .collection("userPosts")
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("has dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            return Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/slider/ali1.jpg"),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const CustomText(
                                    text: "Ali Abdullah",
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                CustomText(
                                  text: snapshot.data!.docs[index]['dateTime'],
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {}),
                            isThreeLine: true,
                            subtitle: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: snapshot.data!.docs[index]['text'],
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                snapshot.data!.docs[index]['isThereImageUrl'] ==
                                        true
                                    ? InkWell(
                                        child: Image.network(
                                          "${snapshot.data!.docs[index]['imageUrl']}",
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          Get.to(
                                              () => DownloadImages(
                                                  image: snapshot.data!
                                                      .docs[index]['imageUrl']),
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
                          ),
                          Divider(color: Colors.grey.withOpacity(0.2)),
                          //============================================================
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.handlePostLikes(
                                          firstDocsSnapshot : data,
                                          docSnapshot: snapshot.data!.docs[index]);
                                    }, //'usersLiked.${controller.auth!.currentUser!.uid}'
                                    icon: snapshot.data!.docs[index]
                                                    ['usersLiked'][
                                                '${controller.auth!.currentUser!.uid}'] ==
                                            true
                                        ? const Icon(Icons.favorite,
                                            color: Colors.pink)
                                        : const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.pink),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    snapshot.data!.docs[index]['likesCount']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: snapshot.data!.docs[index]
                                                        ['usersLiked'][
                                                    '${controller.auth!.currentUser!.uid}'] ==
                                                true
                                            ? Colors.pink
                                            : Colors.grey.shade600),
                                  )
                                ],
                              )
                                  // StreamBuilder<
                                  //     QuerySnapshot<Map<String, dynamic>>>(
                                  //   stream: FirebaseFirestore.instance
                                  //       .collection("posts")
                                  //       .doc(data.id)
                                  //       .collection("userPosts")
                                  //       .doc(snapshot.data!.docs[index].id)
                                  //       .collection("likes")
                                  //       .snapshots(),
                                  //   builder: (context, _snapshot) {
                                  //     return ListView.builder(
                                  //       shrinkWrap: true,
                                  //       itemCount: snapshot.data!.docs.length,
                                  //       itemBuilder: (context, _index) {
                                  //         if (_snapshot.data?.docs[_index].id ==
                                  //             controller.auth!.currentUser!.uid) {
                                  //           controller.isHasLiked(true);
                                  //           return Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.center,
                                  //               children: [
                                  //                 IconButton(
                                  //                     onPressed: () {
                                  //                       controller.handleLikes(
                                  //                           collection1: data,
                                  //                           collection2: snapshot
                                  //                               .data!
                                  //                               .docs[index],
                                  //                           snapshot: _snapshot
                                  //                               .data!
                                  //                               .docs[_index]);
                                  //                     },
                                  //                     icon: const Icon(
                                  //                         Icons.favorite,
                                  //                         color: Colors.pink)),
                                  //                 const SizedBox(width: 10),
                                  //                 Text(
                                  //                   "${_snapshot.data!.docs.length}",
                                  //                   style: const TextStyle(
                                  //                       fontSize: 15,
                                  //                       fontWeight:
                                  //                           FontWeight.normal,
                                  //                       color: Colors.pink),
                                  //                 )
                                  //               ]);
                                  //         } else {
                                  //           return Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               IconButton(
                                  //                 onPressed: () {
                                  //                   controller.handleLikes(
                                  //                       collection1: data,
                                  //                       collection2: snapshot
                                  //                           .data!.docs[index],
                                  //                       snapshot: _snapshot
                                  //                           .data!.docs[_index]);
                                  //                 },
                                  //                 icon: const Icon(
                                  //                     Icons
                                  //                         .favorite_border_outlined,
                                  //                     color: Colors.pink),
                                  //               ),
                                  //               const SizedBox(width: 10),
                                  //               Text(
                                  //                 "${_snapshot.data?.docs.length}",
                                  //                 style: TextStyle(
                                  //                     fontSize: 15,
                                  //                     fontWeight:
                                  //                         FontWeight.normal,
                                  //                     color:
                                  //                         Colors.grey.shade600),
                                  //               )
                                  //             ],
                                  //           );
                                  //         }
                                  //       },
                                  //     );
                                  //   },
                                  // ),

                                  ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.to(() => Comments(
                                              firstCollection: data,
                                              secondCollection:
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
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection("posts")
                                            .doc(data.id)
                                            .collection("userPosts")
                                            .doc(snapshot.data!.docs[index].id)
                                            .collection("comments")
                                            .orderBy('dateTime')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return CustomText(
                                            text:
                                                "${snapshot.data?.docs.length}",
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
                  }),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset("assets/images/create_post.json"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
