import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
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
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: "${snapshot.data?.data()!['email']}",
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
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
