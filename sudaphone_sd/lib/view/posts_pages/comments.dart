import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              .snapshots(),
          builder: (context, snapshot) {
            controller.commentsCountOfPost(
                data: snapshot.data?.docs.length.toInt());
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            // ListTile(
                            //   title: Text(
                            //     "${firstCollection.data()['userName']}",
                            //     style: const TextStyle(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black),
                            //   ),
                            //   leading: firstCollection.data()['profileUrl'] != null ? const CircleAvatar(
                            //       backgroundImage: AssetImage(
                            //           "assets/images/slider/ali1.jpg"),
                            //       radius: 20,
                            //     ) : const CircleAvatar(
                            //       child: Icon(Icons.person ,color: Colors.white,),
                            //       radius: 20,
                            //       backgroundColor: Colors.grey,
                            //     ),

                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  const SizedBox(
                                  width: 5,
                                ),
                                const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/images/slider/ali1.jpg"),
                                  radius: 20,
                                ),
                                Container(
                                  // Try to remove this after testing
                                  height: 50,
                                  // width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${firstCollection.data()['userName']}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      "${snapshot.data?.docs[index]['text']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                              
                              ],
                            ),
                            snapshot.data?.docs[index]['isThereImageUrl'] ==
                                    true
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                       snapshot
                                            .data!.docs[index]['imageUrl'] != null ? Image.network(snapshot
                                            .data!.docs[index]['imageUrl']
                                            .toString()) : const SizedBox(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CustomText(
                                          text: snapshot
                                              .data!.docs[index]['dateTime']
                                              .toString(),
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
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
                                SanckToUploadImages.showTheSnack(
                                    gallery: controller.uploadImageToComment(
                                        source: "gallery"),
                                    camera: controller.uploadImageToComment(
                                        source: "camera"));
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
