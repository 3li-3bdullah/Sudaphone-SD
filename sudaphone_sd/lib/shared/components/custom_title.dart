import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(
      {Key? key, required this.text, required this.underLineWidget, this.showUnderLine = true})
      : super(key: key);
  final String text;
  final double underLineWidget;
  final bool showUnderLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomText(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
       showUnderLine ? GetBuilder<ThemesViewModel>(
          builder: (control) => Container(
            height: 4,
            width: underLineWidget,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: control.theme == ThemeMode.dark
                    ? Colors.grey
                    : Colors.brown,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ),
        ) : const SizedBox()
      ],
    );
  }
}
