import 'package:flutter/material.dart';

class BuildAvatar extends StatelessWidget {
  const BuildAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 100,
      child: CircleAvatar(radius: 100, child: Icon(Icons.person, size: 80 , color:Colors.white)),
    );
  }
}
