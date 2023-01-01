import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function ontap;
  final Color color;
  // ignore: use_key_in_widget_constructors
  const PrimaryButton(
      {required this.buttonText, required this.ontap, required this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            color: color),
        child: Text(
          buttonText,
          style: textButton.copyWith(
              color: kWhiteColor, fontWeight: FontWeight.w500),
        ),
      ),
      onTap: () {
        ontap();
      },
    );
  }
}
