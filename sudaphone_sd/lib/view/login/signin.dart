import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_dialog.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/primary_button.dart';
import 'package:sudaphone_sd/shared/constants.dart';
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: const CustomText2(
                      text: "Sudaphone SD",
                      textAlign: TextAlign.left,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kBlackColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        height: Get.height / 3.3,
                        child: Image.asset(
                          "assets/images/login/phones.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        height: Get.height / 5,
                        child: Image.asset(
                          "assets/images/login/signin.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 12),
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
                    "Forgot Password ?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.brown,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
