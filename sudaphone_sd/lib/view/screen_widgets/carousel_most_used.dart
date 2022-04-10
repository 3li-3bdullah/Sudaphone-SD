import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class CarouselMostUsed extends GetWidget<ScreenViewModel> {
  const CarouselMostUsed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10, right: 5),
      width: MediaQuery.of(context).size.height / 3,
      child: CarouselSlider(
        items: controller.images
            .map(
              (items) => Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(items), fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Enjoy Your Eyes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Open Your Eyes And See The World As You Will See As A Last Moment",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
            .toList(),
        options: CarouselOptions( 
          initialPage: 0,
          autoPlay: true,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
