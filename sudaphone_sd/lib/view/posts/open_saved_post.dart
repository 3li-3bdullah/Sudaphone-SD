import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
import 'package:sudaphone_sd/view/people_have_liked/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts/comments.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class OpenSavedPost extends GetWidget<PostsViewModel> {
  const OpenSavedPost({Key? key, required this.snapshot}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomTitle(
              text: "${snapshot.data()!['userName']}'s post",
              underLineWidget: 110),
          elevation: 0,
          leading: const Leading(),
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.postsCollections.doc(snapshot.id).snapshots(),
          builder: (context, snapshotForLikeCount) {
            if (snapshotForLikeCount.hasData) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${snapshotForLikeCount.data?.data()!['profileUrl']}"),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: CustomText(
                            text:
                                "${snapshotForLikeCount.data?.data()!['userName']}",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        CustomText2(
                          text: controller
                              .handleDate(snapshotForLikeCount.data
                                  ?.data()!['dateTime'])
                              .toString(),
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    trailing: snapshotForLikeCount.data!.data()!['ownerUid'] ==
                            controller.uid
                        // FirebaseAuth.instance.currentUser!.uid
                        ? PopupMenuButton<SavedItems>(
                            onSelected: (value) {
                              if (value == SavedItems.unsave) {
                                controller.unSavePost(
                                  postDoc: snapshotForLikeCount.data!.id,
                                );
                              } else if (value == SavedItems.edit) {
                                Get.defaultDialog(
                                  title: "Edit the post",
                                  titleStyle: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.bold),
                                  content: Form(
                                    key: controller.editingPostKey,
                                    child: CustomTextFormField(
                                        obscure: false,
                                        validator: (String name) {
                                          if (name.trim().isEmpty) {
                                            return "The field is empty";
                                          }
                                        },
                                        icon: Icons.edit,
                                        textEditingController:
                                            controller.editingPostController),
                                  ),
                                  textConfirm: "Edit",
                                  textCancel: "Cancel",
                                  cancelTextColor: Colors.brown,
                                  confirmTextColor: Colors.white,
                                  buttonColor: Colors.brown,
                                  radius: 20.0,
                                  onConfirm: () {
                                    controller.editingPost(
                                        editKey: controller.editingPostKey,
                                        postDoc: snapshotForLikeCount.data!.id,
                                        text: controller
                                            .editingPostController.text);
                                    Get.back();
                                  },
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              } else {
                                controller
                                    .deletePost(snapshotForLikeCount.data!.id);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: SavedItems.unsave,
                                child: CustomText(
                                  text: "Remove",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              PopupMenuItem(
                                value: SavedItems.edit,
                                child: CustomText(
                                  text: "Edit",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              PopupMenuItem(
                                value: SavedItems.delete,
                                child: CustomText(
                                  text: "Delete",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : PopupMenuButton<SavedItems>(
                            onSelected: (value) {
                              if (value == SavedItems.unsave) {
                                controller.unSavePost(
                                  postDoc: snapshotForLikeCount.data!.id,
                                );
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: SavedItems.unsave,
                                child: CustomText2(
                                  text: "Remove",
                                  color: kBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                    subtitle: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: snapshotForLikeCount.data?.data()!['text'],
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        snapshotForLikeCount.data!.data()!['isThereImageUrl'] ==
                                true
                            ? InkWell(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loader.gif',
                                    image:
                                        "${snapshotForLikeCount.data?.data()!['imageUrl']}"),
                                onTap: () {
                                  Get.to(
                                      () => DownloadImages(
                                          image: snapshotForLikeCount.data!
                                              .data()!['imageUrl']),
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
                  snapshotForLikeCount.connectionState ==
                          ConnectionState.waiting
                      ? const SizedBox()
                      : Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  snapshotForLikeCount.data!
                                                  .data()!['usersLiked']
                                              [controller.uid] ==
                                          true
                                      ? IconButton(
                                          onPressed: () {
                                            controller.handlePostLikes(
                                                currentPostDocData:
                                                    snapshotForLikeCount.data!);
                                          },
                                          icon: Image.asset(
                                            "assets/images/like.png",
                                            color: Colors.pink,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            controller.handlePostLikes(
                                                currentPostDocData:
                                                    snapshotForLikeCount.data!);
                                          },
                                          icon: Image.asset(
                                            "assets/images/like.png",
                                            color: Colors.brown,
                                          ),
                                        ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    child: Text(
                                      snapshotForLikeCount.data!
                                          .data()!['likesCount']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: snapshotForLikeCount.data!
                                                          .data()!['usersLiked']
                                                      [controller.uid] ==
                                                  true
                                              ? Colors.pink
                                              : Colors.grey.shade600),
                                    ),
                                    onTap: () {
                                      Get.to(
                                          () => PeopleHaveLiked(
                                                peopleWhoLiked:
                                                    snapshotForLikeCount.data!
                                                        .data()!['usersLiked']
                                                        .keys
                                                        .toList(),
                                                currentDoc: snapshotForLikeCount
                                                    .data!
                                                    .data()!['usersLiked'],
                                              ),
                                          transition: Transition.zoom);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => Comments(
                                            firstDocSnapshot:
                                                snapshotForLikeCount.data!,
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
                                          .doc(snapshotForLikeCount.data!.id)
                                          .collection("comments")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return CustomText2(
                                            text:
                                                "${snapshot.data?.docs.length}",
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
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
              );
            } else if (snapshotForLikeCount.connectionState ==
                ConnectionState.waiting) {
              return Container(
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: Image.asset("assets/images/loader.gif"),
              );
            } else {
              return Container(
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset("assets/lotties/no_data.json"),
              );
            }
          },
        ));
  }
}
