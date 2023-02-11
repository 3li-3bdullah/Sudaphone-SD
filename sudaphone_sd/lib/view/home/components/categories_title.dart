import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CategoriesTitle extends StatelessWidget {
  const CategoriesTitle(
      {Key? key, this.text, this.press, required this.underLineWidget, this.showViewAll = false})
      : super(key: key);

  final String? text;
  final Function? press;
  final double underLineWidget;
  final bool showViewAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          GetBuilder<ThemesViewModel>(
              builder: (controller) =>
                  CustomTitle(text: text!, underLineWidget: underLineWidget)),
          const Spacer(),
      showViewAll ?  TextButton(
              onPressed: () {
                press!();
              },
              child: CustomText2(
                color: Colors.brown.shade300,
                text: "View all",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              )) : const SizedBox(),
        ],
      ),
    );
  }
}
