import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SettingsViewModel extends GetxController {
// (((((((((((((((((((((((((( Declaring Variables ))))))))))))))))))))))))))
  CollectionReference<Map<String, dynamic>> getUserData =
      FirebaseFirestore.instance.collection("usersInfo");
  XFile? pickImage;
  String? photoName;
  File? imageFile;
  final String formattedDate =
      DateFormat('M/d/y - kk:mm').format(DateTime.now());
  GlobalKey<FormState> editingKey = GlobalKey<FormState>();
  TextEditingController? textEditing = TextEditingController();
  CollectionReference<Map<String, dynamic>> postsCollection =
      FirebaseFirestore.instance.collection("posts");
  final String light = "light";
  final String dark = "dark";
  String groupValue = "mode";
  RxBool isDarkMode = false.obs;
  String? uid;
  List<String> commentsDocsYouCommented = [];
  List<String> allPostsDocs = [];
  List<String> postsDocsYouPosted = [];
  List<String> postsDocsYouCommentedAt = [];

// ((((((((((((((((((((((( Declaring Methods )))))))))))))))))))))))
  @override
  void onInit() {
    textEditing = TextEditingController();
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.onInit();
  }

  @override
  void onClose() {
    textEditing!.clear();
    super.onClose();
  }

  getOldNameAndUpdate({required String userName}) async {
    //========= Get All Post Has The Old Name =================
    Future<QuerySnapshot<Map<String, dynamic>>> postsDocs = FirebaseFirestore
        .instance
        .collection("posts")
        .where('ownerUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    await postsDocs.then((value) =>
        value.docs.forEach((element) => postsDocsYouPosted.add(element.id)));
    //========= Get All Posts ID ===============================
    Future<QuerySnapshot<Map<String, dynamic>>> getAllPostsDocs =
        FirebaseFirestore.instance.collection("posts").get();
    await getAllPostsDocs.then((querySnapshot) =>
        querySnapshot.docs.forEach((element) => allPostsDocs.add(element.id)));
    //========= Get All Comments Has The Old Name ===============
    for (var i = 0; i < allPostsDocs.length; i++) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(allPostsDocs[i])
          .collection("comments")
          .where('ownerUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((querySnapshot) => querySnapshot.docs.forEach((element) {
                commentsDocsYouCommented.add(element.id);
                postsDocsYouCommentedAt.add(allPostsDocs[i]);
              }));
    }
    // For Loop To Change The Old Name At All Posts If He Posted
    for (var i = 0; i < postsDocsYouPosted.length; i++) {
      postsCollection.doc(postsDocsYouPosted[i]).update({"userName": userName});
    }
    // For Loop To Change The Old Name At All Posts You've commented
    for (var i = 0; i < commentsDocsYouCommented.length; i++) {
      postsCollection
          .doc(postsDocsYouCommentedAt[i])
          .collection("comments")
          .doc(commentsDocsYouCommented[i])
          .update({"userName": userName});
    }
  }

  Future<void> modifyUserName(
      {required String name,
      GlobalKey<FormState>? textKey,
      String? oldName}) async {
    if (textKey!.currentState!.validate()) {
      textKey.currentState!.save();
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) => Center(
          child: Image.asset("assets/images/loader.gif"),
        ),
      );
      await FirebaseFirestore.instance
          .collection("usersInfo")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "userName": name.toString(),
      });
      getOldNameAndUpdate(userName: name);
      textEditing!.clear();
      Get.back();
      Get.snackbar("Done", "Your name has changed successflly.",
          backgroundColor: Colors.green[200],
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
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
