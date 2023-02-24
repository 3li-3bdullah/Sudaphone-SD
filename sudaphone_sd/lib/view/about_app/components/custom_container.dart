import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/screens_leading.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';

import '../../../view_model/themes_view_model.dart';

class CustomContainer extends GetWidget<ThemesViewModel> {
  const CustomContainer(
      {Key? key,
      this.text1Size = 15,
      required this.text1,
      required this.text2,
      required this.image1,
      required this.image2,
      required this.header,
      required this.radius,
      required this.ontap1,
      required this.ontap2})
      : super(key: key);
  final String text1;
  final String text2;
  final String image1;
  final String image2;
  final String header;
  final double radius;
  final Function ontap1;
  final Function ontap2;
  final double text1Size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color:
                controller.theme == ThemeMode.dark ? kDark2 : Colors.brown[300],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              controller.theme == ThemeMode.dark
                  ? BoxShadow(
                      offset: Offset(5, 5),
                      color: Colors.black26,
                      blurRadius: 3)
                  : BoxShadow(),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: CustomText2(
                text: header,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    ontap1();
                  },
                  child: Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: radius,
                        backgroundImage: AssetImage(image1)),
                    SizedBox(
                      width: 20,
                    ),
                    CustomText2(
                      text: text1,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    )
                  ]),
                ),
              ],
            ),
            CustomDivider(color: Colors.grey, horizontal: 20, vertical: 8),
            InkWell(
              onTap: () {
                ontap2();
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(image2)),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText2(
                    text: text2,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
