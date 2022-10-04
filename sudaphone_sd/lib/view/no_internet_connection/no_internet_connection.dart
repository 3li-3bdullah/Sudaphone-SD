import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
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
                onPressed: () {},
              ),
            ),
          ),
        ],
        leading: GetBuilder<MyDrawerViewModel>(
          builder: (controller) => IconButton(
            onPressed: () {
              return controller.value == 0.0
                  ? controller.valueOne()
                  : controller.valueZero();
            },
            icon: GetBuilder<ThemesViewModel>(
              builder: (control) => Icon(
                controller.value == 0.0 ? Icons.menu : Icons.menu_open_outlined,
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
