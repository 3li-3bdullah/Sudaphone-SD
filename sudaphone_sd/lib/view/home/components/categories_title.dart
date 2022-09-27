import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CategoriesTitle extends StatelessWidget {
  const CategoriesTitle(
      {Key? key, this.text, this.press, required this.underLineWidget})
      : super(key: key);

  final String? text;
  final Function? press;
  final double underLineWidget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          GetBuilder<ThemesViewModel>(
            builder: (controller) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText2(
                    text: text!,
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 4,
                  width: underLineWidget,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                )
              ],
            ),
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                press!();
              },
              child: CustomText2(
                color: Colors.brown.shade300,
                text: "View All",
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
