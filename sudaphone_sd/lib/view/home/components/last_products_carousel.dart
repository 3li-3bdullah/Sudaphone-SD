import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class LastProductsCarousel extends GetWidget<ScreenViewModel> {
  const LastProductsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2 + Get.height / 7,
      width: Get.width,
      child: Obx(
        () => controller.loading.value
            ? Center(
                child: Image.asset("assets/images/loader.gif"),
              )
            : StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: controller.listOfLastProducts!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => LastProducDetails(
                          collection: "lastProducts",
                          phoneDoc:
                              controller.listOfLastProducts![index].docId));
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loader.gif',
                                image:
                                    controller.listOfLastProducts![index].imageUrl,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.brown.withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: CustomText2(
                                      text: controller
                                          .listOfLastProducts![index].name,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              ),
      ),
    );
  }
}
