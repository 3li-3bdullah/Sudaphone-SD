import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/primary_button.dart';
import 'package:sudaphone_sd/view/login/components/signin_form.dart';
import 'package:sudaphone_sd/view/login/forgot_password.dart';
import 'package:sudaphone_sd/view/login/signup.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignIn extends GetWidget<LoginViewModel> {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      const CustomText2(
                          text: "Sudaphone SD",
                          textAlign: TextAlign.left,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                      Container(
                        height: 4,
                        width: 160,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 2.8,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: controller.size.height / 2.8,
                        width: controller.size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                            color: Colors.brown,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      Image.asset(
                        "assets/images/login/login_logo.png",
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const SignInForm(),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    color: Colors.brown,
                    buttonText: "Sign In",
                    ontap: () {
                      controller.signInWithEmailAndPassword(
                          controller.emailSigninController!.text,
                          controller.passwordSigninController!.text,
                          controller.signInKey!);
                    }),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const ForgotPassword(),
                      transition: Transition.zoom,
                    );
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.brown,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText2(
                        text: "Don't have an acount ? ",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center),
                    InkWell(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.brown,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Get.to(() => const SignUp(),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 300));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
