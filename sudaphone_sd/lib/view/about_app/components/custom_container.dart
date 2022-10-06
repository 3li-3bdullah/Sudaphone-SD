import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/custom_divider.dart';
import 'package:sudaphone_sd/view/details/components/custom_text_details.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.image1,
      required this.image2,
      required this.header,
      required this.ontap1,
      required this.ontap2})
      : super(key: key);
  final String text1;
  final String text2;
  final String image1;
  final String image2;
  final String header;
  final Function ontap1;
  final Function ontap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.brown[300],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: CustomText2(
              text: header,
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  ontap1();
                },
                child: Row(children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                      backgroundImage: AssetImage(image1)),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText2(
                    text: text1,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  )
                ]),
              ),
            ],
          ),
          CustomDivider(color: Colors.grey, horizontal: 20, vertical: 8),
          InkWell(
            onTap: () {
              ontap2();
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                    backgroundImage: AssetImage(image2)),
                SizedBox(
                  width: 20,
                ),
                CustomText2(
                  text: text2,
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
