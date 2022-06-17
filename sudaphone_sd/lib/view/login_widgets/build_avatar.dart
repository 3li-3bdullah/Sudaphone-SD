import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';

class BuildAvatar extends GetWidget<LoginViewModel> {
  const BuildAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
      builder: ((controller) => controller.imageFile != null
          ? SizedBox(
              height: 100,
              width: 100,
              child: InkWell(
                onTap: () {},
                child: AvatarGlow(shape: BoxShape.circle,animate: true,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.brown,
                    backgroundImage: FileImage(controller.imageFile!),
                  ),
                  duration: const Duration(milliseconds: 2500),
                  showTwoGlows: true,
                  glowColor: Colors.brown,
                  repeat: true,
                  endRadius: 100,
                  repeatPauseDuration: const Duration(milliseconds: 150),
                ),
              ),
            )
          : SizedBox(
              height: 100,
              width: 100,
              child: AvatarGlow(
                duration: const Duration(milliseconds: 2500),
                  showTwoGlows: true,
                  glowColor: Colors.brown,
                  repeat: true,
                  endRadius: 300,
                  // repeatPauseDuration: const Duration(milliseconds: 150),
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      content: const CustomText(
                        text: "Choose an image from : ",
                        textAlign: TextAlign.center,
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      title: "Upload",
                      cancel: MaterialButton(
                        color: Colors.brown,
                        elevation: 0,
                        onPressed: () {
                          controller.uploadProfilePic(source: "gallery");
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "Gallery",
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      confirm: MaterialButton(
                        color: Colors.brown,
                        elevation: 0,
                        onPressed: () {
                          controller.uploadProfilePic(source: "camera");
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "Camera",
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 80, color: Colors.brown),
                  ),
                ),
                 
              ),
            )),
    );
  }
}
