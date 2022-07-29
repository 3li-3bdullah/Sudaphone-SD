import 'package:flutter/cupertino.dart';

class CustomText2 extends StatelessWidget {
  const CustomText2({
    Key? key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    required this.color,
  }) : super(key: key);
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign!,
      style:
          TextStyle(color: color, fontSize: fontSize!, fontWeight: fontWeight),
    );
  }
}
