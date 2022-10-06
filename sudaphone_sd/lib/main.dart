import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/shared/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/my_drawer/mydrawer.dart';
import 'package:sudaphone_sd/view/login/signin.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

import 'shared/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  runApp( SudaphoneSD(email: email));
}

class SudaphoneSD extends StatelessWidget {
  const SudaphoneSD({this.email ,Key? key}) : super(key: key);
  final String? email;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      init: ThemesViewModel(),
      builder:(control)=> GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: control.theme,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          title: "SudaPhone SD",
          initialBinding: MyBinding(),
          home: email != null
                ?  const MyDrawer()
                : const SignIn()),
    );
  }
}