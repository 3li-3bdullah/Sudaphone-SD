import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/login_widgets/build_avatar.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signin.dart';
import 'package:sudaphone_sd/view/login_widgets/custom_signup.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class LogIn extends GetWidget<LoginViewModel> {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink.shade300, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.topLeft),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white38,
          ),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 1150,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Center(
                      //     child: Container(
                      //         margin: const EdgeInsets.only(top: 30),
                      //         child: Text(
                      //             controller.showsignin.value
                      //                 ? "تسجيل الدخول"
                      //                 : "إنشاء حساب",
                      //             style: const TextStyle(
                      //                 color: Colors.white, fontSize: 20,),),),),
                      // const Padding(padding: EdgeInsets.only(top: 20),),
                      controller.showsignin.value
                          ? const BuildAvatar()
                          : const SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      controller.showsignin.value
                          ? const CustomSignUp()
                          : const CustomSignIn(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
