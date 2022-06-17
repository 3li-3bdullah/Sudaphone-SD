import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  CustomListTile(
      {required this.text, required this.image, required this.onTap, Key? key})
      : super(key: key);
  String text;
  String image;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 80,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
