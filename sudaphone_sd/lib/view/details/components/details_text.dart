import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({Key? key, required this.detail, required this.text}) : super(key: key);
  final String detail;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText2(
                text: "⚫️ ",
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 5),
              CustomText(
                text: "$detail :",
                fontSize: 14,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        CustomText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
