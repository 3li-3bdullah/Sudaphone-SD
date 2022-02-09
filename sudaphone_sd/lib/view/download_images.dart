import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class DownloadImages extends StatelessWidget {
   DownloadImages({Key? key,required this.image}) : super(key: key);
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},child:const Icon(Icons.save),),
        body: SafeArea(
      child: Center(
        child: image.isEmpty? Lottie.asset("assets/images/no_data.json") : Image.network(image),
      ),
    ));
  }
}
