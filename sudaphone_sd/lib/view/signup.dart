import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/build_avatar.dart';
import 'package:sudaphone_sd/view/login_widgets/signup_form.dart';
import 'package:sudaphone_sd/view/signin.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/primary_button.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignUp extends GetWidget<LoginViewModel> {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(height: 30,),
                const BuildAvatar(),
                const SizedBox(height: 30),
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
                    const CustomText(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
