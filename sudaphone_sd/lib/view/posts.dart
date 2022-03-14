import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/posts_pages/write_post.dart';
import 'package:sudaphone_sd/view/posts_widgets/card_view.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class Posts extends GetWidget<PostsViewModel> {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const WritePost(),
              curve: Curves.bounceInOut, transition: Transition.zoom);
        },
        child: const Icon(Icons.add , size:20),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.getData!.orderBy("dateTime" , descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Lottie.asset("assets/images/no_data.json")],
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.docs[index]['imageUrl']);
                print("======================================================");
                print(snapshot.data!.docs[index]['text']);
                print("======================================================");
                print(snapshot.data!.docs[index]['dateTime']);
                return  CardView(data: snapshot.data!.docs[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset("assets/images/create_post.json"),
            );
          } else {
            return Center(child: Lottie.asset("assets/images/bf_search.json"));
          }
        },
      ),
    );
  }
}
