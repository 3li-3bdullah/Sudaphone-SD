import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';

class OpenSavedPost extends GetWidget<PostsViewModel> {
  const OpenSavedPost({Key? key, required this.savedDoc, required this.ownerPostedName}) : super(key: key);
  final String savedDoc;
  final String ownerPostedName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "$ownerPostedName's post"),
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(future: controller.savedCollection.doc(controller.uid).collection("saved").get(),
      builder: (context,snapshot){
        if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
          return Column(children: [
           Row(children: [
            CircleAvatar(radius: 40,)
           ],)
          ],);
        }else if(snapshot.hasError){
          return CustomText(text: "Oppos! \n ${snapshot.error.toString()} ");
        } else if(!snapshot.hasData && snapshot.data!.docs.isEmpty){
          return Center(child: Lottie.asset("assets/lotties/no_data.json"),);
        }
        else{
          return Center(child: Lottie.asset("assets/lotties/loading.json"),);
        }
      },
      )
    );
  }
}