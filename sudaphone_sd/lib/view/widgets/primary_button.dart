import 'package:flutter/material.dart';
import 'package:sudaphone_sd/constants.dart';


class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function ontap;
  final Color color;
  // ignore: use_key_in_widget_constructors
  const PrimaryButton( {required this.buttonText , required this.ontap, required this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: color),
        child: Text(
          buttonText,
          style: textButton.copyWith(color: kWhiteColor),
        ),
      ),
      onTap: (){
        ontap();
      },
    );
  }
}