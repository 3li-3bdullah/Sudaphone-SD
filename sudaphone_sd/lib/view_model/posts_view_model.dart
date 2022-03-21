import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sudaphone_sd/view/posts.dart';
import 'package:sudaphone_sd/view/posts_widgets/custom_snakbar.dart';

class PostsViewModel extends GetxController {
  /// Declaring Variables
  final GlobalKey<FormState>? postKey = GlobalKey<FormState>();
  FirebaseFirestore? addNewData = FirebaseFirestore.instance;
  CollectionReference? getData = FirebaseFirestore.instance.collection("users");
  late CollectionReference _collectionReference;

  CollectionReference postsCollections = FirebaseFirestore.instance.collection("posts");

  String? _fileName;
  String? imageUrl;
  RxBool isLiked = false.obs;
  File? _imageFile;
  XFile? pickedImage;
  TextEditingController? textController;
  RxBool isThereImageUrl = false.obs;
  RxBool? isPicked = false.obs;
  FirebaseAuth? _auth = FirebaseAuth.instance;

  /// All Methods
  String? formattedDate;

  @override
  void onInit() {
    super.onInit();
    _collectionReference = addNewData!.collection("users");
    textController = TextEditingController();
  }

  // Upload Image From Camera or Gallery ...
  Future<bool?> uploadImage(String? source) async {
    final picker = ImagePicker();
    pickedImage = await picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    int rand = Random().nextInt(1000000);
    _fileName = rand.toString() + pickedImage!.name;
    _imageFile = File(pickedImage!.path);
    if (source != null) {
      return isPicked!.value = true;
    } else {
      return isPicked!.value = false;
    }
    // update();
  }

  //Add Post
  Future addPost(String? text, GlobalKey<FormState>? textFieldkey) async {
    final formState = textFieldkey!.currentState;
    if (formState!.validate()) {
      formState.save();
      final formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
      try {
        if (isPicked!.value) {
          TaskSnapshot uploadToStorage = await FirebaseStorage.instance
              .ref("images")
              .child(_fileName!)
              .putFile(_imageFile!);
          imageUrl = await uploadToStorage.ref.getDownloadURL();
          isHasAnImageUrl(imageUrl);
          isPicked!.value = false;
          postsCollections
              .doc("${_auth!.currentUser!.uid}")
              .collection("userPosts")
              .add({
                "text": text!,
                "imageUrl": imageUrl.toString(),
                "dateTime": formattedDate.toString(),
                "ownerUid": _auth!.currentUser!.uid.toString(),
                "isThereImageUrl": isThereImageUrl.value,
                "likesCount": 0,
                "isHasLiked": false,
              }).whenComplete(
                () => CustomSnakbar.showSnakBar(
                    backgroundColor: const Color.fromARGB(255, 188, 204, 189),
                    context: Get.context,
                    message: "Uploaded Post Successfully",
                    title: "Done"),
              )
              .then(
                (value) => Get.off(() => const Posts()),
              );
          // _collectionReference
          //     .add({
          //       "text": text!,
          //       "imageUrl": imageUrl.toString(),
          //       "dateTime": formattedDate.toString(),
          //       "isThereImageUrl": isThereImageUrl.value
          //     })
          //     .whenComplete(
          //       () => CustomSnakbar.showSnakBar(
          //           backgroundColor: const Color.fromARGB(255, 188, 204, 189),
          //           context: Get.context,
          //           message: "Uploaded Post Successfully",
          //           title: "Done"),
          //     )
          //     .then(
          //       (value) => Get.off(() => const Posts()),
          //     );
        } else {
          // _collectionReference
          //     .add({
          //       "text": text!,
          //       "imageUrl": "null",
          //       "dateTime": formattedDate.toString(),
          //       "isThereImageUrl": false
          //     })
              postsCollections
              .doc("${_auth!.currentUser!.uid}")
              .collection("userPosts")
              .add({
                "text": text!,
                "imageUrl": "null",
                "dateTime": formattedDate.toString(),
                "ownerUid": _auth!.currentUser!.uid.toString(),
                "isThereImageUrl": false,
                "likesCount": 0,
                "isHasLiked": false,
              }).whenComplete(
                () => CustomSnakbar.showSnakBar(
                    backgroundColor: const Color.fromARGB(255, 188, 204, 189),
                    context: Get.context,
                    message: "Uploaded Post Successfully",
                    title: "Done"),
              )
              .then(
                (value) => Get.off(() => const Posts()),
              );
        }
      } catch (e) {
        return Get.snackbar("Error", "The error : ${e.toString()}");
      }
      clearEditingControllers();
      resetValues(fileName: _fileName, imageFile: _imageFile, url: imageUrl);
    }
  }

  // Handle Likes
  handleLikes(likesData) async {
    DocumentReference<Map<String, dynamic>> _likeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc("${likesData.data()['ownerUid']}")
        .collection("userPosts")
        .doc(likesData);
    // The option will show up if the owner user has liked the post before
    // or not, and even if the user delete the app and reinstall again , so
    // he'll see he has liked before or not.
    bool _isHasLiked =
        await _likeData.get().then((value) => value.data()!['isHasLiked']);
    if (!isLiked.value && !_isHasLiked) {
      int _addLike = likesData.data()['likesCount'] + 1;
      await _likeData.update({'likesCount': _addLike.toInt(), 'isHasLiked': true});
      isLiked.value = true;
    } else {
      int _removeLike = likesData.data()['likesCount'] - 1;
      await _likeData
          .update({'likesCount': _removeLike.toInt(), 'isHasLiked': false});
      isLiked.value = false;
    }
  }

  isHasAnImageUrl(String? url) {
    if (url != null) {
      return isThereImageUrl.value = true;
    } else {
      return isThereImageUrl.value = false;
    }
  }
  // Added To Post Like Or Not ...
  // void isLiked() {
  //   like = !like;
  //   update();
  // }

  String? isValid(String? valid) {
    if (valid!.isEmpty) {
      return "Please write something ...";
    }
    return null;
  }

  void clearEditingControllers() {
    textController!.clear();
  }

  void resetValues({String? fileName, File? imageFile, String? url}) {
    fileName = null;
    imageFile = null;
    url = null;
  }

  @override
  void onClose() {
    super.onClose();
    textController!.dispose();
  }
}
