import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/mydrawer.dart';
import 'package:sudaphone_sd/view/posts_widgets/custom_snakbar.dart';

class LoginViewModel extends GetxController {
  ///Declare and inital variables
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  FirebaseFirestore? firebaseFirestore = FirebaseFirestore.instance;
  GlobalKey<FormState>? signInKey = GlobalKey<FormState>();
  GlobalKey<FormState>? signUpKey = GlobalKey<FormState>();

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? usernameController = TextEditingController();

  // final Rxn<User> _user = Rxn<User>();
  // String? get user => _user.value?.email;
  RxBool showsignin = true.obs;

  /// Methods


  changVal() {
    return showsignin.value = !showsignin.value;
  }

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // _user.bindStream(auth.authStateChanges());
  }

  ///SignIn With Email and Password
  void signInWithEmailAndPassword(
      email, password, GlobalKey<FormState> _signInKey) async {
    if (_signInKey.currentState!.validate()) {
      _signInKey.currentState!.save();
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
             CustomSnakbar.showSnakBar(
        context: Get.context,
        title: "Done",
        message: "Successfully signin",
        backgroundColor: Colors.lightGreenAccent);
    Get.off(const MyDrawer());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Error", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Error", "Wrong password provided for that user.");
        }
      }
    }
  }

  /// SignUp With Username & Email & Password
  void signUpWithEmailAndPassword(String username, String email,
      String password, GlobalKey<FormState> _signUpKey) async {
    try {
      if (_signUpKey.currentState!.validate()) {
        _signUpKey.currentState!.save();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await firebaseFirestore!
            .collection("username")
            .doc(auth.currentUser!.uid)
            .set({"username": username});
        CustomSnakbar.showSnakBar(
            context: Get.context,
            title: "Done",
            message: "Created account successfully",
            backgroundColor: Colors.lightGreenAccent);
        Get.off(const MyDrawer());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("E-mail", 'The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar("Error", "That's error was : $e");
    }
  }
}
