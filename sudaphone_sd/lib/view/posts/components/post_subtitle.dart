import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';

class PostSubtitle extends StatelessWidget {
  const PostSubtitle({Key? key, required this.currentDoc}) : super(key: key);
  final QueryDocumentSnapshot<Map<String,dynamic>> currentDoc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: currentDoc.data()['text'],
          fontSize: 17,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        currentDoc.data()['isThereImageUrl'] == true
            ? InkWell(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loader.gif',
                  image: "${currentDoc.data()['imageUrl']}",
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Get.to(
                      () => DownloadImages(
                            image:currentDoc.data()['imageUrl'],
                          ),
                      transition: Transition.zoom,
                      curve: Curves.easeInExpo);
                },
              )
            : const SizedBox(
                height: 0.0,
                width: 0.0,
              ),
      ],
    );
  }
}
