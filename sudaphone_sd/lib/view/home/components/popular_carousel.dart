import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/view/home/components/dot_shape.dart';

class PopularCarousel extends StatelessWidget {
  const PopularCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("carousel")
            .doc("popular")
            .collection("carousel")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index, __) {
                return Card(
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0, left:6,right:6),
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height / 4,
                      child: Column(children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loader.gif',
                              image:
                                  snapshot.data?.docs[index].data()['imageUrl'],
                              fit: BoxFit.cover,width: Get.width * 0.9,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              DotShape(left: 0.0, right: 7.0),
                              CustomText(
                                text:
                                    "${snapshot.data!.docs[index].data()['name']}",
                                fontWeight: FontWeight.normal,
                                textAlign: TextAlign.end,
                                fontSize: 16,
                              ),
                              DotShape(left: 7.0, right: 0.0)
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                initialPage: 0,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 150),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset("assets/images/loader.gif"),
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "Oops!",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: snapshot.error.toString(),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
