import 'package:cloud_firestore/cloud_firestore.dart';

class LastProducts {
  LastProducts(
      {required this.docId, required this.imageUrl, required this.name});
  final String docId;
  final String imageUrl;
  final String name;

  LastProducts.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json)
      : docId = json.id.toString(),
        imageUrl = json.data()['imageUrl'] as String,
        name = json.data()['name'] as String;
}

class BGPhones {
  final String name;
  final String image;
  final String docId;

  BGPhones(
      {required this.name, required this.image, required this.docId});
  BGPhones.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json)
      : name = json['name'],
        image = json['imageUrl'],
        docId = json.id.toString();
}

class Category{
  final String videoUrl;
  final String thumbinalUrl;
  final String logo;
  final String name;

  Category({required this.videoUrl , required this.thumbinalUrl , required this.logo , required this.name});

  Category.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json)
  :videoUrl = json['video'],
  thumbinalUrl = json['videoImage'],
  name = json['name'],
  logo = json['logo'];

}