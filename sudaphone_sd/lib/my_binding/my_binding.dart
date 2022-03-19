import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/download_images_view_model.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';
import 'package:sudaphone_sd/view_model/main_view_model.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScreenViewModel());
    Get.put(MyDrawerViewModel());
    Get.put(LoginViewModel());
    Get.lazyPut(() => PostsViewModel(), fenix: true);
    Get.put<MainViewModel>(MainViewModel());
    Get.lazyPut(() => DownloadImagesViewModel(), fenix: true);
  }
}
