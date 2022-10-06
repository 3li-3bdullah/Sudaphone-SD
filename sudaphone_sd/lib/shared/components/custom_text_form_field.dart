import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.obscure,
      this.istrue = false,
      this.changeObscureValue,
      required this.validator,
      required this.icon,
      required this.textEditingController,
      this.customHintText = "", this.iconColor = Colors.white});
  final bool obscure;
  final Function validator;
  final IconData icon;
  final String customHintText;
  final bool istrue;
  final Color iconColor;
  final Function? changeObscureValue;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure ? istrue : false,
      validator: (value) {
        return validator(value);
      },
      cursorColor: Colors.brown,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: kTextFieldColor),
        focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: kPrimaryColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: customHintText,
        contentPadding: const EdgeInsets.all(4),
        prefixIcon: Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        suffixIcon: obscure
            ? IconButton(
                onPressed: () {
                  changeObscureValue!();
                },
                icon: istrue
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.brown,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
              )
            : const SizedBox(),
        filled: true,
        fillColor: kTextFieldColor,
      ),
    );
  }
}
