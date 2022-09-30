import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class ScreenAppBar extends StatelessWidget {
  const ScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<ThemesViewModel>(
          builder: (control) => Container(
            height: 4,
            width: 30,
            decoration: BoxDecoration(
              color:
                  control.theme == ThemeMode.dark ? Colors.grey : Colors.brown,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomText(
          text: "Sudaphone SD",
          fontSize: 20,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          width: 5,
        ),
        GetBuilder<ThemesViewModel>(
          builder: (control) => Container(
            height: 4,
            width: 30,
            decoration: BoxDecoration(
              color:
                  control.theme == ThemeMode.dark ? Colors.grey : Colors.brown,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
