import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class PostTitle extends GetWidget<PostsViewModel> {
  const PostTitle({Key? key, required this.dateTime, required this.userName})
      : super(key: key);
  final String userName;
  final dynamic dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: CustomText(
            text: "$userName",
            fontSize: 17,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.right,
          ),
        ),
        CustomText2(
          text: controller.handleDate(dateTime),
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
