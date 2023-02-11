import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';

import '../shared/components/custom_dialog.dart';

class DownloadImagesViewModel extends GetxController {

  void saveNetworkImage(String path) {
    GallerySaver.saveImage(path, albumName: "Sudaphone SD")
        .whenComplete(
          () => Get.showSnackbar(
            const GetSnackBar(
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
          (e) => CustomDialog.ShowCustomDialog(body: e.toString())
        );
  }
}
