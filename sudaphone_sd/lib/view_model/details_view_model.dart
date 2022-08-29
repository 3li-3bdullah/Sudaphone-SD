import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailsViewModel extends GetxController {
// (((((((((((((((((((((((( Variables ))))))))))))))))))))))))
  Size size = MediaQuery.of(Get.context!).size;
  Rx<PanelController> panelController = PanelController().obs;
   CollectionReference<Map<String, dynamic>> favorite =  FirebaseFirestore
        .instance
        .collection("favorite");
  String? uid;

// ((((((((((((((((((((((((( Methods )))))))))))))))))))))))))

  @override
  void onInit() {
    uid = FirebaseAuth.instance.currentUser!.uid;
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
    DocumentReference<Map<String, dynamic>> likeData = FirebaseFirestore
        .instance
        .collection("phonesCategory")
        .doc(docOne)
        .collection(collection!)
        .doc(snapshot.id);
    

    bool isHasLiked = await likeData
        .get()
        .then((value) => value.data()!['usersLiked']['$uid'] == true);

    if (!isHasLiked) {
      int addLike = snapshot['likesCount'] + 1;
      await likeData.update({
        'likesCount': addLike.toInt(),
        'usersLiked.$uid': true,
      });
     
    } else {
      int removeLike = snapshot['likesCount'] - 1;
      await likeData.update(
          {'likesCount': removeLike.toInt(), 'usersLiked.$uid': false});
      
    }
  }
  //To add items at the archivists
   Future<void> addToFavorite({favoriteSnapshot,String? isThereDoc ,String? docId, isAddToFavorte , String? docOne,String? collction, String? docTwo}) async {
      CollectionReference<Map<String, dynamic>> favorite = FirebaseFirestore
        .instance
        .collection("favorite")
        .doc(uid)
        .collection("favorite");
        if(isThereDoc == null){
          favorite.doc(docId).set({
        'name': favoriteSnapshot['name'].toString(),
        'imageUrl': favoriteSnapshot['imageUrl'].toString(),
        'likesCount': favoriteSnapshot['likesCount'].toString(),
        'ram': favoriteSnapshot['ram'].toString(),
        'storage': favoriteSnapshot['storage'].toString(),
        'battery': favoriteSnapshot['battery'].toString(),
        'frontCamera': favoriteSnapshot['frontCamera'].toString(),
        'rearCamera': favoriteSnapshot['rearCamera'].toString(),
        'screen': favoriteSnapshot['screen'].toString(),
        'os': favoriteSnapshot['os'].toString(),
        'usersLiked': favoriteSnapshot['usersLiked'],
        'price': favoriteSnapshot['price'].toString(),
        'cpu': favoriteSnapshot['cpu'].toString(),
      });
        }else   {
          favorite.doc(docId).delete();
        }
      //   else if(isAddToFavorte[uid] == false){
      //    editData.update({'usersLiked.$uid': true});
      //     favorite.set({
      //   'name': favoriteSnapshot['name'].toString(),
      //   'imageUrl': favoriteSnapshot['imageUrl'].toString(),
      //   'likesCount': favoriteSnapshot['likesCount'].toString(),
      //   'ram': favoriteSnapshot['ram'].toString(),
      //   'storage': favoriteSnapshot['storage'].toString(),
      //   'battery': favoriteSnapshot['battery'].toString(),
      //   'frontCamera': favoriteSnapshot['frontCamera'].toString(),
      //   'rearCamera': favoriteSnapshot['rearCamera'].toString(),
      //   'screen': favoriteSnapshot['screen'].toString(),
      //   'os': favoriteSnapshot['os'].toString(),
      //   'usersLiked': favoriteSnapshot['usersLiked'],
      //   'price': favoriteSnapshot['price'].toString(),
      //   'cpu': favoriteSnapshot['cpu'].toString(),
        
      // });
      //   }
      


      //   isThereSavedData == null ? archivists.set({
      //   'name': archivistsSnapshot['name'].toString(),
      //   'imageUrl': archivistsSnapshot['imageUrl'].toString(),
      //   'likesCount': archivistsSnapshot['likesCount'].toString(),
      //   'ram': archivistsSnapshot['ram'].toString(),
      //   'storage': archivistsSnapshot['storage'].toString(),
      //   'battery': archivistsSnapshot['battery'].toString(),
      //   'frontCamera': archivistsSnapshot['frontCamera'].toString(),
      //   'rearCamera': archivistsSnapshot['rearCamera'].toString(),
      //   'screen': archivistsSnapshot['screen'].toString(),
      //   'os': archivistsSnapshot['os'].toString(),
      //   'usersLiked': archivistsSnapshot['usersLiked'],
      //   'price': archivistsSnapshot['price'].toString(),
      //   'cpu': archivistsSnapshot['cpu'].toString(),
      // }) : await archivists.delete();
    }
}
