import 'dart:html';

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
          fontSize: 25,
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        itemCount: peopleWhoLiked.length,
        itemBuilder: (context, index) {
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.peopleWhoLikedReference
                .doc(peopleWhoLiked[index])
                .get(),
            builder: ((context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  title: CustomText(
                      text: "${snapshot.data?.data()!['userName']}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      textAlign: TextAlign.right),
                  trailing: CircleAvatar(
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
    );
  }
}
