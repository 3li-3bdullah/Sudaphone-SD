import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';

class SaveIcon extends GetWidget<DetailsViewModel> {
  const SaveIcon({required this.snapshot,required this.collction,required this.docOne,required this.docTwo, Key? key}) : super(key: key);
  
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;
  final String collction;
  final String docOne;
  final String docTwo;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.transparent,
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.favorite
            .doc(controller.uid)
            .collection("favorite")
            .doc(snapshot.data!.data()!['name'])
            .snapshots(),
        builder: (context, _snapshot) {
          if (_snapshot.hasData) {
            return _snapshot.data?.data()?['name'] != null
                ? InkWell(
                    child: Image.asset(
                      'assets/images/icons/saved.png',
                      color: Colors.pink,
                    ),
                    onTap: () {
                      controller.addToFavorite(
                          favoriteSnapshot: snapshot.data?.data(),
                          isThereDoc: _snapshot.data?.data()?['name'],
                          docId: snapshot.data!.data()!['name'],
                          isAddToFavorte:
                              snapshot.data?.data()!['isAddToFavorite'],
                          collction: collction,
                          docOne: docOne,
                          docTwo: docTwo);
                    },
                  )
                : InkWell(
                    onTap: () {
                      controller.addToFavorite(
                          favoriteSnapshot: snapshot.data?.data(),
                          isThereDoc: _snapshot.data?.data()?['name'],
                          docId: snapshot.data!.data()!['name'],
                          isAddToFavorte:
                              snapshot.data?.data()!['isAddToFavorite'],
                          collction: collction,
                          docOne: docOne,
                          docTwo: docTwo);
                    },
                    child: Image.asset(
                      'assets/images/icons/saved.png',
                      color: Colors.brown,
                    ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset("assets/images/loader.gif"),
            );
          } else {
            return Center(
              child: Image.asset("assets/images/loader.gif"),
            );
          }
        },
      ),
    );
  }
}
