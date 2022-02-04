import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class WritePost extends GetWidget<PostsViewModel> {
  const WritePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsViewModel>(
      builder: (controller) => Card(
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/slider/ali.jpg"),
                ),
                Form(
                  key: controller.postKey,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    maxLength: 500,
                    maxLines: 10,
                    autocorrect: true,
                    minLines: 1,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Please write somethings for publishing";
                      }
                    },
                    onSaved: (val) {
                      controller.text = val;
                    },
                    decoration: InputDecoration(
                        suffix: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () {
                            Get.bottomSheet(
                              SizedBox(
                                height: 180,
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.blue),
                                      title: const Text("From Camera"),
                                      onTap: () {
                                        controller.uploadFromCamera();
                                      },
                                    ),
                                    ListTile(
                                        trailing: const Icon(
                                            Icons.photo_outlined,
                                            color: Colors.blue),
                                        title: const Text("From Gallery"),
                                        onTap: () {
                                          controller.uploadFromGallery();
                                        }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Write here...",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                controller.addPost();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CustomText(
                      text: "POST",
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
