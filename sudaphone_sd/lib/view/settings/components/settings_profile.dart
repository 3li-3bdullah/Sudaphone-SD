import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';

class SettingsProfile extends GetWidget<SettingsViewModel> {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicData>(
      builder: (control) =>
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getUserData.doc(control.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        height: Get.height / 4,
                        width: Get.width,
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text:
                                        snapshot.data!.data()?['registerTime'],
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
    );
  }
}
