import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class CustomSignUp extends GetWidget<LoginViewModel> {
  const CustomSignUp({Key? key}) : super(key: key);

  // ignore: use_key_in_widget_constructors
  //  BuildFormSignUp({required this.globalSignUpKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(milliseconds: 500),
      // curve: Curves.easeInOutBack,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10, right: 10),
      width: MediaQuery.of(context).size.width / 1.2,
      // decoration: const BoxDecoration(
      //  color:Colors.black12,
      //  borderRadius: BorderRadius.all(Radius.circular(20),),

      // ),
      // boxShadow: [
      //   BoxShadow(
      //       color: Colors.black,
      //       blurRadius: 0.1,
      //       spreadRadius: 1,
      //       offset: Offset(1, 1),),
      // ],

      child: Form(
        key: controller.signUpKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Start User Name----------
            // const CustomText(
            //   text: "Username",
            //   color: Colors.white,
            //   fontSize: 15,
            //   fontWeight: FontWeight.w600,
            //   textAlign: TextAlign.right,
            // ),
            // const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Username",
              textEditingController: controller.usernameController!,
              obscure: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please write your name";
                }
              },
              icon: Icons.person_outline_rounded,
              myhinttext: "Username",
              // fillColor: Colors.grey.shade200,
              // enabledColor: Colors.grey,
              // focusedColor: Colors.green,
              // borderSideColor: Colors.grey,
              prefixColor: Colors.blue,
            ),
            //End User Name----------
            //Start User E-mail ----------
            // const SizedBox(height: 10),
            // const CustomText(
            //   text: "E-mail",
            //   color: Colors.white,
            //   fontSize: 15,
            //   fontWeight: FontWeight.w700,
            //   textAlign: TextAlign.right,
            // ),
            const SizedBox(height: 30),
            CustomTextFormField(
              labelText: "E-mail",
              textEditingController: controller.emailController!,
              obscure: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Write your e-mail address";
                }
              },
              icon: Icons.email_outlined,
              myhinttext: "example@gmail.com",
              // fillColor: Colors.grey.shade200,
              // enabledColor: Colors.grey,
              // focusedColor: Colors.green,
              // borderSideColor: Colors.grey,
              prefixColor: Colors.blue,
            ),
            const SizedBox(height: 30),
            //End User E-mail ----------
            //Start User Password----------
            // const CustomText(
            //   text: "Password",
            //   color: Colors.white,
            //   fontSize: 15,
            //   fontWeight: FontWeight.w600,
            //   textAlign: TextAlign.right,
            // ),
            // const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Password",
              textEditingController: controller.passwordController!,
              obscure: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Write your password";
                }
              },
              icon: Icons.lock_outlined,
              myhinttext: "***********",
              // fillColor: Colors.grey.shade200,
              // enabledColor: Colors.grey,
              // focusedColor: Colors.green,
              // borderSideColor: Colors.grey,
              prefixColor: Colors.blue,
            ),
            const SizedBox(
              height: 30,
            ),
            //Start User Password Confirm----------
            // const CustomText(
            //   text: "Confirm password",
            //   color: Colors.white,
            //   fontSize: 15,
            //   fontWeight: FontWeight.w600,
            //   textAlign: TextAlign.right,
            // ),
            // const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Rewrite the password",
              textEditingController: controller.confirmPasswordController!,
              obscure: true,
              validator: (String value) {
                if (value != controller.passwordController!.text) {
                  return "Password incorrect";
                }
              },
              icon: Icons.lock_outlined,
              myhinttext: "***********",
              // fillColor: Colors.grey.shade200,
              // enabledColor: Colors.grey,
              // focusedColor: Colors.green,
              // borderSideColor: Colors.grey,
              prefixColor: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            //End User Password Confirm----------
          ],
        ),
      ),
    );
  }
}

class SignUpButton extends GetWidget<LoginViewModel> {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 5,
            primary: Colors.grey,
            shape: const CircleBorder()),
        onPressed: () => controller.signUpWithEmailAndPassword(
            controller.usernameController!.text,
            controller.emailController!.text,
            controller.passwordController!.text,
            controller.signUpKey!),
        child: const SizedBox(
            height: 100,
            width: 100,
            child: Icon(
              Icons.arrow_forward,
              size: 30,
            )));
  }
}
