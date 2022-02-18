import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselMostUsed extends StatelessWidget {
  const CarouselMostUsed({ Key? key , required this.size }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, bottom: 10, right: 5),
                  height: size.height / 3,
                  child: CarouselSlider(
                      items: [
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/carousel/1.jpg'),
                                    fit: BoxFit.cover)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Enjoy Your Eyes",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                        "Open Your Eyes And See The World As You Will See As A Last Moment",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        )),
                                  ),
                                ]))
                      ],
                      options: CarouselOptions(
                          height: size.height / 3,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 250),
                            ),
                          ),
                        );
  }
}