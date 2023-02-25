import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

import '../../../view_model/themes_view_model.dart';

class CustomPopupMenu extends GetWidget<PostsViewModel> {
  const CustomPopupMenu(
      {Key? key,
      required this.ownerUid,
      required this.oldPostText,
      required this.currentDocUid})
      : super(key: key);
  final String ownerUid;
  final String currentDocUid;
  final String oldPostText;

  @override
  Widget build(BuildContext context) {
    return ownerUid == controller.uid
        ? GetBuilder<ThemesViewModel>(
            builder: (themeController) => PopupMenuButton<MenuItems>(
              onSelected: (value) {
                if (value == MenuItems.save) {
                  controller.savePost(
                    postDoc: currentDocUid,
                  );
                } else if (value == MenuItems.edit) {
                  controller.editingPostController.text = oldPostText;
                  Get.defaultDialog(
                    title: "Edit the post",
                    backgroundColor: themeController.theme == ThemeMode.dark
                        ? kDark2
                        : Colors.white,
                    titleStyle: const TextStyle(
                        color: Color.fromRGBO(161, 136, 127, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    content: Form(
                      key: controller.editingPostKey,
                      child: CustomTextFormField(
                          obscure: false,
                          maxLine: 5,
                          textColor: themeController.theme == ThemeMode.dark
                              ? Colors.grey
                              : kBlackColor,
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
                    cancelTextColor: Colors.brown.shade300,
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.brown.shade300,
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
            ),
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
