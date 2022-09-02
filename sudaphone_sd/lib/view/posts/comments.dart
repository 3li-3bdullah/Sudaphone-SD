import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
import 'package:sudaphone_sd/view/posts/show_comment_likes.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

// ignore: must_be_immutable
class Comments extends GetWidget<PostsViewModel> {
  const Comments({Key? key, required this.firstDocSnapshot}) : super(key: key);
  final firstDocSnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: "${firstDocSnapshot.data()['userName']}'s post",
            fontSize: 20,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center),
        centerTitle: true,
        elevation: 0,
        leading: const Leading(),
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
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${snapshot.data!.docs[index].data()['profileUrl']}"),
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
                                      title: CustomText2(
                                        text:
                                            "${snapshot.data!.docs[index].data()['userName']}",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.left,
                                        color: Colors.black,
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
                              ),
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
                                    child: CustomText(
                                      text:
                                          "${snapshot.data?.docs[index]['dateTime'].toString()}",
                                      textAlign: TextAlign.center,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: snapshot.data?.docs[index]
                                                    ['usersLiked']
                                                [controller.uid] !=
                                            true
                                        ? const CustomText2(
                                            text: "Like",
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center)
                                        : const CustomText2(
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
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                          "${snapshot.data?.docs[index]['likesCount']}",
                                          style: TextStyle(
                                            color: snapshot.data?.docs[index]
                                                            ['usersLiked']
                                                        [controller.uid] !=
                                                    true
                                                ? Colors.grey
                                                : Colors.pink,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          key: ValueKey(
                                              "${snapshot.data?.docs[index]['likesCount']}"),
                                          textAlign: TextAlign.center),
                                    ),
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
                                    color: kPrimaryColor),
                                onPressed: () {
                                  Get.defaultDialog(
                                    content: const CustomText2(
                                      text: "Choose an image from : ",
                                      textAlign: TextAlign.center,
                                      color: Colors.brown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    titleStyle:
                                        const TextStyle(color: Colors.brown),
                                    buttonColor: Colors.brown,
                                    cancelTextColor: Colors.brown,
                                    confirmTextColor: Colors.white,
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
                                  child: GetBuilder<ThemesViewModel>(
                                    builder: (contorller) => TextFormField(
                                      controller: controller.commentController,
                                      decoration: InputDecoration(
                                        hintText: "Write a comment here ...",
                                        hintStyle: TextStyle(
                                            color: contorller.theme ==
                                                    ThemeMode.dark
                                                ? Colors.black
                                                : Colors.white),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        suffixIcon: FutureBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                          future: FirebaseFirestore.instance
                                              .collection("usersInfo")
                                              .doc(controller.uid)
                                              .get(),
                                          builder: (context, _snapshot) =>
                                              IconButton(
                                            icon: const Icon(
                                                Icons.send_outlined,
                                                color: Colors.brown),
                                            onPressed: () async {
                                              await controller.addComment(
                                                collectionOne: firstDocSnapshot,
                                                commentKey:
                                                    controller.commentKey,
                                                text: controller
                                                    .commentController.text,
                                                username: _snapshot.data!
                                                    .data()!['userName'],
                                                profileurl: _snapshot.data!
                                                    .data()!['profileUrl'],
                                              );
                                            },
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          borderSide: const BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          borderSide: const BorderSide(
                                              style: BorderStyle.none),
                                        ),
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
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
                child: Lottie.asset("assets/lotties/loading.json"),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: "Oops",
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      textAlign: TextAlign.center),
                  CustomText(
                      text: snapshot.hasError.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      textAlign: TextAlign.center),
                ],
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Lottie.asset("assets/lotties/loading.json"),
              );
            }
          },
        ),
      ),
    );
  }
}
