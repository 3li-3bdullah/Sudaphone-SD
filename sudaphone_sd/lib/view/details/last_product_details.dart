import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_leading.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/view/details/components/details_text.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(
            text: "Details", underLineWidget: 50, showUnderLine: false),
        leading: const ScreensLeading(),
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
                    placeholderErrorBuilder: ((context, error, stackTrace) =>
                        Image.asset(
                          "assets/images/shimmer3.jpg",
                        )),
                    imageErrorBuilder: ((context, error, stackTrace) =>
                        Image.asset(
                          "assets/images/shimmer3.jpg",
                        )),
                  ),
                  onTap: () {
                    Get.to(() => DownloadImages(
                        image: _snapshot.data!.data()!['imageUrl'].toString()));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
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
                    CustomText2(
                        text: "Price : \$ ${_snapshot.data?['price']}",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                        textAlign: TextAlign.left),
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
