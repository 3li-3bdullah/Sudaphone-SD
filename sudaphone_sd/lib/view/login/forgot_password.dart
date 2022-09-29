import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text_form_field.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/components/primary_button.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class ForgotPassword extends GetWidget<LoginViewModel> {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Forgot Password", underLineWidget: 60),
        leading: const Leading(),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        height: controller.size.height,
        width: controller.size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomText(
                  text: "Receive an email to \n reset your password",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.resetPassKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        customHintText: "E-mail",
                        obscure: false,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? "Enter a valid e-mail"
                                : null,
                        icon: Icons.email_outlined,
                        textEditingController:
                            controller.emailForResetPassword!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                          buttonText: "Reset Password",
                          ontap: () => controller.resetPassword(
                              controller.resetPassKey,
                              controller.emailForResetPassword!.text.trim()),
                          color: Colors.brown)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
