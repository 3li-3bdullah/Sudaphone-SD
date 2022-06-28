import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.height, required this.width, required this.lotHeight}) : super(key: key);
  final double height;
  final double width;
  final double lotHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment:Alignment.center,
      child: Lottie.asset("assets/lotties/loading.json",height: lotHeight),
    );
  }
}