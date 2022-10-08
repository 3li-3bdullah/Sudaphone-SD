import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: GetBuilder<PostsViewModel>(
        builder: (controller) => controller.loading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Image.asset('assets/images/loader.gif'))
            : RefreshIndicator(
                onRefresh: () => controller.retrievePostsData(),
                color: Colors.white,
                backgroundColor: Colors.brown,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listOfPostModel.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${controller.listOfPostModel[index].profileUrl}"),
                            ),
                            title: PostTitle(
                              dateTime:
                                  controller.listOfPostModel[index].dateTime,
                              userName:
                                  controller.listOfPostModel[index].userName,
                            ),
                            trailing: CustomPopupMenu(
                                ownerUid:
                                    controller.listOfPostModel[index].ownerUid,
                                currentDocUid: controller
                                    .listOfPostModel[index].currentDocUid),
                            subtitle: PostSubtitle(
                              imageUrl:
                                  controller.listOfPostModel[index].imageUrl,
                              isThereImageUrl: controller
                                  .listOfPostModel[index].isThereImageUrl,
                              text: controller.listOfPostModel[index].text,
                            ),
                          ),
                          Divider(color: Colors.grey.withOpacity(0.2)),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.postsCollections
                                  .doc(controller
                                      .listOfPostModel[index].currentDocUid)
                                  .snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.handlePostLikes(
                                                    currentDocUid:
                                                        snapshot.data!.id,
                                                    likesCount: snapshot
                                                        .data!['likesCount']);
                                              },
                                              icon: Image.asset(
                                                "assets/images/like.png",
                                                color: snapshot.data![
                                                                'usersLiked']
                                                            [controller.uid] !=
                                                        null
                                                    ? snapshot.data![
                                                                    'usersLiked']
                                                                [controller
                                                                    .uid] ==
                                                            true
                                                        ? Colors.pink
                                                        : Colors.brown
                                                    : Colors.brown,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                transitionBuilder:
                                                    (Widget child,
                                                        Animation<double>
                                                            animation) {
                                                  return ScaleTransition(
                                                    scale: animation,
                                                    child: child,
                                                  );
                                                },
                                                child: Text(
                                                  snapshot.data!['likesCount']
                                                      .toString(),
                                                  key: ValueKey(
                                                    snapshot.data!['likesCount']
                                                        .toString(),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: snapshot.data![
                                                                    'usersLiked']
                                                                [controller
                                                                    .uid] !=
                                                            null
                                                        ? snapshot.data![
                                                                        'usersLiked']
                                                                    [controller
                                                                        .uid] ==
                                                                true
                                                            ? Colors.pink
                                                            : Colors
                                                                .grey.shade600
                                                        : Colors.grey.shade600,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Get.to(
                                                    () => PeopleHaveLiked(
                                                          peopleWhoLiked: snapshot
                                                              .data![
                                                                  'usersLiked']
                                                              .keys
                                                              .toList(),
                                                          currentDoc:
                                                              snapshot.data![
                                                                  'usersLiked'],
                                                        ),
                                                    transition:
                                                        Transition.zoom);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      CommentButton(
                                        currentDoc: snapshot.data!.id,
                                        userName: snapshot.data!['userName'],
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              })),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
