import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/login.dart';
import 'package:sudaphone_sd/view/mydrawer.dart';
import 'package:sudaphone_sd/view_model/main_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SudaphoneSD());
}

class SudaphoneSD extends StatelessWidget {
  const SudaphoneSD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.testMode = true;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SudaPhone SD",
      initialBinding: MyBinding(),
      home:  const Home()
    );
  }
}

class Home extends GetWidget<MainViewModel> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("You have an error! : ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          return controller.isLogin.value?  const MyDrawer() : const LogIn();
        } else {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
