import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';

class CustomRow extends StatelessWidget {
  const CustomRow(
      {Key? key,
      required this.name,
      required this.imagePath,
      required this.onTap})
      : super(key: key);
  final String name;
  final String imagePath;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(height: Get.height / 25, child: Image.asset(imagePath)),
            const SizedBox(
              width: 20,
            ),
            CustomText(
              text: name,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade700,
            )
          ],
        ),
      ),
    );
  }
}
