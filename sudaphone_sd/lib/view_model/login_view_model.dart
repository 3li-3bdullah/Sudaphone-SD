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
import 'package:sudaphone_sd/view/mydrawer.dart';
import 'package:sudaphone_sd/view/posts_widgets/custom_snakbar.dart';

class LoginViewModel extends GetxController {
  ///Declare and inital variables
  // for user authentications
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  FirebaseFirestore? firebaseFirestore = FirebaseFirestore.instance;
  GlobalKey<FormState>? signInKey = GlobalKey<FormState>();
  GlobalKey<FormState>? signUpKey = GlobalKey<FormState>();
  // TextEditingController for login fields
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? emailSigninController = TextEditingController();
  TextEditingController? passwordSigninController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? usernameController = TextEditingController();
  // Variables for upload image to FirebasaeStorage
  RxBool isThereProfileUrl = false.obs;
  String? _fileName;
  File? imageFile;
  XFile? pickImage;
  RxBool showsignin = true.obs;

  RxBool isObSecureSignin = true.obs;
  RxBool isObSecureSignup = true.obs;

  RxBool showLoading = false.obs;

  /// Methods

  toggle1() {
    isObSecureSignin.value = !isObSecureSignin.value;
  }

  toggle2() {
    isObSecureSignup.value = !isObSecureSignup.value;
  }

  signinOrSignup() {
    return showsignin.value = !showsignin.value;
  }

  @override
  void onInit() {
    super.onInit();
    emailSigninController = TextEditingController();
    passwordSigninController = TextEditingController();
    usernameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // _user.bindStream(auth.authStateChanges());
  }

  @override
  void onClose() {
    super.onClose();
    emailSigninController!.clear();
    passwordSigninController!.clear();
    usernameController!.clear();
    confirmPasswordController!.clear();
    emailController!.clear();
    passwordController!.clear();
  }

  ///SignIn With Email and Password
  void signInWithEmailAndPassword(
      String email, String password, GlobalKey<FormState> signInKey) async {
    try {
      if (signInKey.currentState!.validate()) {
        showLoading.value = true;
        signInKey.currentState!.save();
        print("$email &  $password *************************************8");
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        showLoading.value = false;
        CustomSnakbar.showSnakBar(
            context: Get.context,
            title: "Done",
            message: "Successfully signin",
            backgroundColor: kPrimaryColor);
        Get.off(() => const MyDrawer(), transition: Transition.circularReveal);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Oops!", "Wrong password provided for that user.");
      }
    }
  }

  // Upload A Picture That User Was choose
  uploadProfilePic({String? source}) async {
    final _picker = ImagePicker();
    pickImage = await _picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    int rand = Random().nextInt(1000000);
    _fileName = rand.toString() + pickImage!.name;
    imageFile = File(pickImage!.path);
    update();
    if (source != null) {
      return isThereProfileUrl.value = true;
    } else {
      return isThereProfileUrl.value = false;
    }
  }

  /// SignUp With Username & Email & Password
  void signUpWithEmailAndPassword(String username, String email,
      String password, GlobalKey<FormState> _signUpKey) async {
    try {
      if (_signUpKey.currentState!.validate()) {
        showLoading.value = true;
        final _formattedDate =
            DateFormat('M/d/y - kk:mm').format(DateTime.now());
        _signUpKey.currentState!.save();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        TaskSnapshot _uploadToStorage = await FirebaseStorage.instance
            .ref("login_profile")
            .child(_fileName!)
            .putFile(imageFile!);
        String _imageUrl = await _uploadToStorage.ref.getDownloadURL();
        firebaseFirestore!
            .collection("usersInfo")
            .doc(auth.currentUser!.uid)
            .set({
          "userName": username.toString(),
          "email": email.toString(),
          "password": password.toString(),
          "ownerUid": auth.currentUser!.uid.toString(),
          "registerTime": _formattedDate.toString(),
          "profileUrl": _imageUrl.toString()
        });
        showLoading.value = false;
        CustomSnakbar.showSnakBar(
            context: Get.context,
            title: "Done",
            message: "Created account successfully",
            backgroundColor: kPrimaryColor);
        Get.off(() => const MyDrawer(),transition: Transition.circularReveal);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("E-mail", 'The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar("Oops!", "That's error was : $e");
    }
  }
}
