import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/screen_widgets/carousel_most_used.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),

      ///drawer: MyDrawer(),
      body:  ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "This app show you mostly kind of phones and his prices , and you can add post & like & comments and more features , desinged to make to your life easier when wanna buy yor phone or sell him .",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                  TextSpan(
                    text:
                        "If there any problem or feedback please shoot message on this email : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: "SudaphoneSD@gmail.com",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(50)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              onPressed: () {
                Get.snackbar("Ali Abdullah",
                    "A programmer he's the master of his sea...");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.pink, Colors.purple]),
                ),
                child: const CustomText(
                    text: "About App Developer",
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
