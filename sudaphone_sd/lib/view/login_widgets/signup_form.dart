import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignUpForm extends GetWidget<LoginViewModel> {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10, right: 10),
      width: MediaQuery.of(context).size.width / 1.2,
      child: Form(
        key: controller.signUpKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Start User Name----------
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
            ),
            //End User Name----------
            //Start User E-mail ----------
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
            ),
            const SizedBox(height: 30),
            //End User E-mail ----------
            //Start User Password----------
            Obx(
              () => CustomTextFormField(
                labelText: "Password",
                textEditingController: controller.passwordController!,
                obscure: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Write your password";
                  }
                },
                icon: Icons.lock_outlined,
                istrue: controller.isObSecureSignup.value,
                changeObscureValue: ()=> controller.toggle2(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //Start User Password Confirm----------

            Obx(
              () => CustomTextFormField(
                labelText: "Rewrite the password",
                textEditingController: controller.confirmPasswordController!,
                obscure: true,
                validator: (String value) {
                  if (value != controller.passwordController!.text) {
                    return "Password incorrect";
                  }
                },
                icon: Icons.lock_outlined,
                istrue: controller.isObSecureSignup.value,
                changeObscureValue: ()=> controller.toggle2(),
              ),
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
