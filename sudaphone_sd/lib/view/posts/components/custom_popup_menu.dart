import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class CustomPopupMenu extends GetWidget<PostsViewModel> {
  const CustomPopupMenu(
      {Key? key, required this.ownerUid, required this.currentDocUid})
      : super(key: key);
  final String ownerUid;
  final String currentDocUid;

  @override
  Widget build(BuildContext context) {
    return ownerUid == controller.uid
        ? PopupMenuButton<MenuItems>(
            onSelected: (value) {
              if (value == MenuItems.save) {
                controller.savePost(
                  postDoc: currentDocUid,
                );
              } else if (value == MenuItems.edit) {
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
                        postDoc: currentDocUid,
                        text: controller.editingPostController.text);
                    Get.back();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              } else {
                controller.deletePost(currentDocUid);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItems.save,
                child: CustomText(
                  text: "Save",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuItem(
                value: MenuItems.edit,
                child: CustomText(
                  text: "Edit",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuItem(
                value: MenuItems.delete,
                child: CustomText(
                  text: "Delete",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : PopupMenuButton<MenuItems>(
            onSelected: (value) {
              if (value == MenuItems.save) {
                controller.savePost(
                  postDoc: currentDocUid,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MenuItems.save,
                child: CustomText(
                  text: "Save",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
  }
}
