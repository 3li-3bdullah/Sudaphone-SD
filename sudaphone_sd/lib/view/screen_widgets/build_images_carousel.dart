import 'package:flutter/material.dart';

class BuildImagesCarousel extends StatelessWidget {
   const BuildImagesCarousel({ Key? key,required this.imagesCarousel }) : super(key: key);
  final String imagesCarousel;

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                  imagesCarousel,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),);
  }
}