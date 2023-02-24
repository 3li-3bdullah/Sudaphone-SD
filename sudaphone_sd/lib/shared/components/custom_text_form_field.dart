import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.obscure,
      this.istrue = false,
      this.changeObscureValue,
      required this.validator,
      required this.icon,
      this.maxLength = 0,
      required this.textEditingController,
      this.customHintText = "",
      this.textColor = Colors.black45,
      this.iconColor = Colors.white});
  final bool obscure;
  final Function validator;
  final IconData icon;
  final String customHintText;
  final bool istrue;
  final Color iconColor;
  final Function? changeObscureValue;
  final TextEditingController textEditingController;
  final int maxLength;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure ? istrue : false,
      validator: (value) {
        return validator(value);
      },
      maxLength: maxLength != 0 ? maxLength : null,
      cursorColor: Colors.brown,
      style:   TextStyle(color: textColor, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: textColor),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        hintText: customHintText,
        contentPadding: const EdgeInsets.all(4),
        prefixIcon: Icon(
          icon,
          color: Colors.brown.shade300,
          size: 30,
        ),
        suffixIcon: obscure
            ? IconButton(
                onPressed: () {
                  changeObscureValue!();
                },
                icon: istrue
                    ? Icon(
                        Icons.visibility_off,
                        color: Colors.brown.shade300,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
              )
            : const SizedBox(),
        filled: true,
        fillColor: Colors.black12,
      ),
    );
  }
}
