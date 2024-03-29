import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_leading.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class ShowCommentLikes extends GetWidget<PostsViewModel> {
  const ShowCommentLikes(
      {required this.peopleWhoLiked, required this.currentDoc, Key? key})
      : super(key: key);
  final peopleWhoLiked;
  final currentDoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "People who liked", underLineWidget: 80),
        elevation: 0,
        leading: const ScreensLeading(),
      ),
      body: ListView.builder(
        itemCount: peopleWhoLiked.length,
        itemBuilder: (context, index) {
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                controller.userInfoCollection.doc(peopleWhoLiked[index]).get(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (currentDoc['${peopleWhoLiked[index]}']) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomText(
                            text: "${snapshot.data!.data()!['userName']}",
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.left),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(snapshot.data?.data()!['profileUrl']),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/images/loader.gif'));
              }
            }),
          );
        },
      ),
    );
  }
}
