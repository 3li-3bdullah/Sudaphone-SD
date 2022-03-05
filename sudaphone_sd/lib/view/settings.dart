import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  //  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            ListTile(
              title: const Text("The Mode"),
              trailing: const Icon(Icons.wb_sunny),
              onTap: () {
                Get.bottomSheet(Column(
                  children: [
                    ListTile(
                      title: const Text("Light Mode"),
                      leading: const Icon(Icons.wb_sunny_outlined),
                      onTap: () {
                        Get.changeTheme(ThemeData.light());
                      },
                    ),
                    ListTile(
                      title: const Text("Dark Mode"),
                      leading: const Icon(Icons.wb_sunny),
                      onTap: () {
                        Get.changeTheme(ThemeData.dark());
                      },
                    ),
                  ],
                ));
              },
            ),
            // ElevatedButton(onPressed: () => getImage() , child: const Text("Check an image")),
            // const SizedBox(height: 20,),
            // ElevatedButton(onPressed: () => uploadImage() , child: const Text("Upload Image")),
            // Container(
            //   height: 300,
            //   width: 300,
            //   child: filePicked == null? const SizedBox() : Image.asset(pickedImage!.path),
            // )
          ],
        ),
        
      ),
    );
  }
//   String? imageName;
//   File? filePicked;
//    XFile? pickedImage;
//   String dateTime =
//       DateFormat('M/d/y - kk:mm').format(DateTime.now());
//       //===================
//  Future getImage() async {
//     ImagePicker _picker = ImagePicker();
//      pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     if(pickedImage == null){
//       return null;
//     }
//      imageName = basename(pickedImage!.path); 
//      filePicked = File(pickedImage!.path);
//   }
//   Future uploadImage() async {
//   var reference = FirebaseStorage.instance.ref("images").child(imageName!);
//     reference.putFile(filePicked!);
//     String imageUrl = await reference.getDownloadURL();
//     FirebaseFirestore.instance.collection("users").add({
//       "imageUrl" : imageUrl,
//       "dateTime" : dateTime.toString()
//     });
//     Get.off(() => const Posts() , transition: Transition.zoom);
//   }
}
