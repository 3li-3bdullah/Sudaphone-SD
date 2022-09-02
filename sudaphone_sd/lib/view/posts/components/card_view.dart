// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:test_login/controller/posts_view_model.dart';
// import 'package:test_login/view/download_images.dart';
// import 'package:test_login/view/widgets/custom_text.dart';


// class CardView extends GetWidget<PostsViewModel> {
//   const CardView({Key? key, required this.data}) : super(key: key);
//   final data;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.brown[100],
//       child: Column(
//         children: [
//           StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//               stream: controller.userInfoCollection
//                   .doc(data.data()['ownerUid'])
//                   .snapshots(),
//               builder: (context, _snapshot) {
//                     [controller.auth!.currentUser!.uid];
//                 if (_snapshot.hasData) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       // Doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
//                       backgroundImage:
//                           NetworkImage(_snapshot.data?.data()!['profileUrl']),
//                     ),
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 10),
//                           child: CustomText(
//                             // Doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
//                             text: _snapshot.data?.data()!['userName'],
//                             color: Colors.black,
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                         CustomText(
//                           text: data.data()['dateTime'],
//                           fontSize: 13,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.grey,
//                           textAlign: TextAlign.right,
//                         )
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.more_horiz),
//                       onPressed: () {
//                         Get.bottomSheet(
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.5),
//                                 borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20))),
//                           ),
//                         );
//                       },
//                     ),
//                     isThreeLine: true,
//                     subtitle: Column(
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         CustomText(
//                           text: data.data()['text'],
//                           color: Colors.black,
//                           fontSize: 17,
//                           fontWeight: FontWeight.normal,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         data.data()['isThereImageUrl'] == true
//                             ? InkWell(
//                                 child: Image.network(
//                                   "${data.data()['imageUrl']}",
//                                   fit: BoxFit.cover,
//                                 ),
//                                 onTap: () {
//                                   Get.to(
//                                       () => DownloadImages(
//                                           image: data.data()['imageUrl']),
//                                       transition: Transition.zoom,
//                                       curve: Curves.easeInExpo);
//                                 },
//                               )
//                             : const SizedBox(
//                                 height: 0.0,
//                                 width: 0.0,
//                               ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return SizedBox(
//                     child: Lottie.asset("assets/lotties/loading.json"),
//                   );
//                 }
//               }),
//           Divider(color: Colors.grey.withOpacity(0.2)),
//           //============================================================
//           Row(
//             children: [
//               Expanded(
//                   child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // IconButton(
//                   //   onPressed: () {
//                   //     controller.handlePostLikes(firstDocsSnapshot: data);
//                   //   }, //'usersLiked.${controller.auth!.currentUser!.uid}'
//                   //   icon: data.data()['usersLiked'][
//                   //               controller.auth!.currentUser!.uid.toString()] ==
//                   //           true
//                   //       ? const Icon(Icons.favorite, color: Colors.pink)
//                   //       : const Icon(Icons.favorite_border_outlined,
//                   //           color: Colors.pink),
//                   // ),
//                   // const SizedBox(width: 10),
              
                    
//                   const SizedBox(width: 10),
//                   InkWell(
//                     child: Text(
//                       data.data()['likesCount'].toString(),
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.normal,
//                           color: data.data()['usersLiked'][controller
//                                       .auth!.currentUser!.uid
//                                       .toString()] ==
//                                   true
//                               ? Colors.pink
//                               : Colors.grey.shade600),
//                     ),
//                     onTap: () {
//                       Get.to(
//                           () => PeopleHaveLIked(
//                                 peopleWhoLiked:
//                                     data.data()['usersLiked'].keys.toList(),
//                                 currentDoc: data.data()['usersLiked'],
//                               ),
//                           transition: Transition.zoom);
//                     },
//                   )
//                 ],
//               )),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Get.to(() => Comments(
//                               firstDocSnapshot: data,
//                             ));
//                       },
//                       icon: const Icon(
//                         Icons.comment_outlined,
//                         color: Colors.green,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                         stream: FirebaseFirestore.instance
//                             .collection("posts")
//                             .doc(data.id)
//                             .collection("comments")
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           return CustomText(
//                             text: "${snapshot.data?.docs.length}",
//                             color: Colors.grey.shade800,
//                             fontSize: 15,
//                             fontWeight: FontWeight.normal,
//                             textAlign: TextAlign.center,
//                           );
//                         }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 5),
//           ),
//         ],
//       ),
//     );
//   }
// }
