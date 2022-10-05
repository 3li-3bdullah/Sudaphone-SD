import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';

class ChooseImageIcon extends StatelessWidget {
  const ChooseImageIcon({Key? key, required this.text, required this.ontap, required this.icon, required this.color}) : super(key: key);
  final String text;
  final Function ontap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
           Icon(icon, color: color, size: 25),
           const SizedBox(
              width: 10,
            ),
            CustomText(
              text: text,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {ontap();},
    );
  }
}
