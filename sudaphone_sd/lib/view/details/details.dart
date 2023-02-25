import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sudaphone_sd/shared/components/custom_leading.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/details/components/details_text.dart';
import 'package:sudaphone_sd/view/details/components/save_icon.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
import 'package:sudaphone_sd/view/people_have_liked/people_have_liked.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class Details extends GetWidget<DetailsViewModel> {
  Details(
      {required this.docTwo,
      required this.docOne,
      required this.collction,
      Key? key})
      : super(key: key);
  final String docOne;
  final String docTwo;
  final String collction;
  final control = Get.find<ThemesViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(
            text: "Details", underLineWidget: 50, showUnderLine: false),
        leading: const ScreensLeading(),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("phonesCategory")
            .doc(docOne)
            .collection(collction)
            .doc(docTwo)
            .snapshots(),
        builder: (context, _snapshot) {
          if (_snapshot.hasData) {
            return Obx(
              () => SlidingUpPanel(
                maxHeight: MediaQuery.of(context).size.height / 1.2,
                parallaxEnabled: true,
                minHeight: MediaQuery.of(context).size.height / 2.2,
                controller: controller.panelController.value,
                color:
                    control.theme == ThemeMode.dark ? kDarkColor : Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child: FadeInImage.assetNetwork(
                              image: _snapshot.data!.data()!['imageUrl'],
                              placeholder: 'assets/images/loader.gif',
                              height:
                                  MediaQuery.of(context).size.height / 2 + 80,
                              placeholderErrorBuilder:
                                  ((context, error, stackTrace) => Image.asset(
                                        "assets/images/shimmer3.jpg",
                                      )),
                              imageErrorBuilder:
                                  ((context, error, stackTrace) => Image.asset(
                                        "assets/images/shimmer3.jpg",
                                      )),
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            onTap: () {
                              Get.to(() => DownloadImages(
                                  image: _snapshot.data!
                                      .data()!['imageUrl']
                                      .toString()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                panel: SingleChildScrollView(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
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
                                    color: Colors.brown,
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
                              Row(
                                children: [
                                  IconButton(
                                    iconSize: 38,
                                    icon: _snapshot.data!.data()!['usersLiked']
                                                [controller.uid] !=
                                            null
                                        ? _snapshot.data!.data()!['usersLiked']
                                                    [controller.uid] ==
                                                true
                                            ? Image.asset(
                                                "assets/images/like.png",
                                                color: Colors.pink,
                                              )
                                            : Image.asset(
                                                "assets/images/like.png",
                                                color: Colors.brown,
                                              )
                                        : Image.asset(
                                            "assets/images/like.png",
                                            color: Colors.brown,
                                          ),
                                    onPressed: () {
                                      controller.handlePhoneLikes(
                                          collection: collction,
                                          docOne: docOne,
                                          snapshot: _snapshot.data);
                                    },
                                  ),
                                  IconButton(
                                    icon: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                          "${_snapshot.data?['likesCount']}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: _snapshot.data?['usersLiked']
                                                        ['${controller.uid}'] ==
                                                    true
                                                ? Colors.pink
                                                : Colors.grey,
                                          ),
                                          key: ValueKey(
                                              "${_snapshot.data?['likesCount']}"),
                                          textAlign: TextAlign.left),
                                    ),
                                    onPressed: () {
                                      Get.to(
                                          () => PeopleHaveLiked(
                                              peopleWhoLiked: _snapshot
                                                  .data?['usersLiked'].keys
                                                  .toList(),
                                              currentDoc: _snapshot
                                                  .data?['usersLiked']),
                                          transition: Transition.zoom);
                                    },
                                  ),
                                ],
                              ),
                              SaveIcon(
                                  snapshot: _snapshot,
                                  collction: collction,
                                  docOne: docOne,
                                  docTwo: docTwo)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DetailsText(
                              detail: "Ram", text: "${_snapshot.data?['ram']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Storage",
                              text: "${_snapshot.data?['storage']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "CPU", text: "${_snapshot.data?['cpu']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Rear Camera",
                              text: "${_snapshot.data?['rearCamera']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Front Camera",
                              text: "${_snapshot.data?['frontCamera']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Battery",
                              text: "${_snapshot.data?['battery']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Display",
                              text: "${_snapshot.data?['screen']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                          DetailsText(
                              detail: "Operating System",
                              text: "${_snapshot.data?['os']}"),
                          Divider(color: Colors.black.withOpacity(0.3)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
            return Center(child: Image.asset("assets/images/loader.gif"));
          }
        },
      ),
    );
  }
}
