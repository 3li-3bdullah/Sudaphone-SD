import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CustomText(
          text: "About",
          fontSize: 20,
          fontWeight: FontWeight.normal,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: const Leading()
      ),
      

      ///drawer: MyDrawer(),
      body: ListView(
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   margin: const EdgeInsets.all(10),
          //   child: RichText(
          //     text: const TextSpan(
          //       style: TextStyle(fontSize: 15),
          //       children: <TextSpan>[
          //         TextSpan(
          //             text:
          //                 "This app show you mostly kind of phones and his prices , and you can add post & like & comments and more features , desinged to make to your life easier when wanna buy yor phone or sell him .",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700, color: Colors.black)),
          //         TextSpan(
          //           text:
          //               "If there any problem or feedback please shoot message on this email : ",
          //           style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.w700,
          //               color: Colors.black),
          //         ),
          //         TextSpan(
          //           text: "SudaphoneSD@gmail.com",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w700, color: Colors.green),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Padding(padding: EdgeInsets.all(50)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              onPressed: () {
                Get.snackbar("Ali Abdullah",
                    "The programmer that he's the master of his sea...");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.pink, Colors.purple]),
                ),
                child: CustomText(
                    text: "About App Developer",
                    textAlign: TextAlign.center,
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
