import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
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
            const CustomText2(
              text: "Username",
              color: Colors.brown,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),
            CustomTextFormField(
              customHintText: "Username",
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
            const SizedBox(height: 15),
            const CustomText2(
              text: "E-mail",
              color: Colors.brown,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            CustomTextFormField(
              customHintText: "E-mail",
              textEditingController: controller.emailController!,
              obscure: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Write your e-mail address";
                } else if (!EmailValidator.validate(value.trim())) {
                  return "The e-mail not valid";
                }
              },
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 15),
            //End User E-mail ----------
            //Start User Password----------
            const CustomText2(
              text: "Password",
              color: Colors.brown,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),
            Obx(
              () => CustomTextFormField(
                customHintText: "Password",
                textEditingController: controller.passwordController!,
                obscure: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Write your password";
                  }
                },
                icon: Icons.lock_outlined,
                istrue: controller.isObSecureSignup.value,
                changeObscureValue: () => controller.toggle2(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //Start User Password Confirm----------
            const CustomText2(
              text: "Confirm password",
              color: Colors.brown,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),
            Obx(
              () => CustomTextFormField(
                customHintText: "Rewrite the password",
                textEditingController: controller.confirmPasswordController!,
                obscure: true,
                validator: (String value) {
                  if (value != controller.passwordController!.text) {
                    return "Password incorrect";
                  }
                },
                icon: Icons.lock_outlined,
                istrue: controller.isObSecureSignup.value,
                changeObscureValue: () => controller.toggle2(),
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
