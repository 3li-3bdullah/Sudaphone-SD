import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/posts/components/choose_image_icon.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';

class WritePost extends GetWidget<PostsViewModel> {
  const WritePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Create Post", underLineWidget: 70),
        leading: const Leading(),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<PublicData>(
                builder: (control) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8, top: 20),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${control.getProfileUrl}"),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        control.getUserName.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(
                          hintText: "Write here ...",
                          filled: true,
                          isDense: true,
                          fillColor: kTextFieldColor,
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
                      ChooseImageIcon(
                        text: "From Camera",
                        icon: Icons.camera_alt_outlined,
                        color: Colors.pink,
                        ontap: () => controller.uploadImage("camera"),
                      ),
                      const SizedBox(height: 5),
                      ChooseImageIcon(
                          text: "From Gallery",
                          ontap: () => controller.uploadImage("gallery"),
                          icon: Icons.photo_outlined,
                          color: Colors.green),
                      const SizedBox(height: 15),
                      GetBuilder<PublicData>(
                        builder: (control) => InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.brown),
                            child: Text(
                              "POST",
                              style: textButton.copyWith(color: kWhiteColor),
                            ),
                          ),
                          onTap: () => controller.addPost(
                            username: control.getUserName,
                            profileurl: control.getProfileUrl,
                            text: controller.textController!.text,
                            textFieldkey: controller.postKey,
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
      ),
    );
  }
}
