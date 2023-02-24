import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';
import 'package:sudaphone_sd/view_model/home_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class BestGamingPhones extends GetWidget<HomeViewModel> {
  const BestGamingPhones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: controller.listBGPhones!.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 15.0,
                          offset: Offset(12, 12)),
                      // BoxShadow(
                      //     color:Colors.transparent,
                      //     blurRadius: 15.0,
                      //     offset: Offset(-12, -12)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => LastProducDetails(
                            collection: "forGames",
                            phoneDoc: controller.listBGPhones![index].docId));
                      },
                      child: GetBuilder<ThemesViewModel>(
                        builder: (control) => Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeInImage.assetNetwork(
                              image: controller.listBGPhones![index].image,
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/shimmer3.jpg',
                              placeholderErrorBuilder:
                                  ((context, error, stackTrace) => Image.asset(
                                        "assets/images/shimmer3.jpg",
                                      )),
                              imageErrorBuilder:
                                  ((context, error, stackTrace) => Image.asset(
                                        "assets/images/shimmer3.jpg",
                                      )),
                            ),
                            Positioned(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomText2(
                                    text: controller.listBGPhones![index].name,
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
