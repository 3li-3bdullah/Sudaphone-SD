import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';

class ScreenAppBar extends StatelessWidget {
  const ScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: "Sudaphone SD",
          fontSize: 18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: Image.asset(
            "assets/images//logo/app_logo.png",
          ),
        )
      ],
    );
  }
}
