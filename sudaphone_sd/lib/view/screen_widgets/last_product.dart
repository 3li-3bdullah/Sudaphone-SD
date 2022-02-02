import 'package:flutter/material.dart';
import '../widgets/custom_text.dart';

class LastProduct extends StatelessWidget {
  const LastProduct({
    required this.imageProduct,
    required this.text,
    required this.onTap,
  });
  final String imageProduct;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: GridTile(
            child: Image.asset(imageProduct),
            footer: Container(
                height: 30,
                color: Colors.black.withOpacity(0.3),
                child: CustomText(
                  text: text,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                )),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}