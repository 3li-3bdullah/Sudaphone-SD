import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';

// ignore: must_be_immutable
class Details extends GetWidget<DetailsViewModel> {
  Details(
      {required this.snapshot,
      required this.docOne,
      required this.docTwo,
      required this.collction,
      Key? key})
      : super(key: key);
  var snapshot;
  var docOne;
  var docTwo;
  var collction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SlidingUpPanel(
          maxHeight: controller.size.height / 1.2,
          parallaxEnabled: true,
          // boxShadow: const [BoxShadow(
          //   offset: Offset.zero
          // )],
          minHeight: controller.size.height / 2.2,
          controller: controller.panelController.value,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Image(
                        width: double.infinity,
                        height: controller.size.height / 2 + 80,
                        fit: BoxFit.contain,
                        image: NetworkImage(snapshot.data()['imageUrl']),
                      ),
                      onTap: () {
                        Get.to(() => DownloadImages(image: snapshot.data()['imageUrl'].toString()));
                      },
                    ),
                  ],
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: IconButton(
                      iconSize: 38,
                      color: snapshot.data()['usersLiked']['${controller.uid}']
                          ? Colors.orange
                          : Colors.white,
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        controller.handlePhoneLikes(
                            collection: collction,
                            docOne: docOne,
                            docTwo: docTwo,
                            snapshot: snapshot);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
                    child: IconButton(
                      iconSize: 38,
                      color: Colors.white,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.arrow_back_ios),
                      ),
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
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                      text: "${snapshot.data()['name']}",
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
                          text: "Price : \$ ${snapshot.data()['price']}",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          textAlign: TextAlign.left),
                      CustomText(
                          text: "Likes : ${snapshot.data()['likesCount']}",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: snapshot.data()['usersLiked']
                                  ['${controller.uid}']
                              ? Colors.orange
                              : Colors.green,
                          textAlign: TextAlign.left)
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
                        text: "${snapshot.data()['ram']}",
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
                        text: "${snapshot.data()['storage']}",
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
                              text: "Performance :",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CustomText(
                        text: "${snapshot.data()['performance']}",
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
                        text: "${snapshot.data()['rearCamera']}",
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
                        text: "${snapshot.data()['frontCamera']}",
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
                        text: "${snapshot.data()['battery']}",
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
                        text: "${snapshot.data()['screen']}",
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
                        text: "${snapshot.data()['os']}",
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
      ),
    );
  }
}
