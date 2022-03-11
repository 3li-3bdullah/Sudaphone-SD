import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  String? _fileName;
  // String? imageUrl;
  bool like = false;
  File? _imageFile;
  XFile? pickedImage;
  TextEditingController? textController;
  RxBool isThereImageUrl = false.obs;
  TextEditingController? imageController ;

  /// All Methods
  String? formattedDate;

  @override
  void onInit() {
    super.onInit();
    _collectionReference = addNewData!.collection("users");
    textController = TextEditingController();
    imageController = TextEditingController();
  }

  // Upload Image From Camera or Gallery ...
  Future<void> uploadImage(String source) async {
    final picker = ImagePicker();
    pickedImage = await picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    int rand = Random().nextInt(1000000);
    _fileName = rand.toString() + pickedImage!.name;
    _imageFile = File(pickedImage!.path);
    // update();
  }

  //Add Post
  Future addPost(String? text,String? imageUrl , GlobalKey<FormState>? textFieldkey) async {
    final formState = textFieldkey!.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        if (_fileName != null) {
         
          TaskSnapshot uploadToStorage = await FirebaseStorage.instance
              .ref("images")
              .child(_fileName!)
              .putFile(_imageFile!);
          imageUrl = await uploadToStorage.ref.getDownloadURL();
          isHasAnImageUrl(imageUrl);
        }
      final formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
        _collectionReference.add({
          "text": text!,
          "imageUrl": imageUrl.toString(),
          "dateTime": formattedDate.toString(),
          "isThereImageUrl": isThereImageUrl.value
        }).whenComplete(() =>
          // return imageUrl = null;
          Get.off(() => const Posts()),
         
        ).then(
          (value) =>  CustomSnakbar.showSnakBar(
              backgroundColor: const Color.fromARGB(255, 188, 204, 189),
              context: Get.context,
              message: "Uploaded Post Successfully",
              title: "Done"),);
        
      } catch (e) {
        return Get.snackbar("Error", "The error : ${e.toString()}");
      }
      clearEditingControllers();
    }
  }

  isHasAnImageUrl(String? url) {
    if (url != null) {
      return isThereImageUrl.value = true;
    } else {
      return isThereImageUrl.value = false;
    }
  }
  // whenPostAdded(){
  //   imageUrl = "null";
  //   isThereImageUrl.value = false;
  // }

  // Added To Post Like Or Not ...
  void isLiked() {
    like = !like;
    update();
  }

  String? isValid(String? valid) {
    if (valid!.isEmpty) {
      return "Please write something ...";
    }
    return null;
  }
  void clearEditingControllers() {
    textController!.clear();
    imageController!.clear();
   
  }
  
  @override
  void onClose() {
    super.onClose();
    // imageUrl!.dispose();
    textController!.dispose();
    imageController!.dispose();
  }
}
