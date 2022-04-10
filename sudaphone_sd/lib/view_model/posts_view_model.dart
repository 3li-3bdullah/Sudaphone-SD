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
  final GlobalKey<FormState>? commentKey = GlobalKey<FormState>();
  CollectionReference<Map<String, dynamic>> writePostsData =
      FirebaseFirestore.instance.collection("posts");
  CollectionReference postsCollections =
      FirebaseFirestore.instance.collection("posts");
  RxInt? commentsCount;
  TextEditingController commentController = TextEditingController();

  String? _fileName;
  String? _fileNameForComment;
  File? _imageFileForComment;
  String? imageUrl;
  // RxBool isLiked = false.obs;
  File? _imageFile;
  XFile? pickedImage;
  TextEditingController? textController;
  RxBool isThereImageUrl = false.obs;
  RxBool? isPicked = false.obs;
  RxBool? isPickedForComment = false.obs;
  FirebaseAuth? auth = FirebaseAuth.instance;
  RxBool isHasLiked = false.obs;
  String? uid;

  /// All Methods
  String? formattedDate;

  @override
  void onInit() {
    uid = auth!.currentUser!.uid;
    super.onInit();
    commentController = TextEditingController();
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
              .doc(auth!.currentUser!.uid)
              .collection("userPosts")
              .add({
                "text": text!,
                "imageUrl": imageUrl.toString(),
                "dateTime": formattedDate.toString(),
                "ownerUid": auth!.currentUser!.uid.toString(),
                "isThereImageUrl": true,
                "likesCount": 0,
                "isHasLiked": false,
                "usersLiked": {"${auth!.currentUser!.uid}": false}
              })
              .whenComplete(
                () => CustomSnakbar.showSnakBar(
                    backgroundColor: const Color.fromARGB(255, 188, 204, 189),
                    context: Get.context,
                    message: "Uploaded Post Successfully",
                    title: "Done"),
              )
              .then(
                (value) => Get.off(() => const Posts()),
              );
        } else {
          postsCollections
              .doc(auth!.currentUser!.uid)
              .collection("userPosts")
              .add({
                "text": text!,
                "imageUrl": "null",
                "dateTime": formattedDate.toString(),
                "ownerUid": auth!.currentUser!.uid.toString(),
                "isThereImageUrl": false,
                "likesCount": 0,
                "isHasLiked": false,
                "usersLiked": {"${auth!.currentUser!.uid}": false}
              })
              .whenComplete(
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

  // Here I've removed the type annotaion Futre<bool>?
  uploadImageToComment({String? source}) async {
    final _picker = ImagePicker();
    XFile? pickImage = await _picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    int rand = Random().nextInt(1000000);
    _fileNameForComment = rand.toString() + pickImage!.name;
    _imageFileForComment = File(pickImage.path);
    if (source != null) {
      isPickedForComment!.value = true;
    } else {
      isPickedForComment!.value = false;
    }
  }

  Future addComment(
      {collectionOne,
      collectionTwo,
      String? text,
      GlobalKey<FormState>? commentKey}) async {
    final commentState = commentKey!.currentState?.validate();
    if (commentState == true) {
      commentKey.currentState!.save();
      final _formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
      try {
        CollectionReference<Map<String, dynamic>> commentReference =
            FirebaseFirestore.instance
                .collection("posts")
                .doc(collectionOne.id)
                .collection("userPosts")
                .doc(collectionTwo.id)
                .collection("comments");
        if (isPickedForComment!.value) {
          TaskSnapshot _uploadToStorage = await FirebaseStorage.instance
              .ref("comments")
              .child(_fileNameForComment!)
              .putFile(_imageFileForComment!);
          String _imageUrl = await _uploadToStorage.ref.getDownloadURL();

          await commentReference.add({
            'text': text,
            'imageUrl': _imageUrl.toString(),
            'dateTime': _formattedDate.toString(),
            'isThereImageUrl': true,
          });
          isPickedForComment!.value = false;
        } else {
          await commentReference.add({
            'text': text,
            'imageUrl': "null",
            'dateTime': _formattedDate.toString(),
            'isThereImageUrl': false,
          });
        }
      } catch (e) {
        return Get.snackbar("Errors", e.toString());
      }
      clearCommentText();
    }
  }

  clearCommentText() {
    commentController.clear();
  }
  // Handle Likes
  // handleLikes({collection1 , collection2, snapshot}) async {
  //   CollectionReference<Map<String, dynamic>> _likeData = FirebaseFirestore
  //       .instance
  //       .collection("posts")
  //       .doc(collection1.id)
  //       .collection("userPosts")
  //       .doc(collection2.id)
  //       .collection("likes");
  //   // The option will show up if the owner user has liked the post before
  //   // or not, and even if the user delete the app and reinstall again , so
  //   // he'll see he has liked before or not.

  //   if (isHasLiked.value) {
  //     await _likeData.doc(auth!.currentUser!.uid).set({'userName' : collection1.data()?['userName'].toString()});
  //     isHasLiked(false);
  //   } else {
  //     await _likeData.doc(auth!.currentUser!.uid).delete();
  //   }
  // }
  handlePostLikes({firstDocsSnapshot, docSnapshot}) async {
    DocumentReference<Map<String, dynamic>> _likeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(firstDocsSnapshot.id)
        .collection("userPosts")
        .doc(docSnapshot.id);
    /*
     * This option will show up if the owner user has liked the post before
     * or not, and even if the user delete the app and reinstall again , so
     * he'll see he has liked before or not.
     */
    bool _isHasLiked = await _likeData
        .get()
        .then((value) => value.data()!['usersLiked']['$uid'] == true);

    if (!_isHasLiked) {
      int _addLike = docSnapshot['likesCount'] + 1;
      await _likeData.update({
        'likesCount': _addLike.toInt(),
        'isHasLiked': true,
        'usersLiked.$uid': true,
      });
      // isLiked.value = true;
    } else {
      int _removeLike = docSnapshot['likesCount'] - 1;
      await _likeData.update({
        'likesCount': _removeLike.toInt(),
        'isHasLiked': false,
        'usersLiked.$uid': false
      });
      // isLiked.value = false;
    }
  }

  handleCommentLikes(
      {firstCollectionDocs, secondCollectionDocs, docSnapshot}) async {
    DocumentReference<Map<String, dynamic>> _commentLikeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(firstCollectionDocs.id)
        .collection("userPosts")
        .doc(secondCollectionDocs.id)
        .collection("comments")
        .doc(docSnapshot.id);
    /*
     * This option will show up if the owner user has liked the post before
     * or not, and even if the user delete the app and reinstall again , so
     * he'll see he has liked before or not.
     */
    bool _isHasLiked = await _commentLikeData
        .get()
        .then((value) => value.data()!['usersLiked']['$uid'] == true);

    if (!_isHasLiked) {
      int _addLike = docSnapshot['likesCount'] + 1;
      await _commentLikeData.update({
        'likesCount': _addLike.toInt(),
        'isHasLiked': true,
        'usersLiked.$uid': true,
      });
    } else {
      int _removeLike = docSnapshot['likesCount'] - 1;
      await _commentLikeData.update({
        'likesCount': _removeLike.toInt(),
        'isHasLiked': false,
        'usersLiked.$uid': false
      });
    }
  }

  isHasAnImageUrl(String? url) {
    if (url != null) {
      return isThereImageUrl.value = true;
    } else {
      return isThereImageUrl.value = false;
    }
  }

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
