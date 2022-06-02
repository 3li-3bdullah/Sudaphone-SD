import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/view/details.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class DrawerChild extends GetWidget<ScreenViewModel> {
  const DrawerChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
            text: "Favorite",
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.drawerData
              .doc(controller.uid)
              .collection("favorite")
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:  2),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (_, i) {
                        return InkWell(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: GridTile(
                              child: Image.network(
                                  snapshot.data?.docs[i].data()['imageUrl']),
                              footer: Container(
                                height: 20,
                                color: Colors.black.withOpacity(0.3),
                                child: CustomText(
                                  text: snapshot.data?.docs[i].data()['name'],
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(
                                () => Details(
                                    docTwo: snapshot.data!.docs[i].id,
                                    docOne: controller.uid.toString(),
                                    collction: "favorite"),
                                transition: Transition.zoom);
                          },
                        );
                      },
                    );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset("assets/lottie/please_wait.json"));
            } else if (!snapshot.hasData) {
              return Center(child: Lottie.asset("assets/images/no_data.json"));
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Oops",
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  CustomText(
                    text: "${snapshot.hasError}",
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
/*
   return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15,
                      itemBuilder: (context, i) {
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3,
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    snapshot.data?.docs[index]['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  color: Colors.grey[100],
                                  child: CustomText(
                                    text: "${snapshot.data?.docs[index]['name']}",
                                    textAlign: TextAlign.center,
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: (){
                            Get.to(() => Details(snapshot: snapshot, docOne: controller.uid.toString(), collction: "favorite"));
                          },
                        );
                      },
                      staggeredTileBuilder: (indexo) =>
                          const StaggeredTile.fit(1),
                    ); 
*/