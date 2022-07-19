import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/posts.dart';
import 'package:sudaphone_sd/view/settings_widgets/custom_container.dart';
import 'package:sudaphone_sd/view/signin.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

// ignore: must_be_immutable
class Settings extends GetWidget<SettingsViewModel> {
  final controll = Get.find<ThemesViewModel>();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
              
            ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const Posts());
                },
                icon: const Icon(Icons.post_add, color: Colors.white))
          ],
          centerTitle: true,
          elevation: 0,
         backgroundColor:  Colors.brown.withOpacity(.5),
          ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: controller.getUserData
                      .doc(controller.auth!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.brown[200],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
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
                                      text: snapshot.data!
                                          .data()?['registerTime'],
                                      fontSize: 17,
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
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: size.height / 10,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const CustomText(
                        text: "Edit Name",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(.5),
                      child: IconButton(
                          onPressed: () {
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
                          icon: const Text(
                            "✏",
                            style: TextStyle(fontSize: 30),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
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
                        builder: (controll) => controll.theme == ThemeMode.dark
                            ? const CustomText(
                                text: "Dark Mode",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              )
                            : const CustomText(
                                text: "Light Mode",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(.5),
                      child: GetBuilder<ThemesViewModel>(
                          builder: (controll) => IconButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
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
                                                  groupValue:
                                                      controller.groupValue,
                                                  onChanged: (value) {
                                                    controll.changeThemeMode(
                                                        ThemeMode.dark);
                                                    controll.saveTheme(true);
                                                  },
                                                  activeColor: Colors.brown,
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey)),
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
                                                  groupValue:
                                                      controller.groupValue,
                                                  onChanged: (value) {
                                                    controll.changeThemeMode(
                                                        ThemeMode.light);
                                                    controll.saveTheme(false);
                                                  },
                                                  activeColor: Colors.brown,
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey)),
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
                                icon: controll.theme == ThemeMode.dark
                                    ? const Text(
                                        "🌚",
                                        style: TextStyle(fontSize: 30),
                                      )
                                    : const Text(
                                        "🌞",
                                        style: TextStyle(fontSize: 30),
                                      ),
                              )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: size.height / 10,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const CustomText(
                        text: "Upload Photo",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(.5),
                      child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              content: const CustomText(
                                text: "Upload an image from : ",
                                textAlign: TextAlign.center,
                                color: Colors.brown,
                                fontSize: 16,
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
                            );
                          },
                          icon: const Text(
                            "📷",
                            style: TextStyle(fontSize: 30),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: size.height / 10,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const CustomText(
                        text: "Delete Account",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(.5),
                      child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              content: const CustomText(
                                text: "Are you sure dude 😦?",
                                textAlign: TextAlign.center,
                                color: Colors.brown,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              title: "",
                              textCancel: "No😜",
                              textConfirm: "Yes😞",
                              onCancel: () {
                                Get.back();
                              },
                              onConfirm: () async {
                                await FirebaseAuth.instance.currentUser!
                                    .delete();
                                Get.off(() => const SignIn(),
                                    transition: Transition.zoom);
                              },
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.brown,
                              buttonColor: Colors.brown,
                            );
                          },
                          icon: const Text(
                            "🗑",
                            style: TextStyle(fontSize: 30),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: size.height / 10,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: const CustomText(
                        text: "Log Out",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black.withOpacity(.5),
                      child: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              content: const CustomText(
                                text: "Are you sure ?",
                                textAlign: TextAlign.center,
                                color: Colors.brown,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              title: "",
                              textCancel: "No",
                              textConfirm: "Yes",
                              onCancel: () {
                                Get.back();
                              },
                              onConfirm: () async {
                                await FirebaseAuth.instance.signOut();
                              },
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.brown,
                              buttonColor: Colors.brown,
                            );
                          },
                          icon: const Text(
                            "🚶‍♂️",
                            style: TextStyle(fontSize: 30),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
