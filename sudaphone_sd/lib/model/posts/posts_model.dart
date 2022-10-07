import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  PostsModel({
    required this.imageUrl,
    required this.dateTime,
    required this.isHasLiked,
    required this.isThereImageUrl,
    required this.likesCount,
    required this.ownerUid,
    required this.profileUrl,
    required this.text,
    required this.userName,
    required this.usersHaveSaved,
    required this.usersLiked,
    required this.currentDocUid
  });
  final String imageUrl;
  final Timestamp dateTime;
  final bool isHasLiked;
  final bool isThereImageUrl;
  final int likesCount;
  final String ownerUid;
  final String profileUrl;
  final String text;
  final String userName;
  final Map<dynamic,dynamic> usersHaveSaved;
  final Map<dynamic,dynamic> usersLiked;
  final String currentDocUid;

  PostsModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json)
      : imageUrl = json.data()['imageUrl'],
        dateTime = json.data()['dateTime'],
        isHasLiked = json.data()['isHasLiked'],
        isThereImageUrl = json.data()['isThereImageUrl'],
        likesCount = json.data()['likesCount'],
        ownerUid = json.data()['ownerUid'],
        profileUrl = json.data()['profileUrl'],
        text = json.data()['text'],
        userName = json.data()['userName'],
        usersHaveSaved = json.data()['usersHaveSaved'],
        usersLiked = json.data()['usersLiked'],
        currentDocUid = json.id;
}
