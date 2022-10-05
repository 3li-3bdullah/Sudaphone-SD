import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sudaphone_sd/shared/components/phone_list.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
    required this.query,
    required this.collection1,
    required this.doc1,
    required this.collection2,
  }) : super(key: key);
  final String query;
  final String collection1;
  final String doc1;
  final String collection2;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(collection1)
            .doc(doc1)
            .collection(collection2)
            .orderBy('name')
            .startAt([query]).endAt([query + '\uf8ff']).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return PhoneList(
                    isHasData: snapshot,
                    collction: collection2,
                    snapshot: snapshot.data?.docs[index],
                    docOne: doc1,
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset("assets/images/loader.gif"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
              ),
            );
          }
        });
  }
}
