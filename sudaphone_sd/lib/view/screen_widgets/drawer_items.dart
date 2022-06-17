// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sudaphone_sd/view/widgets/custom_text.dart';
// import 'package:sudaphone_sd/view_model/screen_view_model.dart';

// class DrawerItems extends GetWidget<ScreenViewModel> {
//   const DrawerItems({required this.doc, required this.collection, Key? key})
//       : super(key: key);
//   final String doc;
//   final String collection;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         future: controller.drawerData
//             .collection("phonesCategory")
//             .doc(doc)
//             .collection(collection)
//             .get(),
//         builder: (context, snapshot) {
//           return ListView.builder(
//             // shrinkWrap: true,
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (context, index) {
//                 if (snapshot.hasData) {
//                   return GridTile(
//                     child: Container(
//                       height: 180,
//                       width: double.infinity,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Image.network(
//                         snapshot.data?.docs[index]['imageUrl'],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     footer: Container(
//                       child: CustomText(
//                         text: "${snapshot.data?.docs[index]['name']}",
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black,
//                         textAlign: TextAlign.center,
//                       ),
//                       padding: const EdgeInsets.all(50),
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(4),
//                         ),
//                         color: Colors.grey,
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(
//                     child: Lottie.asset("assets/lottie/please_wait.json"),
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.pink,
//                     ),
//                   );
//                 }
//               });
//         });
//   }
// }
