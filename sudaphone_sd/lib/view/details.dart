import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/people_have_liked.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';

// ignore: must_be_immutable
class Details extends GetWidget<DetailsViewModel> {
  Details(
      {required this.docTwo,
      required this.docOne,
      required this.collction,
      Key? key})
      : super(key: key);
  String docOne;
  String docTwo;
  String collction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("phonesCategory")
                .doc(docOne)
                .collection(collction)
                .doc(docTwo)
                .snapshots(),
            builder: (context, _snapshot) {
              return Obx(
                () => SlidingUpPanel(
                  maxHeight: MediaQuery.of(context).size.height / 1.2,
                  parallaxEnabled: true,
                  // boxShadow: const [BoxShadow(
                  //   offset: Offset.zero
                  // )],
                  minHeight: MediaQuery.of(context).size.height / 2.2,
                  controller: controller.panelController.value,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  body: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Image(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 2 + 80,
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    _snapshot.data?.data()!['imageUrl']),
                              ),
                              onTap: () {
                                Get.to(() => DownloadImages(
                                    image: _snapshot.data
                                        ?.data()!['imageUrl']
                                        .toString()));
                              },
                            ),
                          ],
                        ),
                        Positioned(
                          top: 40,
                          right: 20,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 10),
                                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                  stream: controller.favorite
                                      .doc(controller.uid)
                                      .collection("archivists")
                                      .doc(_snapshot.data!.id)
                                      .snapshots(),
                                  builder: (_, snapData) {
                                    return IconButton(
                                      iconSize: 38,
                                      color: snapData.data!.data()!['name'] != false
                                          ? bottomLogin
                                          : Colors.white,
                                      icon: snapData.data!.data()!['name'] !=
                                                  false ? const Icon(
                                              Icons.bookmark,
                                              size: 50,
                                            )
                                          : const Icon(
                                              Icons.bookmark_border_outlined,
                                              size: 50,
                                            ),
                                      onPressed: () {
                                        controller.addToArchivists(
                                            archivistsSnapshot:
                                                _snapshot.data?.data());
                                      },
                                    );
                                  },
                                )),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40))),
                            child: IconButton(
                              iconSize: 38,
                              color: Colors.white,
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  panel: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                width: 50,
                                height: 8,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                              ),
                            ),
                            onTap: () {
                              controller.togglePanel();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                              text: "${_snapshot.data?['name']}",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              textAlign: TextAlign.start),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomText(
                                  text:
                                      "Price : \$ ${_snapshot.data?['price']}",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink,
                                  textAlign: TextAlign.left),
                              Row(
                                children: [
                                  IconButton(
                                    iconSize: 38,
                                    color: _snapshot.data?['usersLiked']
                                                    ['${controller.uid}'] !=
                                                null ||
                                            false
                                        ? Colors.pink
                                        : Colors.grey,
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () {
                                      controller.handlePhoneLikes(
                                          collection: collction,
                                          docOne: docOne,
                                          snapshot: _snapshot.data);
                                    },
                                  ),
                                  IconButton(
                                    icon: CustomText(
                                        text:
                                            "${_snapshot.data?['likesCount']}",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: _snapshot.data?['usersLiked']
                                                        ['${controller.uid}'] !=
                                                    null ||
                                                false
                                            ? Colors.pink
                                            : Colors.grey,
                                        textAlign: TextAlign.left),
                                    onPressed: () {
                                      Get.to(
                                          () => PeopleHaveLIked(
                                              peopleWhoLiked: _snapshot
                                                  .data?['usersLiked'].keys
                                                  .toList(),
                                              currentDoc: _snapshot
                                                  .data?['usersLiked']),
                                          transition: Transition.zoom);
                                    },
                                  ),
                                ],
                              )
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Ram :",
                                      color: Colors.black,
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
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Storage :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['storage']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "CPU :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['cpu']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Rear Camera :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['rearCamera']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Front Camera :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['frontCamera']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Battery :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['battery']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Display :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['screen']}",
                                color: Colors.black,
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
                                  children: const [
                                    CustomText(
                                      text: "⚫️ ",
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Operating System :",
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                text: "${_snapshot.data?['os']}",
                                color: Colors.black,
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
                  ),
                ),
              );
            }));
  }
}
