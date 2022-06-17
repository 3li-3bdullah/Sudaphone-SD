import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/constants.dart';
import 'package:sudaphone_sd/view/widgets/primary_button.dart';
import 'package:sudaphone_sd/view_model/feedback_view_model.dart';

class Feedbacks extends GetWidget<FeedbackViewModel> {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feedback",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                CircleAvatar(
                  child: Text(
                    "S-SD",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.brown,
                ),
                SizedBox(width: 20),
                Text(
                  "Sudaphone SD",
                  style: TextStyle(
                      color: Colors.brown, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.textKey,
              child: TextFormField(
                controller: controller.textEditingController,
                validator: (note) {
                  if (note!.trim().isEmpty) {
                    return "The field is empty";
                  }
                },
                cursorColor: Colors.brown,
                minLines: 5,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            PrimaryButton(
              buttonText: "Send Feedback",
              ontap: () {
                controller.sendFeedback(
                  key: controller.textKey,
                  text: controller.textEditingController.text.toString(),
                );
              },
              color: Colors.brown,
            )
          ],
        ),
      ),
    );
  }
}
