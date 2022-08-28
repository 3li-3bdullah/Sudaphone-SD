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
import 'package:sudaphone_sd/view/widgets/custom_text2.dart';
import 'package:sudaphone_sd/view/widgets/leading.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Posts extends GetWidget<PostsViewModel> {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Posts",
          fontSize: 20,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        leading: const Leading(),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Get.to(() => const WritePost(),
              curve: Curves.bounceInOut, transition: Transition.zoom);
        },
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
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
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  // return CardView(data: snapshot.data!.docs[index]);
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${snapshot.data!.docs[index].data()['profileUrl']}"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: CustomText(
                                  text:
                                      "${snapshot.data!.docs[index].data()['userName']}",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              CustomText2(
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
                                        postDoc: snapshot.data!.docs[index].id,
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
                                              textEditingController: controller
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
                                              editKey:
                                                  controller.editingPostKey,
                                              postDoc:
                                                  snapshot.data!.docs[index].id,
                                              text: controller
                                                  .editingPostController.text);
                                          Get.back();
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      );
                                    } else {
                                      controller.deletePost(
                                          snapshot.data!.docs[index].id);
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
                                        postDoc: snapshot.data!.docs[index].id,
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
                                text: snapshot.data!.docs[index].data()['text'],
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
                                                image: snapshot
                                                    .data!.docs[index]
                                                    .data()['imageUrl']),
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
                                  snapshot.data!.docs[index]
                                                  .data()['usersLiked']
                                              [controller.uid] ==
                                          true
                                      ? IconButton(
                                          onPressed: () {
                                            controller.handlePostLikes(
                                                currentPostDocData:
                                                    snapshot.data!.docs[index]);
                                          },
                                          icon: Image.asset(
                                            "assets/icons/favorite.png",
                                            color: Colors.pink,
                                          ),
                                          //  const Text(
                                          //   "💗",
                                          //   style: TextStyle(
                                          //     fontSize: 25,
                                          //   ),
                                          // ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            controller.handlePostLikes(
                                                currentPostDocData:
                                                    snapshot.data!.docs[index]);
                                          },
                                          icon: Image.asset(
                                            "assets/icons/favorite.png",
                                            color: Colors.brown,
                                          ),
                                        ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .data()['likesCount']
                                            .toString(),
                                        key: ValueKey(
                                          snapshot.data!.docs[index]
                                              .data()['likesCount']
                                              .toString(),
                                        ),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: snapshot.data!.docs[index]
                                                                .data()[
                                                            'usersLiked']
                                                        [controller.uid] ==
                                                    true
                                                ? Colors.pink
                                                : Colors.grey.shade600),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(
                                          () => PeopleHaveLiked(
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
                                                snapshot.data!.docs[index],
                                          ));
                                    },
                                    icon: Image.asset(
                                        "assets/icons/comment1.png",
                                        color: Colors.green),
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
                                      return CustomText2(
                                        text: "${snapshot.data?.docs.length}",
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                  ),
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
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    height: controller.size.height,
                    width: controller.size.width,
                    alignment: Alignment.center,
                    child: Lottie.asset("assets/lotties/no_data.json"),
                  );
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
