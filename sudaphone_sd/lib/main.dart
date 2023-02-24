import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sudaphone_sd/shared/my_binding/my_binding.dart';
import 'package:sudaphone_sd/view/my_drawer/mydrawer.dart';
import 'package:sudaphone_sd/view/login/signin.dart';
import 'package:sudaphone_sd/view/no_internet_connection/no_internet_connection.dart';
import 'package:sudaphone_sd/view/splash_screen/splash_screen.dart';
import 'package:sudaphone_sd/view_model/splash_screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

import 'shared/constants.dart';

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
    return GetBuilder<ThemesViewModel>(
      init: ThemesViewModel(),
      builder: (control) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: control.theme,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          title: "SudaPhone SD",
          initialBinding: MyBinding(),
          home: GetX<SplashScreenViewModel>(
            builder: (controller) {
              return AnimatedSplashScreen(
                splash: SplashScreen(),
                nextScreen: controller.internetConnectionChecker.value
                    ? control.email != null
                        ? const MyDrawer()
                        : const SignIn()
                    : NoInternetConnection(),
                splashIconSize: Get.height,
              );
            },
          )),
    );
  }
}
