import 'package:flutter/material.dart';

class CategoriesLogo extends StatelessWidget {
  const CategoriesLogo({
    required this.imageLogo,
    required this.text,
    required this.onTap,
  });
  final String imageLogo;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 70,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(imageLogo), fit: BoxFit.cover),
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
