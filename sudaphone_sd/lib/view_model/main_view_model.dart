import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController{
String uid = FirebaseAuth.instance.currentUser!.uid;
Future<FirebaseApp> fbApp = Firebase.initializeApp();



}