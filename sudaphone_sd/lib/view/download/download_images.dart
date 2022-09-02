import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/download_images_view_model.dart';

// ignore: must_be_immutable
class DownloadImages extends GetWidget<DownloadImagesViewModel> {
  const DownloadImages({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<DownloadImagesViewModel>(
          builder: (controller) => FloatingActionButton.extended(
            backgroundColor: Colors.grey,
            onPressed: () {
              controller.saveNetworkImage(image);
            },
            label: const Icon(Icons.download_outlined,
                size: 20, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.black,
            alignment: Alignment.center,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
