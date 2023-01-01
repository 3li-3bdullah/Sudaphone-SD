import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/details/components/custom_text_details.dart';
import '../constants.dart';

abstract class CustomDialog {
 static ShowCustomDialog({required String body,String title = 'Oops!'}) {
    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          onTap: () => Get.back(),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Center(
              child: Container(
                height: Get.height * 0.4,
                width: Get.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CustomText2(
                      text: title,
                      fontSize: 16,
                      color: Colors.pink,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     CustomText2(
                      text: body,
                      fontSize: 16,
                      color: kBlackColor,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Image.asset('assets/images/login/welcome.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
