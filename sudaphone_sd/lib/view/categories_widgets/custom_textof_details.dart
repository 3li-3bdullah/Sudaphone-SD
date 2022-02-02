import 'package:flutter/material.dart';

class CustomTextOfDetails extends StatelessWidget {
  const CustomTextOfDetails(
      {
      required  this.text1,
      required  this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade300,
        child: RichText(
            text: TextSpan(style: const TextStyle(fontSize: 18), children: <TextSpan>[
          TextSpan(text: text1, style: const TextStyle(color: Colors.black)),
          TextSpan(text: text2, style: TextStyle(color: Colors.grey.shade900)),
        ])));
  }
}