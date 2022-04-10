import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

class DownloadImagesViewModel extends GetxController {

  void saveNetworkImage(String path) async {
    GallerySaver.saveImage(path, albumName: "Sudaphone SD")
        .whenComplete(
          () => Get.showSnackbar(
            const GetSnackBar(
              backgroundGradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purpleAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              messageText: Text(
                "Image saved successfully ^_^ enjoy dude",
                style: TextStyle(color: Colors.white),
              ),
              titleText: Text(
                "Done",
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              reverseAnimationCurve: Curves.easeInCubic,
              backgroundColor: Colors.white12,
            ),
          ),
        )
        .catchError(
          // ignore: invalid_return_type_for_catch_error
          (e) => Get.snackbar(
            "Error",
            e.toString(),
            duration: const Duration(seconds: 3),
          ),
        );

    // .then(
    //   (success) {
    //     // CustomSnakbar.showSnakBar(
    //     //       backgroundColor: Colors.white12,
    //     //       context: Get.context,
    //     //       message: "Image saved successfully",
    //     //       title: "Done");
    //     Get.showSnackbar(const GetSnackBar(
    //       messageText: Text(
    //         "Image saved successfully ^_^ enjoy dude",
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       titleText: Text(
    //         "Done",
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       duration: Duration(seconds: 2),
    //       snackPosition: SnackPosition.BOTTOM,
    //       reverseAnimationCurve: Curves.easeInCubic,
    //       backgroundColor: Colors.white12,
    //     ),);
    //   },
    // );
  }
}
