import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class SignInForm extends GetWidget<LoginViewModel> {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 1.1,
      // ),
      child: Form(
        key: controller.signInKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Start Email----------
                const CustomText(
                  text: "E-mail",
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),
                CustomTextFormField(
                  labelText: "E-mail",
                    textEditingController: controller.emailController!,
                    obscure: false,
                    validator: (String value) {
                      if (value.isEmpty) {
                       return "Please write your e-mail";
                      }
                    },
                    icon: Icons.email_outlined,
                    myhinttext: "example@gmail.com",
                    prefixColor: Colors.orange,
                    ),
                //End Email ----------
                //Start User Password----------
                const SizedBox(height:10),
                const CustomText(
                  text: "Password",
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  labelText: "Password",
                    textEditingController: controller.passwordController!,
                    obscure: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                       return "Please write your password ";
                      }
                    },
                    icon: Icons.lock_outline,
                    myhinttext: "***********",
                    prefixColor: Colors.orange,
                ),
                    const SizedBox(height:10),
                //End User Password----------
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}