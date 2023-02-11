import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/shared/components/custom_dialog.dart';
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
    if (signInKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) => Center(
            child: Image.asset(
          "assets/images/loader.gif",
          fit: BoxFit.cover,
        )),
      );
      try {
        signInKey.currentState!.save();
        prefs.setString('email', email);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((e) {
          emailSigninController!.clear();
          passwordSigninController!.clear();
           Get.back();
          Get.off(() => const MyDrawer());
          Get.snackbar("Welcome!", "You've signed in successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.brown.shade300,
              colorText: Colors.white,
              duration: const Duration(seconds: 3));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.back(closeOverlays: true);
          CustomDialog.ShowCustomDialog(body: 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.back(closeOverlays: true);
          CustomDialog.ShowCustomDialog(body: 'Wrong password provided for that user.');
        }
      }
    }
  }

  // Upload A Picture That User Was choose
  uploadProfilePic({String? source}) async {
    final picker = ImagePicker();
    pickImage = await picker.pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50);
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
  Future<void> signUpWithEmailAndPassword(String username, String email,
      String password, GlobalKey<FormState> signUpKey) async {
    if (signUpKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) => Center(
          child: Image.asset("assets/images/loader.gif"),
        ),
      );
      try {
        signUpKey.currentState!.save(); 
        final formattedDate =
            DateFormat('M/d/y - kk:mm').format(DateTime.now());
        Reference reference =
            FirebaseStorage.instance.ref("login_profile").child(_fileName!);
        UploadTask uploadTask = reference.putFile(imageFile!);
        imageUrl = await (await uploadTask).ref.getDownloadURL();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((e) {
          prefs.setString('email', email);
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
          usernameController!.clear();
          emailController!.clear();
          passwordController!.clear();
          Get.back();
          Get.off(() => MyDrawer());
          Get.snackbar("Welcome!", "You've resgistered successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.brown.shade300,
              colorText: Colors.white,
              duration: const Duration(seconds: 3));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          return CustomDialog.ShowCustomDialog(body: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.back();
          return CustomDialog.ShowCustomDialog(body: 'The account already exists for that email.');
        }
      } catch (e) {
        Get.back();
        return CustomDialog.ShowCustomDialog(body: 'That error was : $e');
      }
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
          Get.snackbar("Reset", "Password Reset Email Sent ..",
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green.shade200,
              snackPosition: SnackPosition.BOTTOM);
        });
      }
    } catch (e) {
      CustomDialog.ShowCustomDialog(body: e.toString());
      // Get.snackbar("Oops", e.toString(),
      //     duration: const Duration(seconds: 5),
      //     snackPosition: SnackPosition.TOP);
    }
  }
}
