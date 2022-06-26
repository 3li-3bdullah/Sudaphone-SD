import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/signin_form.dart';
import 'package:sudaphone_sd/view/signup.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/primary_button.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignIn extends GetWidget<LoginViewModel> {
  const SignIn({Key? key}) : super(key: key);

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
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.height / 1.5,
                  child: Image.asset(
                    "assets/images/login/login_logo.png",
                    fit: BoxFit.cover,
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
                  ontap: () => controller.signInWithEmailAndPassword(
                      controller.emailSigninController!.text,
                      controller.passwordSigninController!.text,
                      controller.signInKey!),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
