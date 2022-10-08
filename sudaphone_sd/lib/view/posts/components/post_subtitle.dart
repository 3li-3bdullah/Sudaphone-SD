import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view/download/download_images.dart';

class PostSubtitle extends StatelessWidget {
  const PostSubtitle({Key? key, required this.text,required this.imageUrl,required this.isThereImageUrl}) : super(key: key);
  final String text;
  final String imageUrl;
  final bool isThereImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: "$text",
          fontSize: 17,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        isThereImageUrl == true
            ? InkWell(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loader.gif',
                  image: "$imageUrl",
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Get.to(
                      () => DownloadImages(
                            image: imageUrl,
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
