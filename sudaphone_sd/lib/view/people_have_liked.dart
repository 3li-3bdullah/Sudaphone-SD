import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class PeopleHaveLiked extends GetWidget<PostsViewModel> {
  const PeopleHaveLiked(
      {required this.peopleWhoLiked, required this.currentDoc, Key? key})
      : super(key: key);
  final List<String> peopleWhoLiked;
  final Map<String, dynamic> currentDoc;
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: peopleWhoLiked.length,
        itemBuilder: (context, index) {
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                controller.userInfoCollection.doc(peopleWhoLiked[index]).get(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                if (currentDoc[peopleWhoLiked[index]]) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 2, top: 10),
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
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "${snapshot.data!.data()!['profileUrl']}"),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomText(
                      text: snapshot.error.toString(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.center),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Lottie.asset("assets/lotties/loading.json"),
                );
              }
            }),
          );
        },
      ),
    );
  }
}
