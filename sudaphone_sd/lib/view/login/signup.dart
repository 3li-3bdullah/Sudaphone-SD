import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/login/components/build_avatar.dart';
import 'package:sudaphone_sd/view/login/components/signup_form.dart';
import 'package:sudaphone_sd/view/login/signin.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/primary_button.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignUp extends GetWidget<LoginViewModel> {
  const SignUp({Key? key}) : super(key: key);

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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                height: Get.height / 5,
                                child: Image.asset(
                                    "assets/images/login/signup.png",
                                    fit: BoxFit.cover),
                              ),
                              const CustomText2(
                                  text: "Welcome To",
                                  textAlign: TextAlign.left,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kBlackColor),
                              // Container(
                              //   height: 4,
                              //   width: 80,
                              //   alignment: Alignment.centerLeft,
                              //   decoration: const BoxDecoration(
                              //     color: Colors.brown,
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(5),
                              //     ),
                              //   ),
                              // ),
                              const CustomText2(
                                  text: "S u d a p h o n e S D",
                                  textAlign: TextAlign.left,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: kBlackColor),
                              // Container(
                              //   height: 4,
                              //   width: 140,
                              //   alignment: Alignment.centerLeft,
                              //   decoration: const BoxDecoration(
                              //     color: Colors.brown,
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(5),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: BuildAvatar()),
                  ],
                ),
                const SizedBox(height: 20),
                const SignUpForm(),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  color: Colors.brown,
                  buttonText: "Sign Up",
                  ontap: () => controller.signUpWithEmailAndPassword(
                      controller.usernameController!.text,
                      controller.emailController!.text,
                      controller.passwordController!.text,
                      controller.signUpKey!),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText2(
                        text: "Do you have an acount ? ",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center),
                    InkWell(
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.brown,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Get.to(() => const SignIn(),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 300));
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
