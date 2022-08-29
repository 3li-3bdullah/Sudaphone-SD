import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SettingsViewModel extends GetxController {
// (((((((((((((((((((((((((( Declaring Variables ))))))))))))))))))))))))))
  CollectionReference<Map<String, dynamic>> getUserData =
      FirebaseFirestore.instance.collection("usersInfo");
  CollectionReference<Map<String, dynamic>> updateNameAtAllPosts =
      FirebaseFirestore.instance.collection("posts");
  XFile? pickImage;
  String? photoName;
  File? imageFile;
  final String formattedDate =
      DateFormat('M/d/y - kk:mm').format(DateTime.now());
  GlobalKey<FormState> editingKey = GlobalKey<FormState>();
  TextEditingController? textEditing = TextEditingController();
  final String light = "light";
  final String dark = "dark";
  String groupValue = "mode";
  RxBool isDarkMode = false.obs;

// ((((((((((((((((((((((( Declaring Methods )))))))))))))))))))))))
  @override
  void onInit() {
    textEditing = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditing!.dispose();
    super.onClose();
  }

  Future<void> modifyUserName(
      {String? name, GlobalKey<FormState>? textKey, String? oldName}) async {
    if (textKey!.currentState!.validate()) {
      textKey.currentState!.save();
      await FirebaseFirestore.instance
          .collection("usersInfo")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "userName": name.toString(),
      }).whenComplete(() => Get.snackbar("", "Modifiying has done successfully",
              duration: const Duration(seconds: 5),
              snackPosition: SnackPosition.BOTTOM));
    }
  }

  modifyInEachPost(String? doc) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(doc)
        .update({"userName": textEditing!.text});
  }

  uploadProfilePic({String? source}) async {
    final picker = ImagePicker();
    pickImage = await picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    int rand = Random().nextInt(1000000);
    photoName = rand.toString() + pickImage!.name;
    imageFile = File(pickImage!.path);
    if (pickImage!.path.isEmpty) {
      return;
    } else {
      TaskSnapshot uploadImage = await FirebaseStorage.instance
          .ref("profile")
          .child(photoName!.toString())
          .putFile(imageFile!);
      String imageUrl = await uploadImage.ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection("usersInfo")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "profileUrl": imageUrl.toString(),
        "modifyingDate": formattedDate.toString()
      }, SetOptions(merge: true));
    }
  }
}
