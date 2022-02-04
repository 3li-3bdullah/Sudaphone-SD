import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/model/posts_model.dart';
import 'package:sudaphone_sd/view/comments.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// ignore: must_be_immutable
class CardView extends StatelessWidget {
  CardView({Key? key , required this.controller, required this.postsModel}) : super(key: key);
  PostsModel? postsModel;
  PostsViewModel? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(children: [
      ListTile(
          leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/slider/ali.jpg")),
          title: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const CustomText(
                  text: "Ali Abdullah",
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.right,
                ),
              ),
              CustomText(
                text: "${postsModel!.postDate.toString()}",
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                textAlign: TextAlign.right,
              )
            ],
          ),
          trailing:
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
          isThreeLine: true,
          subtitle: Column(children: [
            CustomText(
              text: "${postsModel!.text}",
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            ),
            Image.network("${postsModel!.imageUrl.toString()}"),
          ])),
      Divider(color: Colors.grey.withOpacity(0.2)),
      Row(children: [
        //After test make this widget custom..............
        Expanded(
          child: InkWell(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.grey))),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomText(
                  text: controller!.like == false ? "0" : "1",
                  color: Colors.grey.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                controller!.like == false
                    ? Icon(Icons.favorite_border_outlined,
                        color: Colors.pink.shade600)
                    : Icon(Icons.favorite, color: Colors.pink.shade600)
              ]),
            ),
            onTap: () {
              controller!.isLiked();
            },
          ),
        ),
        Expanded(
          child: InkWell(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomText(
                text: "0",
                color: Colors.grey.shade800,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.insert_comment_outlined, color: Colors.green),
            ]),
            onTap: () {
              Get.to(() => const Comments(), transition: Transition.fadeIn);
            },
          ),
        ),
      ]),
      const Padding(padding: EdgeInsets.only(top: 5)),
    ])));
  }
}
