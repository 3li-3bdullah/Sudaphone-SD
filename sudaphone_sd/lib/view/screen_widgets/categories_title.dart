import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesTitle extends StatelessWidget {

  CategoriesTitle({Key? key, this.text, this.text2, this.press}) : super(key: key);

  String? text;
  String? text2;
  Function? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Text(
          text!,
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        MaterialButton(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              press!();
            },
            child: Text(text2!, style: const TextStyle(color: Colors.white)))
      ]),
    );
  }
}
