import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesTitle extends StatelessWidget {

  CategoriesTitle({Key? key, this.text, this.press}) : super(key: key);

  String? text;
  Function? press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Text(
          text!,
          style: const TextStyle(fontSize: 20,color: Colors.black),
        ),
        const Spacer(),
        IconButton(
            // shape:
                // RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            onPressed: () {
              press!();
            },
            icon: const Icon(Icons.arrow_forward,color: Colors.black,size: 30,))
      ]),
    );
  }
}
