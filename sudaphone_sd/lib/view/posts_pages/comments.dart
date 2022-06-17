import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/posts_pages/show_comment_likes.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class Comments extends GetWidget<PostsViewModel> {
  Comments({Key? key, this.firstDocSnapshot})
      : super(key: key);
  var firstDocSnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "${firstDocSnapshot.data()['userName']}'s post",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            textAlign: TextAlign.center),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(firstDocSnapshot.id)
              .collection("comments")
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                future: controller.userInfoCollection.doc(snapshot.data?.docs[index]['ownerUid']).get(),
                                builder: (context,_snapshot){
                                  return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${_snapshot.data!.data()?['profileUrl']}"),
                                    radius: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: ListTile(
                                      title: CustomText(
                                        text:
                                            "${_snapshot.data!.data()?['userName']}",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        textAlign: TextAlign.left,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "${snapshot.data?.docs[index]['text']}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                                }),
                              snapshot.data?.docs[index]['isThereImageUrl'] ==
                                      true
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => DownloadImages(
                                                image: snapshot.data!
                                                    .docs[index]['imageUrl']),
                                            transition: Transition.zoom,
                                            curve: Curves.easeInExpo);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                5),
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
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: snapshot.data?.docs[index]
                                                    ['usersLiked']
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
                                          firstCollectionDocs: firstDocSnapshot,
                                          docSnapshot:
                                              snapshot.data?.docs[index]);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: snapshot.data?.docs[index]
                                                    ['usersLiked']
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
                                    onTap: () {
                                      Get.to(
                                          () => ShowCommentLikes(
                                                peopleWhoLiked: snapshot
                                                    .data
                                                    ?.docs[index]['usersLiked']
                                                    .keys
                                                    .toList(),
                                                currentDoc: snapshot.data
                                                    ?.docs[index]['usersLiked'],
                                              ),
                                          transition: Transition.zoom);
                                    },
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
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
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
                                              collectionOne: firstDocSnapshot,
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Lottie.asset("assets/images/loading.json"),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                      text: "Oops",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      textAlign: TextAlign.center),
                  CustomText(
                      text: snapshot.hasError.toString(),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      textAlign: TextAlign.center),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
