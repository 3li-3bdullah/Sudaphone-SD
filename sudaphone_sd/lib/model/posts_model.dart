// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sudaphone_sd/view_model/posts_view_model.dart';

// class PostsModel {
//   late String text;
//   late String imageUrl;
//   late DateTime postDate;

//   PostsModel(
//       {required this.text, required this.imageUrl, required this.postDate});
      
//   factory PostsModel.fromDocumentSnapshot(
//       {required DocumentSnapshot<Map<String, dynamic>> doc}) {
//     return PostsModel(
//         text: doc.data()!['text'],
//         imageUrl: doc.data()!['imageUrl'],
//         postDate: doc.data()!['dateTime']);
//   }

//   // Map<String, dynamic> toJson(data) =>
//   //     {'text': text, 'imageUrl': imageUrl, 'dateTime': postDate};

//   PostsModel.fromSnapshot(snapshot)
//       : text = snapshot.data()['text'],
//         imageUrl = snapshot.data()['imageUrl'],
//         postDate = snapshot.data()['postDate'].toDate();
// }
