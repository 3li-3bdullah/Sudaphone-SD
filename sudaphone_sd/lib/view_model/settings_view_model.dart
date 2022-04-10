import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsViewModel extends GetxController{

// Here we'll declaring variables
FirebaseAuth auth = FirebaseAuth.instance;
String? uid;
CollectionReference<Map<String, dynamic>> getUserData = FirebaseFirestore.instance.collection("posts");


@override
  void onInit() {
    uid = auth.currentUser!.uid;
    super.onInit();
  }
}