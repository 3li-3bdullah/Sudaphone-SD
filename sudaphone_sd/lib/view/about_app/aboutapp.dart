import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_divider.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/view/about_app/components/custom_container.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
  const uri = Uri.parse("https://flutter.io");
if (await canLaunchUrl(uri)){
    await launchUrl(uri);
} else {
    throw ' can't launch $url';
}
  */

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const CustomTitle(text: "About", underLineWidget: 40),
          leading: const Leading()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
                header: "ABOUT",
                text1: "Programmed By Ali",
                text2: "view website",
                image1: 'assets/images/logo/app_logo.png',
                image2: 'assets/icons/internet.png',
                radius: 45,
                ontap1: () {},
                ontap2: () {}),
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
                ontap1: () {},
                ontap2: () {}),
            const SizedBox(
              height: 25,
            ),
            CustomText(
              text: "Sudaphone SD V1",
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
