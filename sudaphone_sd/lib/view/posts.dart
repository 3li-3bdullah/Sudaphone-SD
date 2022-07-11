import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts_pages/comments.dart';
import 'package:sudaphone_sd/view/posts_pages/write_post.dart';
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
                              //Here should i add the new idea
                              if (_snapshot.hasData) {
                                return ListTile(
                                  leading: CircleAvatar(
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
                                  trailing: snapshot.data!.docs[index]
                                              .data()['ownerUid'] ==
                                          controller.uid
                                      ? PopupMenuButton<MenuItems>(
                                          onSelected: (value) {
                                            if (value == MenuItems.save) {
                                              controller.savePost(
                                                postDoc: snapshot
                                                    .data!.docs[index].id,
                                              );
                                            } else if (value ==
                                                MenuItems.edit) {
                                              Get.defaultDialog(
                                                title: "Edit the post",
                                                titleStyle: const TextStyle(
                                                    color: Colors.brown,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                content: Form(
                                                  key:
                                                      controller.editingPostKey,
                                                  child: CustomTextFormField(
                                                      obscure: false,
                                                      validator: (String name) {
                                                        if (name
                                                            .trim()
                                                            .isEmpty) {
                                                          return "The field is empty";
                                                        }
                                                      },
                                                      icon: Icons.person,
                                                      textEditingController:
                                                          controller
                                                              .editingPostController),
                                                ),
                                                textConfirm: "Edit",
                                                textCancel: "Cancel",
                                                cancelTextColor: Colors.brown,
                                                confirmTextColor: Colors.white,
                                                buttonColor: Colors.brown,
                                                radius: 20.0,
                                                onConfirm: () {
                                                  controller.editingPost(
                                                      editKey: controller
                                                          .editingPostKey,
                                                      postDoc: snapshot
                                                          .data!.docs[index].id,
                                                      text: controller
                                                          .editingPostController
                                                          .text);
                                                },
                                                onCancel: () {
                                                  Get.back();
                                                },
                                              );
                                            } else {
                                              controller.deletePost(snapshot
                                                  .data!.docs[index].id);
                                            }
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              value: MenuItems.save,
                                              child: CustomText(
                                                text: "Save",
                                                color: kBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: MenuItems.edit,
                                              child: CustomText(
                                                text: "Edit",
                                                color: kBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: MenuItems.delete,
                                              child: CustomText(
                                                text: "Delete",
                                                color: kBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        )
                                      : PopupMenuButton<MenuItems>(
                                          onSelected: (value) {
                                            if (value == MenuItems.save) {
                                              controller.savePost(
                                                postDoc: snapshot
                                                    .data!.docs[index].id,
                                              );
                                            }
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                              value: MenuItems.save,
                                              child: CustomText(
                                                text: "Save",
                                                color: kBlackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
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
                                                      .data()['edited']
                                                  [controller.uid] ==
                                              true
                                          ? const CustomText(
                                              text: "Edited",
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              textAlign: TextAlign.left,
                                            )
                                          : const SizedBox(),
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
