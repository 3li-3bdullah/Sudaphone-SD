import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';
import 'package:sudaphone_sd/view_model/download_images_view_model.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';
import 'package:sudaphone_sd/view_model/main_view_model.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut( () => ScreenViewModel() , fenix: true);
    Get.lazyPut( () => MyDrawerViewModel() , fenix: true);
    Get.put(LoginViewModel());
    Get.lazyPut(() => PostsViewModel(), fenix: true);
    Get.put(MainViewModel());
    Get.lazyPut(() => DownloadImagesViewModel(), fenix: true);
    Get.lazyPut(() => SettingsViewModel(),fenix: true);
    Get.lazyPut(() => DetailsViewModel(),fenix: true);
  }
}
