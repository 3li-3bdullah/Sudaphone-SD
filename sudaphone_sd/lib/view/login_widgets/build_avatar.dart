import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/widgets/snack_to_upload_images.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

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
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blue,
                  backgroundImage: FileImage(controller.imageFile!),
                ),
              ),
            )
          : SizedBox(
              height: 100,
              width: 100,
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
                      color: Colors.blue,
                      elevation: 0,
                      onPressed: () {
                        controller.uploadProfilePic(source: "gallery");
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
                      color: Colors.blue,
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 80, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 30,
                        color: Colors.grey,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
