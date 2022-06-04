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
    return TextFormField(style: const TextStyle(color: Colors.white),
      controller: textEditingController,
      
      obscureText: obscure,
      validator:(value){
        return validator(value);
      },
      decoration: InputDecoration(
        
        labelText: labelText,labelStyle: const TextStyle(color: Colors.white ),
        contentPadding: const EdgeInsets.all(4),
        // hintText: myhinttext,
        prefixIcon: Icon(icon, color: Colors.white , size: 30,),
        // filled: true,
        // fillColor: fillColor,
        
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
              color: Colors.white, style: BorderStyle.solid, width: 1),
        ),
        focusedBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
              color: Colors.white, style: BorderStyle.solid, width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50),),
          borderSide: BorderSide(
              color: Colors.white, style: BorderStyle.solid, width: 1),
        ),
      ),
    );
  }
}
