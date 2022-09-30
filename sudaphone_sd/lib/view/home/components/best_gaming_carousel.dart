import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';

class BestGamingCarousel extends StatelessWidget {
  const BestGamingCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("forGames").get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index, __) {
                return InkWell(
                  onTap: () {
                    Get.to(() => LastProducDetails(
                        collection: "forGames",
                        phoneDoc: snapshot.data!.docs[index].id));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      //ToDo : Here i should added FadeImage......
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data?.docs[index].data()['imageUrl']),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.brown.withOpacity(0.6)),
                            child: CustomText2(
                              text:
                                  "${snapshot.data!.docs[index].data()['name']} \n ${snapshot.data!.docs[index].data()['ram']} \n ${snapshot.data!.docs[index].data()['battery']}",
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
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
