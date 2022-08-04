import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudaphone_sd/view/signin.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: "Sudaphone SD",
            fontSize: 20,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 0,
        actions: [
          GetBuilder<ThemesViewModel>(
            builder: (control) => Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: IconButton(
                icon: Image(
                  image: const AssetImage("assets/images/icons/search.png"),
                  height: 22,
                  width: 22,
                  color: control.theme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: ()  {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.remove('email');
                  // prefs.remove('uid');
                  // Get.offAll(()=> const SignIn());
                },
              ),
            ),
          ),
        ],
        leading: GetX<MyDrawerViewModel>(
          builder: (controller) => IconButton(
            onPressed: () {
              return controller.value.value == 0.0
                  ? controller.valueOne()
                  : controller.valueZero();
            },
            icon: controller.value.value == 0.0
                ? GetBuilder<ThemesViewModel>(
                    builder: (control) => Icon(
                      Icons.menu,
                      color: control.theme == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : GetBuilder<ThemesViewModel>(
                    builder: (control) => Icon(
                      Icons.menu_open_outlined,
                      color: control.theme == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Expanded(child: Lottie.asset("assets/lotties/no_internet.json")),
      ),
    );
  }
}
