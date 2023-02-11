import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_fade_image.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view/home/play_video_page.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class CustomListTile extends GetWidget<ScreenViewModel> {
  const CustomListTile(
      {required this.text,
      required this.videoUrl,
      required this.logo,
      required this.thumbinalUrl,
      required this.onTap,
      Key? key})
      : super(key: key);
  final String text;
  final String thumbinalUrl;
  final String videoUrl;
  final String logo;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemesViewModel>(
      builder: (control) => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: control.theme == ThemeMode.dark
                  ? Colors.black26
                  : Colors.black12,
              blurRadius: 8.0,
              offset: const Offset(8, 8)),
          BoxShadow(
              color: control.theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.transparent,
              blurRadius: 8.0,
              offset: const Offset(-8, -8)),
        ], borderRadius: const BorderRadius.all(Radius.circular(20))),
        // margin: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Card(
            shadowColor:
                control.theme == ThemeMode.dark ? kDark2 : Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => PlayVideoPage(videoUrl: videoUrl));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 2.6,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            child: CustomFadeImage(imageUrl: thumbinalUrl),
                          ),
                        ),
                        const Positioned(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white54,
                            child: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        onTap();
                      },
                      child: Row(
                        children: [
                          CustomText(
                            text: text,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 90,
                            width: 90,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: CustomFadeImage(imageUrl: logo),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
