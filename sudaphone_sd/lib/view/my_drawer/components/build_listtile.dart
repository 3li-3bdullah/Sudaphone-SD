import 'package:flutter/material.dart';

class BuildListTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const BuildListTile({
    required this.text,
    required this.onTap,
    required this.icon,
  });
  final String text;
  final Function onTap;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(icon),
              color: Colors.white,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
