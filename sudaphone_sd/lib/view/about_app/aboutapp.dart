import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_leading.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/view/about_app/components/custom_container.dart';
import 'package:sudaphone_sd/view_model/about_app_view_model.dart';

class AboutApp extends GetWidget<AboutAppViewModel> {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const CustomTitle(text: "About", underLineWidget: 40),
          leading: const ScreensLeading()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              header: "ABOUT",
              text1: "Programmed By Ali Abdullah",
              text2: "view website",
              image1: 'assets/images/logo/app_logo.png',
              image2: 'assets/icons/internet.png',
              text1Size: 14,
              radius: 45,
              ontap1: () {},
              ontap2: () =>
                  controller.openBrowser("https://github.com/3li-3bdullah"),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomContainer(
              text1: "Twitter",
              text2: "LinkedIn",
              image1: 'assets/icons/twitter.png',
              image2: 'assets/icons/linkedin.png',
              header: "FOLLOW ME TO STAY UPDATED!",
              radius: 13,
              ontap1: () => controller.openBrowser(
                  "https://twitter.com/AliAbdullah49?t=z4wZLzopviVZ3F6zfecENg&s=09"),
              ontap2: () => controller
                  .openBrowser("https://www.linkedin.com/in/3li-3bdullah"),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomText(
              text: "Sudaphone SD V1.0.0",
              fontSize: 18,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
