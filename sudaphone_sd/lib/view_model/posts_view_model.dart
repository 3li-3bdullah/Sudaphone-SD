import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';

class PostsViewModel extends GetxController {
  // ((((((((((((((((((((((((((( Declaring Variables )))))))))))))))))))))))))))
  final GlobalKey<FormState>? postKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? commentKey = GlobalKey<FormState>();
  final GlobalKey<FormState>? editingPostKey = GlobalKey<FormState>();
  CollectionReference<Map<String, dynamic>> userInfoCollection =
      FirebaseFirestore.instance.collection("usersInfo");
  CollectionReference postsReference =
      FirebaseFirestore.instance.collection("posts");
  CollectionReference<Map<String, dynamic>> postsCollections =
      FirebaseFirestore.instance.collection("posts");
  CollectionReference<Map<String, dynamic>> savedCollection =
      FirebaseFirestore.instance.collection("saved");
  TextEditingController commentController = TextEditingController();
  TextEditingController editingPostController = TextEditingController();
  Size size = MediaQuery.of(Get.context!).size;

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
  Map<String, dynamic>? getUserInfo;
  RxBool showLoading = false.obs;
  RxBool? isLiked;
  RxBool commentIsloaded = false.obs;
  String? uid;
  RxBool selected = false.obs;
  List<String>? listOfSavedPosts;
  RxList isSavedPostHasData = [].obs;
  List<String> isCurrentUserSavedPost = [];

  // ((((((((((((((((((((((((((( Declaring Methods )))))))))))))))))))))))))))

  @override
  void onInit() {
    commentController = TextEditingController();
    textController = TextEditingController();
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    commentController.clear();
    textController!.clear();
  }
  //Here To See Is there Posts And If Current User Has Saved Any Post Or Not
  isCurrentUserSavedPosts() async{
   await postsCollections.get().then((querySnapshot) => querySnapshot.docs.forEach((element) {
    if (element.data()['usersHaveSaved'][uid] && element.data()['usersHaveSaved'][uid] != null ) {
      isCurrentUserSavedPost.add(element.id);
      update();
    }
   }));
  }

  //Handle DateTime
  handleDate(date){
    DateTime dateTime = (date as Timestamp).toDate();
    String handleDateTime = DateFormat('MM/dd/yyyy, hh:mm a').format(dateTime);
    return handleDateTime;
  }

  // Upload Image From Camera or Gallery ...
  Future<bool?> uploadImage(String? source) async {
    final picker = ImagePicker();
    pickedImage = await picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery,imageQuality: 1);
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
  Future addPost(
      {String? text,
      GlobalKey<FormState>? textFieldkey,
      String? username,
      String? profileurl}) async {
    final formState = textFieldkey!.currentState;
    if (formState!.validate()) {
      // showLoading.value = true;
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => Center(
            child: Image.asset("assets/images/loader.gif"),
          ),
        );
      formState.save();
      // final formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
      final dateTime = DateTime.now();
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
                "profileUrl": profileurl.toString(),
                "userName": username.toString(),
                "text": text!,
                "imageUrl": imageUrl.toString(),
                "dateTime": dateTime,
                "ownerUid": uid.toString(),
                "isThereImageUrl": true,
                "likesCount": 0,
                "isHasLiked": false,
                "usersHaveSaved": {uid:false},
                "usersLiked": {uid: false},
                "edited": false
              // ignore: void_checks
          }).whenComplete( () {
            clearEditingControllers();
            Get.back(closeOverlays: true);
            Get.back();
            showLoading.value = false;
            return Get.showSnackbar(const GetSnackBar(
              messageText: CustomText2(
                text: "Uploaded Post Successfully ...",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black38,
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
            ));
            
          });
        } else {
          postsReference.add({
            "profileUrl": profileurl.toString(),
            "userName": username.toString(),
            "text": text!,
            "imageUrl": "null",
            "dateTime": dateTime,
            "ownerUid": uid.toString(),
            "isThereImageUrl": false,
            "likesCount": 0,
            "isHasLiked": false,
            "usersLiked": {uid: false},
            "usersHaveSaved": {uid:false},
          // ignore: void_checks
          }).whenComplete( () {
            clearEditingControllers();
            Get.back(closeOverlays: true);
            Get.back();
            showLoading.value = false;
            return Get.showSnackbar(const GetSnackBar(
              messageText: CustomText2(
                text: "Uploaded Post Successfully ...",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black38,
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
            ));
            // showLoading.value = false;
          });
        }
      } catch (e) {
        return Get.snackbar("Oops", "The error : ${e.toString()}");
      }
    }
  }

  uploadImageToComment({String? source}) async {
    final picker = ImagePicker();
    commentIsloaded.value = true;
    XFile? pickImage = await picker.pickImage(
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
      String? text,
      GlobalKey<FormState>? commentKey,
      String? username,
      String? profileurl}) async {
    final commentState = commentKey!.currentState!.validate();
    if (commentState == true) {
      commentKey.currentState!.save();
      getUserInfo = await FirebaseFirestore.instance
          .collection("usersInfo")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) => value.data());
      final formattedDate = DateFormat('M/d/y - kk:mm').format(DateTime.now());
      CollectionReference<Map<String, dynamic>> commentReference =
          FirebaseFirestore.instance
              .collection("posts")
              .doc(collectionOne.id)
              .collection("comments");
      try {
        if (isPickedForComment!.value) {
          TaskSnapshot uploadToStorage = await FirebaseStorage.instance
              .ref("comments")
              .child(_fileNameForComment!)
              .putFile(_imageFileForComment!);
          String imageUrl = await uploadToStorage.ref.getDownloadURL();
          commentReference.add({
            "profileUrl": profileurl,
            "userName": username,
            'text': text,
            'ownerUid': uid.toString(),
            'imageUrl': imageUrl.toString(),
            'dateTime': formattedDate.toString(),
            'isThereImageUrl': true,
            "usersLiked": {uid: false},
            'likesCount': 0,
          });
          isPickedForComment!.value = false;
        } else {
          commentReference.add({
            'text': text,
            "profileUrl": profileurl,
            "userName": username,
            'imageUrl': "null",
            'ownerUid': uid.toString(),
            'dateTime': formattedDate.toString(),
            'isThereImageUrl': false,
            "usersLiked": {uid: false},
            'likesCount': 0,
          });
        }
      } catch (e) {
        return Get.snackbar("Oops!", e.toString());
      }
      commentController.clear();
      commentIsloaded.value = false;
    }
  }

  handlePostLikes({currentPostDocData}) {
    DocumentReference<Map<String, dynamic>> likeData = FirebaseFirestore
        .instance
        .collection("posts")
        .doc(currentPostDocData.id);
    /*
     * This option will show up if the owner user has liked the post before
     * or not, and even if the user delete the app and reinstall again , so
     * he'll see he has liked before or not.
     */
    bool? isHasLiked = currentPostDocData.data()['usersLiked'][uid];
    if (isHasLiked == false) {
      int addLike = currentPostDocData.data()['likesCount'] + 1;
      likeData.set({
        'likesCount': addLike.toInt(),
        'isHasLiked': true,
        'usersLiked': {uid: true},
      }, SetOptions(merge: true));
    } else if (isHasLiked == null) {
      int addLike = currentPostDocData.data()['likesCount'] + 1;
      likeData.set({
        'likesCount': addLike.toInt(),
        'isHasLiked': true,
        'usersLiked': {uid: true},
      }, SetOptions(merge: true));
    } else {
      int removeLike = currentPostDocData.data()['likesCount'] - 1;
      likeData.set({
        'likesCount': removeLike.toInt(),
        'isHasLiked': false,
        'usersLiked': {uid: false}
      }, SetOptions(merge: true));
    }
  }

  handleCommentLikes({firstCollectionDocs, docSnapshot}) async {
    DocumentReference<Map<String, dynamic>> commentLikeData = FirebaseFirestore
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
    bool isHasLiked = await commentLikeData
        .get()
        .then((value) => value.data()!['usersLiked'][uid] == true);

    if (!isHasLiked) {
      int addLike = docSnapshot['likesCount'] + 1;
      await commentLikeData.update({
        'likesCount': addLike.toInt(),
        'isHasLiked': true,
        'usersLiked.$uid': true,
      });
    } else {
      int removeLike = docSnapshot['likesCount'] - 1;
      await commentLikeData.update({
        'likesCount': removeLike.toInt(),
        'isHasLiked': false,
        'usersLiked.$uid': false
      });
    }
  }

   getCurretUserPostsHasSaved() {
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: postsCollections.snapshots(),
      builder: (context,snapshot){
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            if(snapshot.data!.docs[index].data()['usersHaveSaved'][uid] != null){
              if(snapshot.data!.docs[index].data()['usersHaveSaved'][uid]){
                  listOfSavedPosts!.add(snapshot.data!.docs[index].id);
                update();
              }
            }
            return const SizedBox();
          });
        },
    );
  }

  savePost({required String? postDoc}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postDoc)
        .update({'usersHaveSaved.$uid': true});
  }
  unSavePost({required String postDoc}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postDoc)
        .update({'usersHaveSaved.$uid': false});
  }

  editingPost({String? text, String? postDoc, GlobalKey<FormState>? editKey}) {
    if (editKey!.currentState!.validate()) {
      editKey.currentState!.save();
      FirebaseFirestore.instance
          .collection("posts")
          .doc(postDoc)
          .update({"text": text.toString(), "edited": true}).whenComplete(() =>
              Get.snackbar("", "The post has edited successfully.",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2)));
    }
    editingPostController.clear();
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
}
