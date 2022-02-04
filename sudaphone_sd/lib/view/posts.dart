import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/model/posts_model.dart';
import 'package:sudaphone_sd/view/posts_pages/write_post.dart';
import 'package:sudaphone_sd/view/posts_widgets/card_view.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class Posts extends GetWidget<PostsViewModel> {
   Posts({Key? key}) : super(key: key);
  PostsViewModel x = Get.put(PostsViewModel());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Posts"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => const WritePost(), transition: Transition.upToDown);
            },
            label: const Text("add"),
            icon: const Icon(Icons.add),
          ),
          body: GetBuilder<PostsViewModel>(
            builder: (controller) => ListView.builder(
              itemCount: controller.dataList.length,
              itemBuilder: (context, i) {
                return CardView(
                    controller: controller,
                    postsModel: controller.dataList[i] as PostsModel);
              },
            ),
          )),
    );
  }
}
