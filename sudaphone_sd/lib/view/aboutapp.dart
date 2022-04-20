import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:sudaphone_sd/view/screen_widgets/drawer_items.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class AboutApp extends GetWidget<ScreenViewModel> {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
        .collection("phonesCategory")
        .doc("allHuawei")
        .collection("huawei")
        .get(),
        builder: (context, snapshot) {
      return ListView.builder(
        // shrinkWrap: true,
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasData) {
              return GridTile(
                child: Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    snapshot.data?.docs[index]['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                footer: Container(
                  child: CustomText(
                    text: "${snapshot.data?.docs[index]['name']}",
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
          });
        }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sudaphone_sd/view/widgets/custom_text.dart';

// class AboutApp extends StatelessWidget {
//   const AboutApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "About",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         centerTitle: true,
//       ),

//       ///drawer: MyDrawer(),
//       body:  ListView(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             margin: const EdgeInsets.all(10),
//             child: RichText(
//               text: const TextSpan(
//                 style: TextStyle(fontSize: 15),
//                 children: <TextSpan>[
//                   TextSpan(
//                       text:
//                           "This app show you mostly kind of phones and his prices , and you can add post & like & comments and more features , desinged to make to your life easier when wanna buy yor phone or sell him .",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w700, color: Colors.black)),
//                   TextSpan(
//                     text:
//                         "If there any problem or feedback please shoot message on this email : ",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: "SudaphoneSD@gmail.com",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700, color: Colors.green),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.all(50)),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: TextButton(
//               onPressed: () {
//                 Get.snackbar("Ali Abdullah",
//                     "A programmer he's the master of his sea...");
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                   gradient:
//                       LinearGradient(colors: [Colors.pink, Colors.purple]),
//                 ),
//                 child: const CustomText(
//                     text: "About App Developer",
//                     textAlign: TextAlign.center,
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
