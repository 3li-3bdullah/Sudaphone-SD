import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CategoriesTitle extends StatelessWidget {
 const CategoriesTitle({Key? key, this.text, this.press}) : super(key: key);

  final String? text;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        GetBuilder<ThemesViewModel>(
          builder: (controller) => Container(
            decoration:  BoxDecoration(
                color: controller.theme == ThemeMode.dark? Colors.white12 : Colors.black12,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomText(
                text: text!,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Spacer(),
        IconButton(
            // shape:
            // RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              press!();
            },
            icon: const Icon(
              Icons.arrow_forward,
              size: 30,
            ))
      ]),
    );
  }
}
