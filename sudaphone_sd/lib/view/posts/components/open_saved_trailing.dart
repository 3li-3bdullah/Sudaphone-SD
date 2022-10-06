import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class OpenSavedTrailing extends GetWidget<PostsViewModel> {
  const OpenSavedTrailing( {required this.snapshot, Key? key}) : super(key: key);
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
    return snapshot.data!.data()!['ownerUid'] == controller.uid
        // FirebaseAuth.instance.currentUser!.uid
        ? PopupMenuButton<SavedItems>(
            onSelected: (value) {
              if (value == SavedItems.unsave) {
                controller.unSavePost(
                  postDoc: snapshot.data!.id,
                );        
              } else if (value == SavedItems.edit) {
                Get.defaultDialog(
                  title: "Edit the post",
                  titleStyle: const TextStyle(
                      color: Colors.brown, fontWeight: FontWeight.bold),
                  content: Form(
                    key: controller.editingPostKey,
                    child: CustomTextFormField(
                        obscure: false,
                        validator: (String name) {
                          if (name.trim().isEmpty) {
                            return "The field is empty";
                          }
                        },
                        icon: Icons.edit,
                        textEditingController:
                            controller.editingPostController),
                  ),
                  textConfirm: "Edit",
                  textCancel: "Cancel",
                  cancelTextColor: Colors.brown,
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.brown,
                  radius: 20.0,
                  onConfirm: () {
                    controller.editingPost(
                        editKey: controller.editingPostKey,
                        postDoc: snapshot.data!.id,
                        text: controller.editingPostController.text);
                    Get.back();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              } else {
                controller.deletePost(snapshot.data!.id);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: SavedItems.unsave,
                child: CustomText(
                  text: "Remove",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuItem(
                value: SavedItems.edit,
                child: CustomText(
                  text: "Edit",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuItem(
                value: SavedItems.delete,
                child: CustomText(
                  text: "Delete",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : PopupMenuButton<SavedItems>(
            onSelected: (value) {
              if (value == SavedItems.unsave) {
                controller.unSavePost(
                  postDoc: snapshot.data!.id,
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: SavedItems.unsave,
                child: CustomText2(
                  text: "Remove",
                  color: kBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
  }
}
