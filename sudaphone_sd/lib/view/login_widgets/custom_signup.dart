import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_text_form_field.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class CustomSignUp extends GetWidget<LoginViewModel> {
  const CustomSignUp({Key? key}) : super(key: key);

  // ignore: use_key_in_widget_constructors
  //  BuildFormSignUp({required this.globalSignUpKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      alignment: Alignment.center,
      // margin: EdgeInsets.only(top: controller.showsignin.value ? 40 : 20),
      height: 380,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: const BoxDecoration(
       color:Colors.black12,
       borderRadius: BorderRadius.all(Radius.circular(20),),
        
      ),
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
            const CustomText(
              text: "Username",
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              textEditingController: controller.usernameController!,
              obscure: false,
              validator: (value) {
                if (value == null) {
                  return "Please write your name";
                }
              },
              icon: Icons.person_outline_rounded,
              myhinttext: "username",
              fillColor: Colors.grey.shade200,
              enabledColor: Colors.grey,
              focusedColor: Colors.green,
              borderSideColor: Colors.grey,
              prefixColor: Colors.pink.shade300,
            ),
            //End User Name----------
            //Start User E-mail ----------
            const SizedBox(height: 10),
            const CustomText(
              text: "E-mail",
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              textEditingController: controller.emailController!,
              obscure: false,
              validator: (value) {
                if (value == null) {
                  return "Write your e-mail address";
                }
              },
              icon: Icons.email_outlined,
              myhinttext: "example@gmail.com",
              fillColor: Colors.grey.shade200,
              enabledColor: Colors.grey,
              focusedColor: Colors.green,
              borderSideColor: Colors.grey,
              prefixColor: Colors.pink.shade300,
            ),
            const SizedBox(height: 10),
            //End User E-mail ----------
            //Start User Password----------
            const CustomText(
              text: "Password",
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              textEditingController: controller.passwordController!,
              obscure: true,
              validator: (value) {
                if (value == null) {
                  return "Write your password";
                }
              },
              icon: Icons.lock_outlined,
              myhinttext: "***********",
              fillColor: Colors.grey.shade200,
              enabledColor: Colors.grey,
              focusedColor: Colors.green,
              borderSideColor: Colors.grey,
              prefixColor: Colors.pink.shade300,
            ), const SizedBox(height: 10,),
            //Start User Password Confirm----------
            const CustomText(
              text: "Confirm password",
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              textEditingController: controller.confirmPasswordController!,
              obscure: true,
              validator: (value) {
                if (value != controller.confirmPasswordController!) {
                  return "Password not confirmed";
                }
              },
              icon: Icons.lock_outlined,
              myhinttext: "***********",
              fillColor: Colors.grey.shade200,
              enabledColor: Colors.grey,
              focusedColor: Colors.green,
              borderSideColor: Colors.grey,
              prefixColor: Colors.pink.shade300,
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
    return Material(
      elevation: 10,
      color: Colors.pink.shade300,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        onPressed: () => controller.signUpWithEmailAndPassword(
            controller.usernameController!.text,
            controller.emailController!.text,
            controller.passwordController!.text,
            controller.signUpKey!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: "Sign Up",
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
