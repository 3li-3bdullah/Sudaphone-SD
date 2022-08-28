import 'package:flutter/material.dart';
import '../widgets/custom_text.dart';

class CategoriesCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CategoriesCard({
    required this.imageCat,
    required this.text,
    required this.onTap,
  });
  final String imageCat;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
          child: Card(
              elevation: 3,
              child: SizedBox(
                height: 170,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        imageCat,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomText(
                      text: text,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )),
          onTap: () {
            onTap();
          }),
    );
  }
}
