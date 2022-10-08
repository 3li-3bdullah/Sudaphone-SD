import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class BuildAvatar extends GetWidget<LoginViewModel> {
  const BuildAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
      builder:(controller) => InkWell(
            child: controller.imageFile != null ? AvatarGlow(
              shape: BoxShape.circle,
              animate: true,
              showTwoGlows: true,
              glowColor: Colors.brown,
              repeat: true,
              endRadius: 80,
              repeatPauseDuration: const Duration(milliseconds: 50),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.brown,
                backgroundImage: FileImage(controller.imageFile!),
              ),
            ) : const AvatarGlow(
              shape: BoxShape.circle,
              animate: true,
              
              showTwoGlows: true,
              glowColor: Colors.brown,
              repeat: true,
              endRadius: 80,
              repeatPauseDuration:  Duration(milliseconds: 50),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.brown,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            onTap: () {
                Get.defaultDialog(
                  content:  CustomText2(
                    text: "Choose an image from : ",
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  title: "Upload",
                  titleStyle: TextStyle(color: Colors.brown),
                  cancel: MaterialButton(
                    color: Colors.brown.shade300,
                    elevation: 0,
                    onPressed: () {
                      controller.uploadProfilePic(source: "gallery");
                      Get.back();
                    },
                    child: Row(
                      children:  [
                        const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                       const SizedBox(
                          width: 5,
                        ),
                        CustomText2(
                          text: "Gallery",
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  confirm: MaterialButton(
                    color: Colors.brown.shade300,
                    elevation: 0,
                    onPressed: () {
                      controller.uploadProfilePic(source: "camera");
                      Get.back();
                    },
                    child: Row(
                      children:  [
                       const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                       const SizedBox(
                          width: 5,
                        ),
                        CustomText2(
                          text: "Camera",
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
            },
          )
    );
  }
}
