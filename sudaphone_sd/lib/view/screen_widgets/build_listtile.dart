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
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 18)),
        leading: Icon(icon, color: Colors.white, size: 25),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
