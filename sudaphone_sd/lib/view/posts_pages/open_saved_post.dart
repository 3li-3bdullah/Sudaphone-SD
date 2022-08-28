import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/details_widget/custom_text_details.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts_pages/comments.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/leading.dart';
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
                backgroundImage: NetworkImage(
                    "${snapshot.data()!['profileUrl']}"),
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
              trailing: snapshot.data()!['ownerUid'] ==
                      controller.uid
                  // FirebaseAuth.instance.currentUser!.uid
                  ? PopupMenuButton<MenuItems>(
                      onSelected: (value) {
                        if (value == MenuItems.save) {
                          controller.savePost(
                            postDoc: snapshot.id,
                          );
                        } else if (value == MenuItems.edit) {
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
                          value: MenuItems.save,
                          child: CustomText(
                            text: "Save",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItems.edit,
                          child: CustomText(
                            text: "Edit",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItems.delete,
                          child: CustomText(
                            text: "Delete",
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
                            postDoc: snapshot.id,
                          );
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: MenuItems.save,
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
                      ? InkWell(
                          child: Image.network(
                            "${snapshot.data()!['imageUrl']}",
                            fit: BoxFit.cover,
                          ),
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      snapshot.data()!['usersLiked']
                                  [controller.uid] ==
                              true
                          ? IconButton(
                              onPressed: () {
                                controller.handlePostLikes(
                                    currentPostDocData: snapshot);
                              },
                              icon: const Text(
                                "💗",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ))
                          : IconButton(
                              onPressed: () {
                                controller.handlePostLikes(
                                    currentPostDocData:snapshot);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.grey,
                              )),
                      const SizedBox(width: 20),
                      InkWell(
                        child: Text(
                          snapshot.data()!['likesCount']
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
                                    peopleWhoLiked: snapshot.data()!['usersLiked']
                                        .keys
                                        .toList(),
                                    currentDoc: snapshot.data()!['usersLiked'],
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
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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

            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
          ],
        ));
  }
}
