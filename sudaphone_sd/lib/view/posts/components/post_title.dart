import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({Key? key, required this.currentDoc}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> currentDoc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: CustomText(
            text: "${currentDoc.data()['userName']}",
            fontSize: 17,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.right,
          ),
        ),
        CustomText2(
          text: currentDoc.data()['dateTime'],
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
