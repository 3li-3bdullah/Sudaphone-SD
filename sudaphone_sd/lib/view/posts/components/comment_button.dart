import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view/posts/comments.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class CommentButton extends GetWidget<PostsViewModel> {
  const CommentButton({Key? key, required this.currentDoc}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> currentDoc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => Comments(
                    firstDocSnapshot: currentDoc,
                  ));
            },
            icon: Image.asset("assets/icons/comment1.png", color: Colors.green),
          ),
          const SizedBox(width: 10),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .doc(currentDoc.id)
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
    );
  }
}
