import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sudaphone_sd/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/mydrawer.dart';
// import 'package:sudaphone_sd/view/signin.dart';
import 'package:sudaphone_sd/view_model/main_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const SudaphoneSD());
}

class SudaphoneSD extends StatelessWidget {
  const SudaphoneSD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.testMode = true;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        title: "SudaPhone SD",
        initialBinding: MyBinding(),
        home:  Home());
  }
}

// ignore: must_be_immutable
class Home extends GetWidget<MainViewModel> {
   Home({Key? key}) : super(key: key);
  ThemesViewModel contro = Get.find<ThemesViewModel>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: contro.theme,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: FutureBuilder(
        future: controller.fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                color: Colors.green,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Text(
                  "You have an error! : ${snapshot.error.toString()}",
                  style: const TextStyle(color: Colors.white),
                ));
          } else if (snapshot.hasData) {
            return controller.isLogin.value ? const MyDrawer() : const MyDrawer();
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
