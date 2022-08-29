import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesViewModel extends GetxController {
  var phonesCategory = FirebaseFirestore.instance.collection("phonesCategory");


}
