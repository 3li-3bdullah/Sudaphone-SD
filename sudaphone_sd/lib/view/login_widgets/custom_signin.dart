import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class CustomSignIn extends GetWidget<LoginViewModel> {
  const CustomSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
      // margin: const EdgeInsets.only(top: 40),
      height: 209,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: const BoxDecoration(
       color:Colors.black12,
       borderRadius: BorderRadius.all(Radius.circular(20),),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     blurRadius: 0.1,
        //     spreadRadius: 1,
        //     offset: Offset(1, 1),
        //   ),
        // ],
      ),
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
                    textEditingController: controller.emailController!,
                    obscure: false,
                    validator: (value) {
                      if (value == null) {
                       return "Please write your name";
                      }
                    },
                    icon: Icons.email_outlined,
                    myhinttext: "example@gmail.com",
                    prefixColor: Colors.purple.shade300,
                    fillColor: Colors.grey.shade200,
                    enabledColor: Colors.grey,
                    focusedColor: Colors.green,
                    borderSideColor: Colors.grey),
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
                    textEditingController: controller.passwordController!,
                    obscure: true,
                    validator: (value) {
                      if (value == null) {
                       return "Please write your password ";
                      }
                    },
                    icon: Icons.lock_outline,
                    myhinttext: "***********",
                    prefixColor: Colors.purple.shade300,
                    fillColor: Colors.grey.shade200,
                    enabledColor: Colors.grey,
                    focusedColor: Colors.green,
                    borderSideColor: Colors.grey),
                //End User Password----------
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends GetWidget<LoginViewModel> {
  const SignInButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
            elevation: 10,
            color: Colors.purple.shade300,
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              onPressed: () => controller.signInWithEmailAndPassword(controller.emailController!.text,
                  controller.passwordController!.text,
                  controller.signInKey!
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    text: "Sign In",
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.only(right: 10),
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
  }
}