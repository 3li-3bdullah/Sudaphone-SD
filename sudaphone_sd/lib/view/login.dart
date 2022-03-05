import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/build_avatar.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signin.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signup.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class LogIn extends GetWidget<LoginViewModel> {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // const SizedBox(
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [Colors.pink.shade300, Colors.purple.shade300],
          //         begin: Alignment.topLeft,
          //         end: Alignment.topLeft),
          //   ),
          // ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black38,
          ),
           SingleChildScrollView(
            child:  Obx(
              () =>  Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Center(
                    //     child: Container(
                    //         margin: const EdgeInsets.only(top: 30),
                    //         child: Text(
                    //             controller.showsignin.value
                    //                 ? "تسجيل الدخول"
                    //                 : "إنشاء حساب",
                    //             style: const TextStyle(
                    //                 color: Colors.white, fontSize: 20,),),),),
                    // const Padding(padding: EdgeInsets.only(top: 20),),
                    controller.showsignin.value
                        ? const BuildAvatar()
                        : const SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.showsignin.value
                        ? const CustomSignUp()
                        : const CustomSignIn(),
                    const SizedBox(
                      height: 30,
                    ),
                    controller.showsignin.value
                        ? const SignUpButton()
                        : const SignInButton(),
                    const SizedBox(
                      height: 20,
                    ), InkWell(
                        onTap: () {
                          controller.changVal();
                        },
                        child: controller.showsignin.value
                            ? const CustomText(
                                text: "Sign in",
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center)
                            : const CustomText(
                                text: "Create a ccount",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                                textAlign: TextAlign.center),
                      ),
                  ],
                ),
            ),
            ),
        ],
      ),
    );
  }
}
