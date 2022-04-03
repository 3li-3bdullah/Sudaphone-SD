import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/build_avatar.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signin.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signup.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class LogIn extends GetWidget<LoginViewModel> {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                // controller.showsignin.value
                //     ?
                Row(
                  mainAxisAlignment : MainAxisAlignment.spaceAround,
                  children: const [
                   CustomText(
                    text: "Sudaphone SD",
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center),
                 BuildAvatar(),
                ]),
                const SizedBox(
                  height: 30,
                ),
                controller.showsignin.value
                    ? const CustomSignUp()
                    : const CustomSignIn(),
                const SizedBox(
                  height: 30,
                ),
                controller.showsignin.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SignUpButton(),
                          InkWell(
                            onTap: () {
                              controller.signinOrSignup();
                            },
                            child: const CustomText(
                                text: "Sign in",
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SignInButton(),
                              InkWell(
                                onTap: () {
                                  controller.signinOrSignup();
                                },
                                child: const CustomText(
                                    text: "Sign up",
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Divider(height: 2 , color: Colors.grey,),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: "Or",
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(height: 2 , color: Colors.grey),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () {},
                            child: const CustomText(
                                text: "Sign in with Google",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
