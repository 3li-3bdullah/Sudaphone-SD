import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/people_have_liked/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts/comments.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class OpenSavedPost extends GetWidget<PostsViewModel> {
  const OpenSavedPost({Key? key, required this.snapshot}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: "${snapshot.data()!['userName']}'s post",
              fontSize: 18,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center),
          elevation: 0,
          leading: const Leading(),
        ),
        body: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage("${snapshot.data()!['profileUrl']}"),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: CustomText(
                      text: "${snapshot.data()!['userName']}",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  CustomText2(
                    text: snapshot.data()!['dateTime'],
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    textAlign: TextAlign.right,
                  )
                ],
              ),
              trailing: snapshot.data()!['ownerUid'] == controller.uid
                  // FirebaseAuth.instance.currentUser!.uid
                  ? PopupMenuButton<SavedItems>(
                      onSelected: (value) {
                        if (value == SavedItems.unsave) {
                          controller.unSavePost(
                            postDoc: snapshot.id,
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
                                  postDoc: snapshot.id,
                                  text: controller.editingPostController.text);
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            },
                          );
                        } else {
                          controller.deletePost(snapshot.id);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: SavedItems.unsave,
                          child: CustomText(
                            text: "Save",
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
                            postDoc: snapshot.id,
                          );
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: SavedItems.unsave,
                          child: CustomText2(
                            text: "Save",
                            color: kBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

              // isThreeLine: true,
              subtitle: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: snapshot.data()!['text'],
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
                  snapshot.data()!['isThereImageUrl'] == true
                      //ToDo: Here i should see if the lottie appear that's nice and if it not i shuold dwonload the lottie as GIF..
                      ? InkWell(
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/lotties/loading.json',
                              image: "${snapshot.data()!['imageUrl']}"),
                          onTap: () {
                            Get.to(
                                () => DownloadImages(
                                    image: snapshot.data()!['imageUrl']),
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
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.postsCollections.doc(snapshot.id).snapshots(),
              builder: (context, snapshotForLikeCount) => snapshotForLikeCount
                          .connectionState ==
                      ConnectionState.waiting
                  ? const SizedBox()
                  : Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              snapshotForLikeCount.data!.data()!['usersLiked']
                                          [controller.uid] ==
                                      true
                                  ? IconButton(
                                      onPressed: () {
                                        controller.handlePostLikes(
                                            currentPostDocData:
                                                snapshotForLikeCount.data!);
                                      },
                                      icon: Image.asset(
                                        "assets/icons/favorite.png",
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
                                        "assets/icons/favorite.png",
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
                                      color: snapshot.data()!['usersLiked']
                                                  [controller.uid] ==
                                              true
                                          ? Colors.pink
                                          : Colors.grey.shade600),
                                ),
                                onTap: () {
                                  Get.to(
                                      () => PeopleHaveLiked(
                                            peopleWhoLiked: snapshotForLikeCount
                                                .data!
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
                                        firstDocSnapshot: snapshot,
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
                                      .doc(snapshot.id)
                                      .collection("comments")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return CustomText2(
                                      text: "${snapshot.data?.docs.length}",
                                      color: Colors.grey,
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
            ),

            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
          ],
        ));
  }
}
