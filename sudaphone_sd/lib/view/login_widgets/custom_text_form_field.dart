import 'package:flutter/material.dart';
import 'package:sudaphone_sd/constants.dart';

class CustomTextFormField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField(
      {required this.obscure,
      this.istrue = false, 
      this.changeObscureValue, 
      required this.validator,
      required this.icon,
      required this.textEditingController,
       this.customHintText = ""});
  final bool obscure;
  final Function validator;
  final IconData icon;
  // final String myhinttext;
  // final Color prefixColor;
  final String customHintText;
  final bool istrue;
  final Function? changeObscureValue;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure ? istrue : false,
      validator: (value) {
        return validator(value);
      },cursorColor: Colors.brown,
      decoration: InputDecoration(
        
        hintStyle: const TextStyle(color: kTextFieldColor),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: kPrimaryColor)),
            enabledBorder : const OutlineInputBorder(
            borderRadius:  BorderRadius.all(Radius.circular(10))
            ),
        hintText: customHintText,
        //  labelStyle: const TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.all(4),
        // hintText: myhinttext,
        
        prefixIcon: Icon(
          icon,
          color: Colors.white,
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
