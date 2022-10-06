import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/view/people_have_liked/people_have_liked.dart';
import 'package:sudaphone_sd/view/posts/components/comment_button.dart';
import 'package:sudaphone_sd/view/posts/components/custom_popup_menu.dart';
import 'package:sudaphone_sd/view/posts/components/post_subtitle.dart';
import 'package:sudaphone_sd/view/posts/components/post_title.dart';
import 'package:sudaphone_sd/view/posts/write_post.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Posts extends GetWidget<PostsViewModel> {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Posts", underLineWidget: 40),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Get.to(() => const WritePost(),
              curve: Curves.bounceInOut, transition: Transition.zoom);
        },
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.postsCollections
            .orderBy("dateTime", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${snapshot.data!.docs[index].data()['profileUrl']}"),
                          ),
                          title:
                              PostTitle(currentDoc: snapshot.data!.docs[index]),
                          trailing: CustomPopupMenu(
                              ownerUid:
                                  snapshot.data!.docs[index].data()['ownerUid'],
                              currentDocUid: snapshot.data!.docs[index].id),
                          subtitle: PostSubtitle(
                              currentDoc: snapshot.data!.docs[index]),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2)),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                           controller.handlePostLikes(
                                              currentPostDocData:
                                                  snapshot.data!.docs[index]);
                                    },
                                    icon: Image.asset(
                                      "assets/images/like.png",
                                      color: snapshot.data!.docs[index]
                                                  .data()['usersLiked']
                                              [controller.uid] != null
                                          ? snapshot.data!.docs[index]
                                                      .data()['usersLiked']
                                                  [controller.uid]
                                              ? Colors.pink
                                              : Colors.brown
                                          : Colors.brown,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .data()['likesCount']
                                            .toString(),
                                        key: ValueKey(
                                          snapshot.data!.docs[index]
                                              .data()['likesCount']
                                              .toString(),
                                        ),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: snapshot.data!.docs[index]
                                                  .data()['usersLiked']
                                              [controller.uid] != null
                                          ? snapshot.data!.docs[index]
                                                      .data()['usersLiked']
                                                  [controller.uid]
                                              ? Colors.pink
                                              : Colors.grey.shade600
                                          : Colors.grey.shade600,
                                                ),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(
                                          () => PeopleHaveLiked(
                                                peopleWhoLiked: snapshot
                                                    .data!.docs[index]
                                                    .data()['usersLiked']
                                                    .keys
                                                    .toList(),
                                                currentDoc: snapshot
                                                    .data!.docs[index]
                                                    .data()['usersLiked'],
                                              ),
                                          transition: Transition.zoom);
                                    },
                                  )
                                ],
                              ),
                            ),
                            CommentButton(
                                currentDoc: snapshot.data!.docs[index]),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/loader.gif'));
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    height: controller.size.height,
                    width: controller.size.width,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/loader.gif'),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.brown,
                  ));
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: CustomText2(
              text: "${snapshot.error}",
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Image.asset('assets/images/loader.gif'));
          } else if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Lottie.asset("assets/images/no_data.json")],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
