import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class ShowCommentLikes extends GetWidget<PostsViewModel> {
  ShowCommentLikes({required this.peopleWhoLiked, Key? key}) : super(key: key);
  var peopleWhoLiked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "People who liked",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios , color: Colors.black,),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        
        child: ListView.builder(
          itemCount: peopleWhoLiked.length,
          itemBuilder: (context, index) {
            print(peopleWhoLiked[index].toString());
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection("posts")
                  .doc("${peopleWhoLiked[index]}")
                  .get(),
              builder: ((context, snapshot) {
            print("===============================uuuuu====================================");
            print("${snapshot.data?.data()!['userName']}");
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: CustomText(
                        text: "${snapshot.data?.data()!['userName']}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.left),
                   leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data?.data()!['profileUrl']),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
