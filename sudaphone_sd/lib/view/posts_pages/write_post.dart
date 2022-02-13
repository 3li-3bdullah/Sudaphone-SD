import 'package:flutter/material.dart';
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
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 20),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/slider/ali1.jpg"),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: const Text(
                    "Ali Abdullah",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Form(
                key: controller.postKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (valid) {
                        if (valid!.isEmpty) {
                          return "Please write somethings to post ...";
                        }
                      },
                      minLines: 2,
                      maxLines:10,
                      controller: controller.textEditing,
                      onSaved: (val) {
                        controller.text = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Write here ...",
                        filled: true,
                        isDense: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.all(5),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(style: BorderStyle.none)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
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
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.uploadFromCamera();
                      },
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      child: Row(
                        children: const [
                          Icon(Icons.photo_outlined,
                              color: Colors.green, size: 25),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.uploadFromGallery();
                      },
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        controller.addPost();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10) ,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        color: Colors.blue,
                        child: const Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "POST",
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* 
  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey))),
                        child: Row(children: [
                          IconButton(
                              icon: const Icon(Icons.camera_alt_outlined,
                                  color: Colors.purple),
                              onPressed: () {}),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: MediaQuery.of(context).size.width - 70,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "أكتب تعليقك هنا",
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.send_outlined,
                                          color: Colors.green.shade900),
                                      onPressed: () {}),
                                  contentPadding: const EdgeInsets.all(5),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide:
                                         const BorderSide(style: BorderStyle.none)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide:
                                         const BorderSide(style: BorderStyle.none)),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              )),
                        ]),
                      )
                    ]),
                  ),
*/
// 
/*
SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 5, left: 5, top: 10, bottom: 5),
                    child: Form(
                      key: controller.postKey,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        maxLength: 500,
                        maxLines: 10,
                        minLines: 1,
                        autocorrect: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please write somethings for publishing";
                          }
                        },
                        onChanged: (val) {
                          controller.text!.value = val;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Write somethings to post ..",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
*/