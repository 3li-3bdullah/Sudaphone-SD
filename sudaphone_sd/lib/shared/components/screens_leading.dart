import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key, required this.color, required this.horizontal, required this.vertical}) : super(key: key);
  final Color color;
  final double horizontal;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical),
      child: const Divider(
        color: Colors.white,
      ),
    );
  }
}