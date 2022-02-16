import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DrawerChild extends StatelessWidget {
  const DrawerChild({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Lastest Phones",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Lottie.asset("assets/images/no_data.json"),],),
        ),
      );
  }
}