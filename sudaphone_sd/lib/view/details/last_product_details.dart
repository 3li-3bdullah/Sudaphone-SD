import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class LastProducDetails extends GetWidget<DetailsViewModel> {
  LastProducDetails(
      {required this.phoneDoc, required this.collection, Key? key})
      : super(key: key);
  final String phoneDoc;
  final String collection;
  final control = Get.find<ThemesViewModel>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Details", underLineWidget: 50),
        elevation: 0,
        leading: const Leading(),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(collection)
            .doc(phoneDoc)
            .snapshots(),
        builder: (context, _snapshot) {
          if (_snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loader.gif',
                    image: _snapshot.data!.data()!['imageUrl'],
                  ),
                  onTap: () {
                    Get.to(() => DownloadImages(
                        image: _snapshot.data!.data()!['imageUrl'].toString()));
                  },
                ),
                const SizedBox(height: 10,),
                GetBuilder<ThemesViewModel>(
                  builder: (control) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "${_snapshot.data?['name']}",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText2(
                              text:
                                  "Price : \$ ${_snapshot.data?['price']}",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                              textAlign: TextAlign.left),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Ram :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: "${_snapshot.data?['ram']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Storage :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['storage']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "CPU :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CustomText(
                              text: "${_snapshot.data?['cpu']}",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Rear Camera :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['rearCamera']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Front Camera :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['frontCamera']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Battery :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['battery']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Display :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['screen']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText2(
                                  text: "⚫️ ",
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: "Operating System :",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: "${_snapshot.data?['os']}",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3)),
                    ],
                  ),
                ),
              ]),
            );
          } else if (_snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Image.asset("assets/images/loader.gif"));
          } else if (_snapshot.hasError) {
            return Center(
              child: CustomText(
                text: _snapshot.error.toString(),
                textAlign: TextAlign.center,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            );
          } else {
            return Center(
              child: Image.asset('assets/images/loader.gif'),
            );
          }
        },
      ),
    );
  }
}
