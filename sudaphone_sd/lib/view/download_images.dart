import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view_model/download_images_view_model.dart';

// ignore: must_be_immutable
class DownloadImages extends GetWidget<DownloadImagesViewModel> {
  DownloadImages({Key? key, required this.image}) : super(key: key);
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<DownloadImagesViewModel>(
          builder: (controller) => FloatingActionButton.extended(
            backgroundColor: Colors.grey,
            onPressed: () {
              controller.saveNetworkImage("$image!");
            },
            label: const Icon(Icons.download_outlined,
                size: 20, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image == null
                    ? Lottie.asset("assets/images/no_data.json")
                    : Image.network(image!,fit:BoxFit.fill),
              ],
            ),
          ),
        ));
  }
}
