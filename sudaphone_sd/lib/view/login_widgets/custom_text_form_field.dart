import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField({
    required this.obscure,
    required this.validator,
    required this.icon,
    required this.myhinttext,
    // required this.fillColor,
    // required this.enabledColor,
    // required this.focusedColor,
    // required this.borderSideColor,
    required this.prefixColor,
    required this.textEditingController,
    required this.labelText
  });
  final bool obscure;
  final Function validator;
  final IconData icon;
  final String myhinttext;
  // final Color fillColor;
  // final Color enabledColor;
  // final Color focusedColor;
  // final Color borderSideColor;
  final Color prefixColor;
  final String labelText;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,

      obscureText: obscure,
      validator:(value){
        return validator(value);
      },
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(4),
        hintText: myhinttext,
        prefixIcon: Icon(icon, color: prefixColor),
        // filled: true,
        // fillColor: fillColor,
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: enabledColor, style: BorderStyle.solid, width: 1),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: focusedColor, style: BorderStyle.solid, width: 1),
        // ),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: borderSideColor, style: BorderStyle.solid, width: 1),
        // ),
      ),
    );
  }
}
