import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class BestGamingPhones extends GetWidget<ScreenViewModel> {
  const BestGamingPhones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          height: controller.size.height,
          width: controller.size.width,
          alignment: Alignment.center,
          child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    itemCount: controller.listBGPhones!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => LastProducDetails(
                            collection: "forGames",
                              phoneDoc: controller
                                  .listBGPhones![index].docId));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(controller
                                .listBGPhones![index].image,fit: BoxFit.cover,height: 200,),
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: CustomText2(
                                    text: controller
                                        .listBGPhones![index]
                                        .name,
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) =>
                        const StaggeredTile.fit(1),
                  ),
        ),
      ),
    );
  }
}