import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class DrawerChild extends GetWidget<ScreenViewModel> {
  const DrawerChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: controller.docOne.length,
          itemBuilder: (context, index) {
            return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.drawerData
                  .collection("phonesCategory")
                  .doc(controller.docOne[index])
                  .collection(controller.collectionTwo[index])
                  .get(),
              builder: (context, snapshot) {
               if(snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                  return StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),  
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    itemCount: snapshot.data?.docs.length,
                    crossAxisCount: 3,
                    itemBuilder: (context, index) {
                      if (snapshot.hasData) {
                        return Card(
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: GridTile(
                            child: Container(
                              height: 180,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.network(
                                snapshot.data!.docs[index]['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            footer: Container(
                              child: CustomText(
                                text: "${snapshot.data!.docs[index]['name']}",
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                textAlign: TextAlign.center,
                              ),
                              padding: const EdgeInsets.all(50),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Lottie.asset("assets/lottie/please_wait.json"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        );
                      }
                    },
                    staggeredTileBuilder: (i) => const StaggeredTile.fit(1));
               } else {
                 return Center(child : Lottie.asset("assets/images/no_data.json"));
               }
              },
            );
          },
        ),
      ),
    );
  }
}
