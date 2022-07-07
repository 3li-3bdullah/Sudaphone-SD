import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sudaphone_sd/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/mydrawer.dart';
import 'package:sudaphone_sd/view/posts.dart';
import 'package:sudaphone_sd/view/settings.dart';
import 'package:sudaphone_sd/view/signin.dart';
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
    // Get.testMode = true;
    return GetBuilder<ThemesViewModel>(
      init: ThemesViewModel(),
      builder:(control)=> GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: control.theme,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          // theme: ThemeData(fontFamily: 'Poppins'),
          title: "SudaPhone SD",
          initialBinding: MyBinding(),
          home: FirebaseAuth.instance.currentUser != null
                ?  const MyDrawer()
                : const SignIn()),
    );
  }
}