import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/settings/components/custom_row.dart';
import 'package:sudaphone_sd/view/settings/components/settings_profile.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

import '../../shared/components/custom_leading.dart';

// ignore: must_be_immutable
class Setting extends GetWidget<SettingsViewModel> {
  Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(
            text: "Settings", underLineWidget: 50, showUnderLine: false),
        leading: ScreensLeading(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SettingsProfile(),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<PublicData>(
              builder: (control) => GetBuilder<ThemesViewModel>(
                builder: (themeController) => CustomRow(
                  name: "Edit Name",
                  imagePath: "assets/icons/write.png",
                  onTap: () => Get.defaultDialog(
                    title: "Edit your name",
                    titleStyle: TextStyle(
                        color: themeController.theme == ThemeMode.dark
                            ? Colors.white
                            : kBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    content: Form(
                      key: controller.editingKey,
                      child: CustomTextFormField(
                          obscure: false,
                          maxLength: 25,
                          textColor: themeController.theme == ThemeMode.dark
                              ? Colors.white
                              : Colors.black45,
                          validator: (String name) {
                            if (name.trim().isEmpty) {
                              return "The field is empty";
                            }
                          },
                          iconColor: themeController.theme == ThemeMode.dark
                              ? Colors.grey
                              : Colors.brown.shade600,
                          icon: Icons.person,
                          textEditingController: controller.textEditing!),
                    ),
                    textConfirm: "Update",
                    textCancel: "Cancel",
                    cancelTextColor: themeController.theme == ThemeMode.dark
                        ? Colors.white
                        : kBlackColor,
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.brown.shade300,
                    radius: 20.0,
                    backgroundColor: themeController.theme == ThemeMode.dark
                        ? kDark1
                        : Colors.white,
                    onConfirm: () async {
                      await controller.modifyUserName(
                          name: controller.textEditing!.text,
                          textKey: controller.editingKey);
                      Navigator.of(context).pop();
                      control.userInfo();
                    },
                    onCancel: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<ThemesViewModel>(
                builder: (controll) => Row(
                  children: [
                    SizedBox(
                        height: Get.height / 25,
                        child: Image.asset(controll.theme == ThemeMode.dark
                            ? "assets/icons/moon.png"
                            : "assets/icons/sun.png")),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      controll.theme == ThemeMode.dark
                          ? "Dark Mode"
                          : "Light Mode",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GetBuilder<ThemesViewModel>(
                      builder: (controller) {
                        return Transform.scale(
                          scale: 0.9,
                          child: CupertinoSwitch(
                            value: controller.loadTheme(),
                            onChanged: (value) {
                              if (controller.loadTheme()) {
                                controll.changeThemeMode(ThemeMode.light);
                                controll.saveTheme(false);
                              } else {
                                controll.changeThemeMode(ThemeMode.dark);
                                controll.saveTheme(true);
                              }
                            },
                          ),
                        );
                      },
                    ),
                    // const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            CustomRow(
              name: "Change Profile",
              imagePath: "assets/icons/gallery1.png",
              onTap: () => Get.defaultDialog(
                content: const CustomText2(
                  text: "Upload an image from : ",
                  textAlign: TextAlign.center,
                  color: Colors.brown,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                title: "",
                textCancel: "Gallery",
                textConfirm: "Camera",
                onCancel: () {
                  controller.uploadProfilePic(source: "gallery");
                },
                onConfirm: () {
                  controller.uploadProfilePic(source: "camera");
                },
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.brown,
                buttonColor: Colors.brown,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            CustomRow(
              name: "Log Out",
              imagePath: "assets/icons/exit.png",
              onTap: () => Get.defaultDialog(
                title: "Are you sure ?",
                middleText: "",
                backgroundColor: Colors.white30,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                middleTextStyle:
                    TextStyle(color: Colors.grey.shade800, fontSize: 18),
                textConfirm: "Yes",
                textCancel: "No",
                buttonColor: Colors.white,
                confirmTextColor: Colors.brown,
                cancelTextColor: Colors.white,
                onConfirm: () async {
                  await controller.signOut();
                  //  Get.offUntil( MaterialPageRoute(builder: (_) => const SignIn()), (route) => false);
                },
                onCancel: () {
                  Get.back();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            CustomRow(
              name: "Delete Acount",
              imagePath: "assets/icons/trash.png",
              onTap: () => Get.defaultDialog(
                title: "Are you sure dude 😦?",
                middleText: "",
                backgroundColor: Colors.white30,
                titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                middleTextStyle:
                    TextStyle(color: Colors.grey.shade800, fontSize: 18),
                textConfirm: "Yes 😞",
                textCancel: "No 😜",
                buttonColor: Colors.white,
                confirmTextColor: Colors.brown,
                cancelTextColor: Colors.white,
                onConfirm: () {
                  controller.deleteAcount();
                },
                onCancel: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
