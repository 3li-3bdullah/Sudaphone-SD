import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:sudaphone_sd/model/posts_model.dart';
import 'package:sudaphone_sd/view/posts.dart';

class PostsViewModel extends GetxController {
  /// Declaring Variables
  GlobalKey<FormState>? postKey = GlobalKey<FormState>();
  CollectionReference addNewData =
      FirebaseFirestore.instance.collection("users");
  // final _db = FirebaseFirestore.instance;
  String? text;
  String? imageUrl;
  bool like = false;
  File? file;
  Reference? uploadToStorage;
  late TextEditingController textEditing;

  /// All Methods

  // Future getData() async {
  //   var _data = FirebaseFirestore.instance.collection("users");
  //   await _data.get().then((value) => value.docs.forEach((items) {
  //         dataList.add(items.data());
  //       }));
  //   update();
  // }
  //Get Data By Stream ..
  // Stream<List<PostsModel>> dataStream() {
  //   try {
  //     return _db.collection("users").snapshots().map((data) {
  //       final List<PostsModel> dataFromFirestore = <PostsModel>[];
  //       for (final DocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
  //         dataFromFirestore.add(PostsModel.fromDocumentSnapshot(doc: doc));
  //       }
  //       return dataFromFirestore;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Stream<List<PostsModel>> streamData() {
  //   try {
  //     return _db.collection("users").snapshots().map((event) {
  //       final List<PostsModel> items = <PostsModel>[];
  //       for (var element in event.docs) {
  //         items.add(PostsModel.fromSnapshot(element));
  //       }
  //       return items;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //Get Date
  // String formattedDate(String dateTime) {
  //   var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(
  //     dateTime.isSHA1
  //   );
  // }
  String formattedDate =
      DateFormat('EEE, M/d/y - kk:mm').format(DateTime.now());

  // Add Post ...
  Future addPost() async {
    FormState? formState = postKey!.currentState;
    if (formState!.validate()) {
      // Get.defaultDialog(
      //   barrierDismissible: false,
      //   title: "Posting",
      //   content: Row(
      //     children: const [
      //       ListTile(
      //         title: Text("Please wait a second..",
      //             style: TextStyle(fontSize: 16)),
      //         leading: Center(child: CircularProgressIndicator()),
      //       ),
      //     ],
      //   ),
      // );
      Center(child: Lottie.asset("assets/images/create_post.json"));
      formState.save();
      await uploadToStorage!.putFile(file!);
      imageUrl = await uploadToStorage!.getDownloadURL();
      await addNewData
          .add({"text": text, "imageUrl": imageUrl, "dateTime": formattedDate});
      Get.off(() => const Posts());
      Get.back();
    }
  }

  // Upload Image From Camera ...
  Future uploadFromCamera() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      file = File(picked.path);
      int rand = Random().nextInt(100000);
      var imageName = "$rand" + basename(picked.path);
      uploadToStorage = FirebaseStorage.instance.ref("images/$imageName");
    }
  }

  //Upload Image From Gallery ...
  Future uploadFromGallery() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      int rand = Random().nextInt(100000);
      var imageName = "$rand" + basename(picked.path);
      uploadToStorage = FirebaseStorage.instance.ref("images/$imageName");
    }
  }

  // Added To Post Like Or Not ...
  void isLiked() {
    like != like;
    update();
  }

  @override
  void onInit() {
    textEditing = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditing = TextEditingController();
    super.onClose();
  }
}
