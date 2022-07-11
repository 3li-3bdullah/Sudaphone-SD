import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/posts.dart';
import 'package:sudaphone_sd/view/posts_widgets/custom_snakbar.dart';

class PostsViewModel extends GetxController {
  /// Declaring Variables
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState>? postKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? commentKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? editingPostKey = GlobalKey<FormState>();
  CollectionReference<Map<String, dynamic>> userInfoCollection =
      FirebaseFirestore.instance.collection("usersInfo");
  CollectionReference postsReference =
      FirebaseFirestore.instance.collection("posts");
  CollectionReference<Map<String, dynamic>> postsCollections =
      FirebaseFirestore.instance.collection("posts");
  TextEditingController commentController = TextEditingController();
  TextEditingController editingPostController = TextEditingController();

  String? _fileName;
  String? _fileNameForComment;
  File? _imageFileForComment;
  String? imageUrl;
  File? _imageFile;
  XFile? pickedImage;
  TextEditingController? textController;
  RxBool isThereImageUrl = false.obs;
  RxBool? isPicked = false.obs;
  RxBool? isPickedForComment = false.obs;
  FirebaseAuth? auth = FirebaseAuth.instance;
  RxBool isHasLiked = false.obs;
  Map<String, dynamic>? getUserInfo;
  RxBool showLoading = false.obs;
  RxBool? isLiked;
  RxBool commentIsloaded = false.obs;
  List<String> dropList = ["Edit", "Delete"];

  /// All Methods
  String? formattedDate;

  @override
  void onInit() {
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
      showLoading.value = true;
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
          postsReference
              .add({
                "text": text!,
                "imageUrl": imageUrl.toString(),
                "dateTime": formattedDate.toString(),
                "ownerUid": uid.toString(),
                "isThereImageUrl": true,
                "likesCount": 0,
                "isHasLiked": false,
                "usersLiked": {"$uid": false},
                "edited": false
              })
              .whenComplete(() => showLoading.value = false)
              .then(
                (value) {
                  CustomSnakbar.showSnakBar(
                      backgroundColor: kPrimaryColor,
                      context: Get.context,
                      message: "Uploaded Post Successfully",
                      title: "");
                  Get.off(() => const Posts(),
                      transition: Transition.circularReveal);
                },
              );
        } else {
          postsReference
              .add({
                "text": text!,
                "imageUrl": "null",
                "dateTime": formattedDate.toString(),
                "ownerUid": uid.toString(),
                "isThereImageUrl": false,
                "likesCount": 0,
                "isHasLiked": false,
                "usersLiked": {"$uid": false},
                "edited": false
              })
              .whenComplete(() => showLoading.value = false)
              .then(
                (value) {
                  CustomSnakbar.showSnakBar(
                      backgroundColor: const Color.fromARGB(255, 188, 204, 189),
                      context: Get.context,
                      message: "Uploaded Post Successfully",
                      title: "");
                  Get.off(() => const Posts());
                },
              );
        }
      } catch (e) {
        return Get.snackbar("Oops", "The error : ${e.toString()}");
      }
      clearEditingControllers();
    }
  }

  uploadImageToComment({String? source}) async {
    final _picker = ImagePicker();
    commentIsloaded.value = true;
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
      {collectionOne, String? text, GlobalKey<FormState>? commentKey}) async {
    final commentState = commentKey!.currentState!.validate();
    if (commentState == true) {
      commentKey.currentState!.save();
      getUserInfo = await FirebaseFirestore.instance
          .collection("posts")
          .doc(uid)
          .get()
          .then((value) => value.data());
      final _formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
      try {
        CollectionReference<Map<String, dynamic>> _commentReference =
            FirebaseFirestore.instance
                .collection("posts")
                .doc(collectionOne.id)
                .collection("comments");
        if (isPickedForComment!.value) {
          TaskSnapshot _uploadToStorage = await FirebaseStorage.instance
              .ref("comments")
              .child(_fileNameForComment!)
              .putFile(_imageFileForComment!);
          String _imageUrl = await _uploadToStorage.ref.getDownloadURL();

          await _commentReference.add({
            // 'userName': getUserInfo!['userName'].toString(),
            // 'profileUrl': getUserInfo!['profileUrl'].toString(),
            'text': text,
            'ownerUid': uid.toString(),
            'imageUrl': _imageUrl.toString(),
            'dateTime': _formattedDate.toString(),
            'isThereImageUrl': true,
            "usersLiked": {"$uid": false},
            'likesCount': 0,
          });
          isPickedForComment!.value = false;
        } else {
          await _commentReference.add({
            'text': text,
            // 'userName': getUserInfo!['userName'].toString(),
            // 'profileUrl': getUserInfo!['profileUrl'].toString(),
            'imageUrl': "null",
            'ownerUid': uid.toString(),
            'dateTime': _formattedDate.toString(),
            'isThereImageUrl': false,
            "usersLiked": {"$uid": false},
            'likesCount': 0,
          });
        }
      } catch (e) {
        return Get.snackbar("Errors", e.toString());
      }
      clearCommentText();
      commentIsloaded.value = false;
    }
  }

  clearCommentText() {
    commentController.clear();
  }

  handlePostLikes({currentPostDocData}) {
    DocumentReference<Map<String, dynamic>> _likeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(currentPostDocData.id);
    /*
     * This option will show up if the owner user has liked the post before
     * or not, and even if the user delete the app and reinstall again , so
     * he'll see he has liked before or not.
     */
    bool _isHasLiked = currentPostDocData.data()['usersLiked'][uid];
    //  bool _isHasLiked = await _likeData
    //       .get()
    //       .then((value) => value.data()!['usersLiked'][uid] == true);
    if (!_isHasLiked) {
      int _addLike = currentPostDocData.data()['likesCount'] + 1;
      _likeData.update({
        'likesCount': _addLike.toInt(),
        'isHasLiked': true,
        'usersLiked.$uid': true,
      });
    } else {
      int _removeLike = currentPostDocData.data()['likesCount'] - 1;
      _likeData.update({
        'likesCount': _removeLike.toInt(),
        'isHasLiked': false,
        'usersLiked.$uid': false
      });
    }
  }

  // handlePostLikes({firstDocsSnapshot}) async {
  //   DocumentReference<Map<String, dynamic>> _likeData = FirebaseFirestore
  //       .instance
  //       .collection("posts")
  //       .doc(firstDocsSnapshot.id);
  //   /*
  //    * This option will show up if the owner user has liked the post before
  //    * or not, and even if the user delete the app and reinstall again , so
  //    * he'll see he has liked before or not.
  //    */
  //   bool _isHasLiked = firstDocsSnapshot.data()['usersLiked'][uid];
  //   // await _likeData
  //   //     .get()
  //   //     .then((value) => value.data()!['usersLiked']['$uid'] == true);

  //   if (!_isHasLiked) {
  //     int _addLike = firstDocsSnapshot.data()['likesCount'] + 1;
  //      _likeData.update({
  //       'likesCount': _addLike.toInt(),
  //       'isHasLiked': true,
  //       'usersLiked.$uid': true,
  //     });
  //     // isLiked.value = true;
  //   } else {
  //     int _removeLike = firstDocsSnapshot.data()['likesCount'] - 1;
  //      _likeData.update({
  //       'likesCount': _removeLike.toInt(),
  //       'isHasLiked': false,
  //       'usersLiked.$uid': false
  //     });
  //     // isLiked.value = false;
  //   }
  // }

  handleCommentLikes({firstCollectionDocs, docSnapshot}) async {
    DocumentReference<Map<String, dynamic>> _commentLikeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(firstCollectionDocs.id)
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

  savePost({String? postDoc}){
    FirebaseFirestore.instance.collection("posts").doc(postDoc).set({
      "saved.$uid": true
    },SetOptions(merge: true));
  }

  editingPost({String? text ,String? postDoc, GlobalKey<FormState>? editKey}){
  if(editKey!.currentState!.validate()){
    editKey.currentState!.save();
      FirebaseFirestore.instance
        .collection("posts")
        .doc(postDoc)
        .update({
      "text": text.toString(),
      "edited": true
    }).whenComplete(() => Get.snackbar(
            "", "The post has edited successfully.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3)));
   }
  }

  deletePost(String theDoc) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(theDoc)
        .delete()
        .whenComplete(() => Get.snackbar(
            "", "The post has deleted successfully.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3)));
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

  @override
  void onClose() {
    super.onClose();
    textController!.dispose();
  }
}
