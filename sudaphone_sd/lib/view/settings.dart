import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/settings_widgets/custom_container.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

// ignore: must_be_immutable
class Settings extends GetWidget<SettingsViewModel> {
  Settings({Key? key}) : super(key: key);
  final controll = Get.find<ThemesViewModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: controller.getUserData
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.brown[200],
                              borderRadius: BorderRadius.all(Radius.circular(size.width))
                            ),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        "${snapshot.data?.data()!['profileUrl']}"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text:
                                          "${snapshot.data!.data()!['userName']}",
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: snapshot.data!.data()?['email'],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: snapshot.data!.data()?['registerTime'],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Lottie.asset("assets/lotties/loading.json");
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomContainer(
                  color: Colors.black,
                  ontap: () {
                    Get.defaultDialog(
                      title: "Edit your name",
                      titleStyle: const TextStyle(
                          color: Colors.brown, fontWeight: FontWeight.bold),
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
                            textEditingController: controller.textEditing),
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
                  text: "Change The Name",
                  icon: Icons.edit),
              const SizedBox(
                height: 10,
              ),
              CustomContainer(
                  color: Colors.black,
                  ontap: () {
                    SanckToUploadImages.showTheSnack(
                        gallery: controller.uploadProfilePic(source: "gallery"),
                        camera: controller.uploadProfilePic(source: "camera"));
                  },
                  text: "Change Profile Image",
                  icon: Icons.photo),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: size.height / 10,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: GetBuilder<ThemesViewModel>(
                    builder: (controll) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: controll.theme == ThemeMode.dark
                              ? "Dark Mode"
                              : "Light Mode",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.left,
                        ),
                        controll.theme == ThemeMode.dark
                            ? const Icon(
                                Icons.sunny,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.wb_sunny_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: controller.dark,
                                  groupValue: controller.groupValue,
                                  onChanged: (value) {
                                    controll.changeThemeMode(ThemeMode.dark);
                                    controll.saveTheme(true);
                                  },
                                  activeColor: Colors.brown,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: "Dark mode ",
                                  textAlign: TextAlign.justify,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: controller.light,
                                  groupValue: controller.groupValue,
                                  onChanged: (value) {
                                    controll.changeThemeMode(ThemeMode.light);
                                    controll.saveTheme(false);
                                  },
                                  activeColor: Colors.brown,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: "Light mode ",
                                  textAlign: TextAlign.justify,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomContainer(
                  color: Colors.black,
                  ontap: () {},
                  text: "Delete Account",
                  icon: Icons.delete),
              const SizedBox(
                height: 10,
              ),
              CustomContainer(
                  color: Colors.black,
                  ontap: () async {
                  await FirebaseAuth.instance.signOut();
                  },
                  text: "Logout",
                  icon: Icons.logout),
            ],
          ),
        ),
      ),
    );
  }
}
