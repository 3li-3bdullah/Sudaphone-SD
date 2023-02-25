import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/posts/comments.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

import '../../../view_model/themes_view_model.dart';

class CommentButton extends GetWidget<PostsViewModel> {
  const CommentButton(
      {Key? key, required this.userName, required this.currentDoc})
      : super(key: key);
  final String currentDoc;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => Comments(
                    currentDoc: currentDoc,
                    userName: userName,
                  ));
            },
            icon: Image.asset("assets/icons/comment1.png", color: Colors.green),
          ),
          const SizedBox(width: 10),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .doc(currentDoc)
                .collection("comments")
                .snapshots(),
            builder: (context, snapshot) {
              return GetBuilder<ThemesViewModel>(
                builder: (themeController) {
                  return CustomText2(
                    text: "${snapshot.data?.docs.length}",
                    color: themeController.theme == ThemeMode.dark
                        ? Colors.white
                        : kBlackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
