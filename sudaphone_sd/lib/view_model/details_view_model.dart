import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailsViewModel extends GetxController {
  /// variables
  Size size = MediaQuery.of(Get.context!).size;
  Rx<PanelController> panelController = PanelController().obs;
  FirebaseAuth auth  = FirebaseAuth.instance;
  String? uid;

  /// Methods

   @override
  void onInit() {
      uid = auth.currentUser!.uid;
    super.onInit();
  }
  // To open & close panel
  void togglePanel() {
    panelController.value.isPanelOpen
        ? panelController.value.close()
        : panelController.value.open();
  }

  /*
     * This option will show up if the owner user has liked the post before
     * or not, and even if the user delete the app and reinstall again , so
     * he'll see he has liked before or not.
     */
  handlePhoneLikes({String? docOne, String? collection, snapshot}) async {
    DocumentReference<Map<String, dynamic>> _likeData = FirebaseFirestore
        .instance
        .collection("phonesCategory")
        .doc(docOne)
        .collection(collection!)
        .doc(snapshot.id);

    bool _isHasLiked = await _likeData
        .get()
        .then((value) => value.data()!['usersLiked']['$uid'] == true);

    if (!_isHasLiked) {
      int _addLike = snapshot['likesCount'] + 1;
      await _likeData.update({
        'likesCount': _addLike.toInt(),
        'usersLiked.$uid': true,
      });
    } else {
      int _removeLike = snapshot['likesCount'] - 1;
      await _likeData.update(
          {'likesCount': _removeLike.toInt(), 'usersLiked.$uid': false});
    }
  }
}
