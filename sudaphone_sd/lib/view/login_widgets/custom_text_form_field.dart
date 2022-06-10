import 'package:flutter/material.dart';
import 'package:sudaphone_sd/constants.dart';

class CustomTextFormField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField(
      {required this.obscure,
      required this.validator,
      required this.icon,
      required this.myhinttext,
      required this.prefixColor,
      required this.textEditingController,
      required this.labelText});
  final bool obscure;
  final Function validator;
  final IconData icon;
  final String myhinttext;
  final Color prefixColor;
  final String labelText;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: kTextFieldColor),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: kPrimaryColor)),
            enabledBorder : const OutlineInputBorder(
            borderRadius:  BorderRadius.all(Radius.circular(10))
            ),
        labelText: labelText, labelStyle: const TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.all(4),
        // hintText: myhinttext,
        prefixIcon: Icon(
          icon,
          color: Colors.brown,
          size: 30,
        ),
        filled: true,
        fillColor: kTextFieldColor,
      ),
    );
  }
}
