import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/themes.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

// ignore: must_be_immutable
class Settings extends GetWidget<SettingsViewModel> {
  Settings({Key? key}) : super(key: key);
  var controll = Get.find<ThemesViewModel>();
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: controller.getUserData.doc(controller.uid.toString()).get(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      InkWell(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                "${snapshot.data?.data()!['profileUrl']}"),
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
                          text: "${snapshot.data?.data()!['userName']}",
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
            const SizedBox(height: 10),
            InkWell(
              child: const Themesx(),
              onTap: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                            Radio(value: controller.dark, groupValue: controller.groupValue, onChanged: (value){
                            controll.changeThemeMode(ThemeMode.dark);
                                    controll.saveTheme(true);
                          },activeColor: Colors.brown,fillColor: MaterialStateProperty.all(Colors.grey)),
                           const Align(
                              alignment: Alignment.centerLeft,
                              child:  CustomText(text: "Dark mode ",textAlign: TextAlign.justify,color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal,),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                       Row(
                         children: [
                          Radio(value: controller.light, groupValue: controller.groupValue, onChanged: (value){
                            controll.changeThemeMode(ThemeMode.light);
                                    controll.saveTheme(false);
                          },activeColor: Colors.brown,fillColor: MaterialStateProperty.all(Colors.grey)),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child:  CustomText(text: "Light mode ",textAlign: TextAlign.justify,color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal,),
                            ),
                         ],
                       ),
                      ],
                    ),
                  ),
                );
                //        if(Get.isDarkMode){
                //         controll.changeThemeMode(ThemeMode.light);
                // controll.saveTheme(false);
                //        } else{
                //         controll.changeThemeMode(ThemeMode.dark);
                // controll.saveTheme(true);
                //        }
              },
            ),
            //     GetBuilder<ThemesViewModel>(
            //       init: ThemesViewModel(),
            //       builder:(context)=> ElevatedButton(onPressed: (){
            //        if(Get.isDarkMode){
            //         controll.changeThemeMode(ThemeMode.light);
            // controll.saveTheme(false);
            //        } else{
            //         controll.changeThemeMode(ThemeMode.dark);
            // controll.saveTheme(true);
            //    }
            //   }, child: const Text("Change Mode")),
            // )
          ],
        ),
      ),
    );
  }
}
