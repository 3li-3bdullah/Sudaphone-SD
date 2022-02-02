import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostViewModel extends GetxController {
  /// Declaring Variables
  final postKey = GlobalKey<FormState>();
  CollectionReference addNewData =
      FirebaseFirestore.instance.collection("users");
  RxString? text;
  String? imageUrl;
  DateTime? postTime = DateTime.now();
  bool like = false;
  File? file;
  ImagePicker? pickedImage;
  Reference? uploadToStorage;

  /// All Methods
  addPost() async {
    FormState? formState = postKey.currentState;
    if (formState!.validate()) {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "Publishing",
        content: Row(
          children: const [
             ListTile(
              title: Text("Please wait a second..", style: TextStyle(fontSize: 16)),
              leading: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      );
      formState.save();
      await uploadToStorage!.putFile(file!);
      imageUrl = await uploadToStorage!.getDownloadURL();
      await addNewData
          .add({"text": text, "imageUrl": imageUrl, "dateTime": postTime});
      Get.back();
    }
  }

  uploadFromCamera() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      file = File(picked.path);
      int rand = Random().nextInt(100000);
      var imageName = "$rand" + basename(picked.path);
      uploadToStorage = FirebaseStorage.instance.ref("images/$imageName");
      Get.back();
    }
  }

  uploadFromGallery() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      int rand = Random().nextInt(100000);
      var imageName = "$rand" + basename(picked.path);
      uploadToStorage = FirebaseStorage.instance.ref("images/$imageName");
      Get.back();
    }
  }

 void isLiked() {
    like != like;
    update();
  }
}
