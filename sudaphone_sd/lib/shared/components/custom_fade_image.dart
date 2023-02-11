import 'package:flutter/material.dart';

class CustomFadeImage extends StatelessWidget {
  const CustomFadeImage(
      {Key? key,
      required this.imageUrl,
      this.placeHolderImage = "assets/images/shimmer.jpg"})
      : super(key: key);
  final String imageUrl;
  final String placeHolderImage;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loader.gif',
      placeholderErrorBuilder: ((context, error, stackTrace) => Image.asset(
            placeHolderImage,
          )),
      imageErrorBuilder: ((context, error, stackTrace) => Image.asset(
            placeHolderImage,
          )),
      image: imageUrl,
    );
  }
}
