import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class Comments extends GetWidget<PostsViewModel> {
  Comments({Key? key, this.firstCollection, this.secondCollection})
      : super(key: key);
  var firstCollection;
  var secondCollection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(firstCollection.id)
              .collection("userPosts")
              .doc(secondCollection.id)
              .collection("comments")
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  color: Colors.grey.shade200,
                                ),
                                child: ListTile(
                                  title: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "${firstCollection.data()['userName']}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data?.docs[index]['text']}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade800),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${firstCollection.data()['profileUrl']}"),
                                radius: 20,
                              ),
                            ],
                          ),
                          snapshot.data?.docs[index]['isThereImageUrl'] == true
                              ? InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => DownloadImages(
                                            image: snapshot.data!.docs[index]
                                                ['imageUrl']),
                                        transition: Transition.zoom,
                                        curve: Curves.easeInExpo);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Image.network(
                                      snapshot.data!.docs[index]['imageUrl']
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(
                                  "${snapshot.data?.docs[index]['dateTime'].toString()}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: snapshot.data?.docs[index]['usersLiked']
                                            ['${controller.uid}'] !=
                                        true
                                    ? const CustomText(
                                        text: "Like",
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center)
                                    : const CustomText(
                                        text: "Like",
                                        color: Colors.pink,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center),
                                onTap: () {
                                  controller.handleCommentLikes(
                                      firstCollectionDocs: firstCollection,
                                      secondCollectionDocs: secondCollection,
                                      docSnapshot: snapshot.data?.docs[index]);
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: snapshot.data?.docs[index]['usersLiked']
                                            ['${controller.uid}'] !=
                                        true
                                    ? CustomText(
                                        text:
                                            "${snapshot.data?.docs[index]['likesCount']}",
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center)
                                    : CustomText(
                                        text:
                                            "${snapshot.data?.docs[index]['likesCount']}",
                                        color: Colors.pink,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center),
                              )
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 40),
                          //   child: Text(
                          //     "${snapshot.data?.docs[index]['dateTime'].toString()}",
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border:
                                Border(top: BorderSide(color: Colors.grey))),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined,
                                  color: Colors.purple),
                              onPressed: () {
                                Get.defaultDialog(
                                  content: const CustomText(
                                    text: "Choose an image from : ",
                                    textAlign: TextAlign.center,
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  title: "Upload",
                                  textCancel: "Gallery",
                                  textConfirm: "Camera",
                                  onCancel: () {
                                    controller.uploadImageToComment(
                                        source: "gallery");
                                  },
                                  onConfirm: () {
                                    controller.uploadImageToComment(
                                        source: "camera");
                                  },
                                );
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: MediaQuery.of(context).size.width - 70,
                              child: Form(
                                key: controller.commentKey,
                                child: TextFormField(
                                  controller: controller.commentController,
                                  decoration: InputDecoration(
                                    hintText: "Write a comment here ...",
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.send_outlined,
                                          color: Colors.blue),
                                      onPressed: () {
                                        controller.addComment(
                                            collectionOne: firstCollection,
                                            collectionTwo: secondCollection,
                                            commentKey: controller.commentKey,
                                            text: controller
                                                .commentController.text);
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.all(5),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.none),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: const BorderSide(
                                          style: BorderStyle.none),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
