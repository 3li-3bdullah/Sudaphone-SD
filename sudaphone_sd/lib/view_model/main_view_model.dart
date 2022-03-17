import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController{
Future<FirebaseApp> fbApp = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
RxBool isLogin = false.obs;


///Declaring Methods
  @override
  void onInit() {
    super.onInit();
    refreshFirebaseUser();
  }
Future refreshFirebaseUser() async {
  if (auth.currentUser != null) {
    isLogin.value = true;
    final user = auth.currentUser;
    final idTokenResult = await user!.getIdTokenResult(true);
    return idTokenResult;
  }
}

}