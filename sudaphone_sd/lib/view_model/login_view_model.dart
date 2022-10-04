import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/view/my_drawer/mydrawer.dart';

class LoginViewModel extends GetxController {
// ((((((((((((((((((((((((((((((( VARIABLES )))))))))))))))))))))))))))))))
  UserCredential? userCredential;
  FirebaseFirestore? firebaseFirestore = FirebaseFirestore.instance;
  GlobalKey<FormState>? signInKey = GlobalKey<FormState>();
  GlobalKey<FormState>? signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState>? resetPassKey = GlobalKey<FormState>();
  /* TextEditingController */
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? emailSigninController = TextEditingController();
  TextEditingController? passwordSigninController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? usernameController = TextEditingController();
  TextEditingController? emailForResetPassword = TextEditingController();
  // Variables for upload image to FirebasaeStorage
  RxBool isThereProfileUrl = false.obs;
  String? _fileName;
  File? imageFile;
  XFile? pickImage;
  RxBool showsignin = true.obs;
  Size size = MediaQuery.of(Get.context!).size;
  String? email;
  String? imageUrl;
  RxBool isObSecureSignin = true.obs;
  RxBool isObSecureSignup = true.obs;

  /// (((((((((((((((((((((((((((( METHODS ))))))))))))))))))))))))))))

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
    emailForResetPassword = TextEditingController();
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
    emailForResetPassword!.clear();
  }

  void signInWithEmailAndPassword(
      String email, String password, GlobalKey<FormState> signInKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (signInKey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => Center(
            child: Lottie.asset("assets/lotties/loading.json"),
          ),
        );
        signInKey.currentState!.save();
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          Get.offAll(
            () => const MyDrawer(),
          );
          prefs.setString('email', email);
          Get.back(closeOverlays: true);
          Get.snackbar("", "You've signed in successfully",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 3));
        });
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
    final picker = ImagePicker();
    pickImage = await picker.pickImage(
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

  Future<void> uploadImageToFirebaseStorage() async {
    Reference reference =
        FirebaseStorage.instance.ref("login_profile").child(_fileName!);
    UploadTask uploadTask = reference.putFile(imageFile!);
    imageUrl = await (await uploadTask).ref.getDownloadURL();
  }

  /// SignUp With Username & Email & Password
  Future<void> signUpWithEmailAndPassword(String username, String email,
      String password, GlobalKey<FormState> signUpKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (signUpKey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => Center(
            child: Image.asset("assets/images/loader.gif"),
          ),
        );
        signUpKey.currentState!.save();
        final formattedDate =
            DateFormat('M/d/y - kk:mm').format(DateTime.now());
        imageUrl != null ? uploadImageToFirebaseStorage() : null;
        prefs.setString('email', email);
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          FirebaseFirestore.instance
              .collection("usersInfo")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            "userName": username.toString(),
            "email": email.toString(),
            "password": password.toString(),
            "ownerUid": FirebaseAuth.instance.currentUser!.uid.toString(),
            "registerTime": formattedDate.toString(),
            "profileUrl": imageUrl != null
                ? imageUrl.toString()
                : "https://firebasestorage.googleapis.com/v0/b/sudaphone-sd3.appspot.com/o/profile%2Fperson.png?alt=media&token=5afd3c19-bc69-4ce7-8d10-22529bfcbf1a",
          });
          Get.offAll(
            () => const MyDrawer(),
          );
          Get.back(closeOverlays: true);
          Get.snackbar("", "You've resgistered successfully",
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 3));
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("E-mail", 'The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar("Oops!", "That error was : $e",
          duration: const Duration(seconds: 5));
    }
  }

  resetPassword(GlobalKey<FormState>? key, String? email) async {
    try {
      if (key!.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (BuildContext context) => Center(
            child: Image.asset("assets/images/loader.gif"),
          ),
        );
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email!)
            .whenComplete(() {
          Get.back();
          Get.snackbar("", "Password Reset Email Sent ..",
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
        });
      }
    } catch (e) {
      Get.snackbar("Oops", e.toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.TOP);
    }
  }
}
