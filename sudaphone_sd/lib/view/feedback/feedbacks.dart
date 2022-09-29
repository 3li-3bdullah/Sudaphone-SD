import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_title.dart';
import 'package:sudaphone_sd/shared/components/leading.dart';
import 'package:sudaphone_sd/shared/components/primary_button.dart';
import 'package:sudaphone_sd/shared/constants.dart';
import 'package:sudaphone_sd/view_model/feedback_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';

class Feedbacks extends GetWidget<FeedbackViewModel> {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(text: "Feedback", underLineWidget: 50),
        leading: const Leading(),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width / 4.7),
                child: Image.asset(
                  "assets/images/send_feedback.png",
                  fit: BoxFit.contain,
                  height:size.height / 3,
                  width: size.width,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.brown,
                    child: Text(
                      "S-SD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Sudaphone SD",
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: controller.textKey,
                  child: TextFormField(
                    controller: controller.textEditingController,
                    validator: (note) {
                      if (note!.trim().isEmpty) {
                        return "The field is empty";
                      }
                    },
                    minLines: 3,
                    maxLines: 5,
                    cursorColor: Colors.brown,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: kTextFieldColor,
                      hintStyle: TextStyle(color: kTextFieldColor),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: kPrimaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.all(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
                  GetBuilder<PublicData>(
                      builder: (control) => PrimaryButton(
                        buttonText: "Send Feedback",
                        ontap: () {
                          controller.sendFeedback(
                            uid: control.uid,
                            name: control.getUserName,
                            profileUrl: control.getProfileUrl,
                            key: controller.textKey,
                            text: controller.textEditingController.text
                                .toString(),
                          );
                        },
                        color: Colors.brown,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
