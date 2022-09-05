import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselMostUsed extends GetWidget<ScreenViewModel> {
   const CarouselMostUsed({required this.data, Key? key}) : super(key: key);
 final data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10, right: 5),
      width: MediaQuery.of(context).size.height / 3,
      child: CarouselSlider(
       items: [
          Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(data?.data()['imageUrl']), fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                       const Align(
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
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${data?.data()['name']}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
       ],
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
