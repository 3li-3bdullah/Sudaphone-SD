import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/posts_pages/comments.dart';
import 'package:sudaphone_sd/view/download_images.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class CardView extends GetWidget<PostsViewModel> {
  CardView({Key? key, required this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/slider/ali1.jpg")),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const CustomText(
                      text: "Ali Abdullah",
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  // CustomText(
                  //   text: "${data.data()['dateTime'].toDate().toString()}",
                  //   fontSize: 13,
                  //   fontWeight: FontWeight.normal,
                  //   color: Colors.grey,
                  //   textAlign: TextAlign.right,
                  // )
                ],
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.more_horiz), onPressed: () {}),
              isThreeLine: true,
              subtitle: Column(
                children: [
                  CustomText(
                    text: "${data.data()['text']}",
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    child: Image.network("${data.data()['imageUrl']}"),
                    onTap: () {
                      Get.to(
                          () => DownloadImages(image: data.data()['imageUrl']),
                          transition: Transition.zoom,
                          curve: Curves.easeInExpo);
                    },
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.2)),
            Row(
              children: [
                Expanded(
                  child: GetBuilder<PostsViewModel>(
                    builder: (controller) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.isLiked();
                          },
                          child: controller.like == true
                              ? const Icon(Icons.favorite, color: Colors.pink)
                              : const Icon(Icons.favorite_border_outlined,
                                  color: Colors.grey),
                        ),
                        controller.like == true
                            ? const Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.pink),
                              )
                            : Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const Comments());
                        },
                        child: const Icon(
                          Icons.comment_outlined,
                          color: Colors.green,
                        ),
                      ),
                      CustomText(
                        text: "0",
                        color: Colors.grey.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
          ],
        ),
      ),
    );
  }
}
