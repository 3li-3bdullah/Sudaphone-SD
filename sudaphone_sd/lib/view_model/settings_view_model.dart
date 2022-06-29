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
// Here  we declaring variables
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString? uid ;
  CollectionReference<Map<String, dynamic>> getUserData =
      FirebaseFirestore.instance.collection("usersInfo");
  XFile? pickImage;
  String? photoName;
  File? imageFile;
  final String formattedDate =
      DateFormat('M/d/y - kk:mm').format(DateTime.now());
  GlobalKey<FormState> editingKey = GlobalKey<FormState>();
  TextEditingController textEditing = TextEditingController();
  final String light = "light";
  final String dark = "dark";
  String groupValue = "mode";

// So here we declaring methods
  @override
  void onInit() {
    textEditing = TextEditingController();
    uid!.value = FirebaseAuth.instance.currentUser!.uid;
    super.onInit();
  }
  @override
  void onClose() {
    textEditing.dispose();
    super.onClose();
  }
  modifyUserName({String? name,GlobalKey<FormState>? textKey}) async {
   if(textKey!.currentState!.validate()){
     await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(uid.toString())
        .update({
      "userName": name.toString(),
    });
   }
  }

  uploadProfilePic({String? source}) async {
    final _picker = ImagePicker();
    pickImage = await _picker.pickImage(
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

      await FirebaseFirestore.instance.collection("usersInfo").doc(uid.toString()).update({
        "profileUrl": imageUrl.toString(),
        "modifyingDate": formattedDate.toString()
      });
    }
  }
}
