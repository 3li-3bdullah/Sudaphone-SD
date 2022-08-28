import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/screen_pages/play_video_page.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<ThemesViewModel>(
        builder: (control) => Card(
          shadowColor:
              control.theme == ThemeMode.dark ? Colors.white12 : Colors.black54,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => PlayVideoPage(videoUrl: videoUrl));
                },
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(thumbinalUrl),
                            fit: BoxFit.cover),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                  const Positioned(
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white54,
                          child: Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.black,
                          )))
                ]),
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
                      Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(logo), fit: BoxFit.cover),
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
    );
  }
}
