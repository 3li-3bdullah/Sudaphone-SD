import 'package:flutter/material.dart';

class DotShape extends StatelessWidget {
  const DotShape({Key? key, required this.left, required this.right}) : super(key: key);
  final double left;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left,right: right),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
