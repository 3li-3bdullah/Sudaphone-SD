import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
               'Settings',),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
            child: ListTile(
              title: const Text("The Mode"),
              trailing: const Icon(Icons.wb_sunny),
              onTap: () {
                Get.bottomSheet(Column(
                  children: [
                    ListTile(
                      title: const Text("Light Mode"),
                      leading: const Icon(Icons.wb_sunny_outlined),
                      onTap: () {
                        Get.changeTheme(ThemeData.light());
                      },
                    ),
                    ListTile(
                      title: const Text("Dark Mode"),
                      leading: const Icon(Icons.wb_sunny),
                      onTap: () {
                        Get.changeTheme(ThemeData.dark());
                      },
                    ),
                  ],
                ));
              },
            )));
  }
}
