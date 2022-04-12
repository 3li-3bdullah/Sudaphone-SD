import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class PostPeopleLiked extends GetWidget<PostsViewModel> {
  PostPeopleLiked({required this.peopleWhoLiked,required this.currentDoc, Key? key}) : super(key: key);
  var peopleWhoLiked;
  var currentDoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "People who liked",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios , color: Colors.black,),
        ),
      ),
      body: ListView.builder(
        itemCount: peopleWhoLiked.length,
        itemBuilder: (context, index) {
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.peopleWhoLikedReference
                .doc("${peopleWhoLiked[index]}")
                .get(),
            builder: ((context, snapshot) {
              if(currentDoc['${peopleWhoLiked[index]}']){
                return Padding(
                padding: const EdgeInsets.only(left: 2,top: 10),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomText(
                        text: "${snapshot.data?.data()!['userName']}",
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        textAlign: TextAlign.left),
                  ),
                  // leading: CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage:
                  //       NetworkImage(snapshot.data?.data()!['profileUrl']),
                  // ),
                ),
              );
              } else {
                return const SizedBox();
              }
            }),
          );
        },
      ),
    );
  }
}
