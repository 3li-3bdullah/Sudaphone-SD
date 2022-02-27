import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/mydrawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SudaphoneSD());
}

// ignore: use_key_in_widget_constructors
class SudaphoneSD extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SudaPhone SD",
      theme: ThemeData(primaryColor: Colors.white),
      initialBinding: MyBinding(),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("You have an error! : ${snapshot.error.toString()}");
          } else if (snapshot.hasData) {
            return const MyDrawer();
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
//"1.6.10"