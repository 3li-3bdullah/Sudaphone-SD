import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';

class Settings extends GetWidget<SettingsViewModel> {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Settings',
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
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: controller.getUserData.doc("${controller.uid}").get(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      InkWell(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                "${snapshot.data?.data()?['profileUrl']}"),
                          ),
                        ),
                        onTap: () {
                          SanckToUploadImages.showTheSnack(
                              gallery: controller.uploadProfilePic(
                                  source: "gallery"),
                              camera: controller.uploadProfilePic(
                                  source: "camera"));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: CustomText(
                          text: "${snapshot.data?.data()?['userName']}",
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Get.defaultDialog(
                            title: "Edit your name",
                            titleStyle: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                            content: Form(
                              key: controller.editingKey,
                              child: CustomTextFormField(
                                  obscure: false,
                                  validator: (String name) {
                                    if (name.trim().isEmpty) {
                                      return "The field is empty";
                                    }
                                  },
                                  icon: Icons.person,
                                  textEditingController:
                                      controller.textEditing),
                            ),
                            textConfirm: "Update",
                            textCancel: "Cancel",
                            cancelTextColor: Colors.brown,
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.brown,
                            radius: 20.0,
                            onConfirm: () {
                              controller.modifyUserName(
                                  name: controller.textEditing.text,
                                  textKey: controller.editingKey);
                            },
                            onCancel: () {
                              Get.back();
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: "${snapshot.data?.data()!['email']}",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }),
            // ListTile(
            //   title: const Text("The Mode"),
            //   trailing: const Icon(Icons.wb_sunny),
            //   onTap: () {
            //     Get.bottomSheet(Column(
            //       children: [
            //         ListTile(
            //           title: const Text("Light Mode"),
            //           leading: const Icon(Icons.wb_sunny_outlined),
            //           onTap: () {
            //             Get.changeTheme(ThemeData.light());
            //           },
            //         ),
            //         ListTile(
            //           title: const Text("Dark Mode"),
            //           leading: const Icon(Icons.wb_sunny),
            //           onTap: () {
            //             Get.changeTheme(ThemeData.dark());
            //           },
            //         ),
            //       ],
            //     ));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
