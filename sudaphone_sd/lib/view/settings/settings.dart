import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/login/signin.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

// ignore: must_be_immutable
class Setting extends GetWidget<SettingsViewModel> {
  Setting({Key? key}) : super(key: key);
  final controll = Get.find<ThemesViewModel>();
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.brown.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const CustomText2(
              text: 'Settings',
              color: Colors.white,
              textAlign: TextAlign.center,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 20,),
            GetBuilder<PublicData>(
              builder: (control) => StreamBuilder<
                      DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller.getUserData.doc(control.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            height: size.height / 4,
                            width: size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${snapshot.data!.data()!['profileUrl']}"),
                                  fit: BoxFit.cover,
                                  opacity: 0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        "${snapshot.data!.data()!['profileUrl']}"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                        text:
                                            "${snapshot.data!.data()!['userName']}",
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: snapshot.data!.data()?['email'],
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text: snapshot.data!
                                            .data()?['registerTime'],
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Image.asset("assets/images/loader.gif");
                    }
                  }),
            ),
            InkWell(
              onTap: () {
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
                        textEditingController: controller.textEditing!),
                  ),
                  textConfirm: "Update",
                  textCancel: "Cancel",
                  cancelTextColor: Colors.brown,
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.brown,
                  radius: 20.0,
                  onConfirm: () async {
                    await controller.modifyUserName(
                        name: controller.textEditing!.text,
                        textKey: controller.editingKey);
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                        height: size.height / 20,
                        child: Image.asset("assets/icons/write.png")),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomText(
                      text: "Edit Name",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  GetBuilder<ThemesViewModel>(
                    builder: (controll) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        gradient: controll.theme == ThemeMode.dark
                            ? const LinearGradient(
                                colors: [Colors.black, Colors.grey],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : const LinearGradient(
                                colors: [Colors.black54, Colors.black54],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                        borderRadius: const BorderRadius.only(
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
                          InkWell(
                            onTap: () {
                              controll.changeThemeMode(ThemeMode.dark);
                              controll.saveTheme(true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText2(
                                  text: "Dark mode ",
                                  textAlign: TextAlign.justify,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                controll.theme == ThemeMode.dark
                                    ? const CustomText2(
                                        text: "🌚",
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center)
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              controll.changeThemeMode(ThemeMode.light);
                              controll.saveTheme(false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText2(
                                  text: "Light mode ",
                                  textAlign: TextAlign.justify,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                controll.theme == ThemeMode.light
                                    ? const CustomText2(
                                        text: "🌞",
                                        fontSize: 30,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center)
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<ThemesViewModel>(
                  builder: (controll) => Row(
                    children: [
                      SizedBox(
                        height: size.height / 20,
                        child: controll.theme == ThemeMode.dark
                            ? Image.asset("assets/icons/moon.png")
                            : Image.asset("assets/icons/sun.png"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        controll.theme == ThemeMode.dark
                            ? "Dark Mode"
                            : "Light Mode",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  content: const CustomText2(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                        height: size.height / 20,
                        child: Image.asset("assets/icons/gallery1.png")),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomText(
                      text: "Upload Image",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  content: const CustomText2(
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Get.offAll(() => const SignIn());
                  },
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.brown,
                  buttonColor: Colors.brown,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                        height: size.height / 20,
                        child: Image.asset("assets/icons/exit.png")),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomText(
                      text: "Log Out",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  content: const CustomText2(
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
                    await FirebaseAuth.instance.currentUser!.delete();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Get.off(() => const SignIn(), transition: Transition.zoom);
                  },
                  confirmTextColor: Colors.white,
                  cancelTextColor: Colors.brown,
                  buttonColor: Colors.brown,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                        height: size.height / 22,
                        child: Image.asset("assets/icons/trash.png")),
                    const SizedBox(
                      width: 18,
                    ),
                    CustomText(
                      text: "Delete Acount",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
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
