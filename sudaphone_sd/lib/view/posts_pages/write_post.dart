import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class WritePost extends GetWidget<PostsViewModel> {
  const WritePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Post",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
                future: controller.userInfoCollection.doc(controller.uid.toString()).get(),
                builder: (context,snapshot){
                  return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 20),
                    /* 
                    This circleAvatar now i dont need it.
                    */
                    child:  CircleAvatar(
                      backgroundImage:
                          NetworkImage("${snapshot.data!.data()?['profileUrl']}"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child:  Text(
                      "${snapshot.data?.data()!['userName']}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              );
                }
                ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Form(
                  key: controller.postKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (valid) {
                          return controller.isValid(valid);
                        },
                        minLines: 5,
                        maxLines: 10,
                        controller: controller.textController,
                        decoration: InputDecoration(
                          hintText: "Write here ...",
                          filled: true,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        child: Row(
                          children: const [
                            Icon(Icons.camera_alt_outlined,
                                color: Colors.pink, size: 25),
                                SizedBox(width: 10,),
                            Text(
                              "From Camera",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.uploadImage("camera");
                        },
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        child: Row(
                          children: const [
                            Icon(Icons.photo_outlined,
                                color: Colors.green, size: 25),
                                SizedBox(width: 10,),
                            Text(
                              "From Gallery",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.uploadImage("gallery");
                        },
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16), color: Colors.brown),
                          child: Text(
                            "POST",
                            style: textButton.copyWith(color: kWhiteColor),
                          ),
                        ),
                        onTap: ()=>  controller.addPost(controller.textController!.text , controller.postKey,),
                      )
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}