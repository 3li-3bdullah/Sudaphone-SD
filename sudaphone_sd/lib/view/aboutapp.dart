import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "حول التطبيق",
                  ),
              centerTitle: true,
              elevation:0,
              backgroundColor:Colors.white,
            ),

            ///drawer: MyDrawer(),
            body: ListView(
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
                              "بعرض لك هذا التطبيق معظم انواع التلفوات وسعرها بالجنية السوداني",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      TextSpan(
                          text:
                              "إذا واجهتك أي مشكلة يمكنك مراسلتي عبر البريد التالي : ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                      TextSpan(
                          text: "Alieko.A50@gmail.com",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.green)),
                    ],
                  )),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextButton(
                    onPressed: () {
                      Get.snackbar("Ali Abdullah",
                          "Programmer only working freelancer & from home");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.green ,
                         Colors.red]),
                      ),
                      child: const CustomText(text: "حول مطور التطبيق",
                       textAlign: TextAlign.center, color: Colors.white,
                        fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ),
                )
              ],
            )));
  }
}
