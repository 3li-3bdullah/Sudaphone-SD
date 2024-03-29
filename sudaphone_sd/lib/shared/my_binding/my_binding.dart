import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/about_app_view_model.dart';
import 'package:sudaphone_sd/view_model/categories_view_model.dart';
import 'package:sudaphone_sd/view_model/details_view_model.dart';
import 'package:sudaphone_sd/view_model/download_images_view_model.dart';
import 'package:sudaphone_sd/view_model/feedback_view_model.dart';
import 'package:sudaphone_sd/view_model/login_view_model.dart';
import 'package:sudaphone_sd/view_model/mydrawer_view_model.dart';
import 'package:sudaphone_sd/view_model/posts_view_model.dart';
import 'package:sudaphone_sd/view_model/public_data.dart';
import 'package:sudaphone_sd/view_model/home_view_model.dart';
import 'package:sudaphone_sd/view_model/settings_view_model.dart';
import 'package:sudaphone_sd/view_model/splash_screen_view_model.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => MyDrawerViewModel(), fenix: true);
    Get.lazyPut( () => LoginViewModel(),fenix: true);
    Get.lazyPut(() => PostsViewModel(), fenix: true);
    Get.lazyPut(() => DownloadImagesViewModel(), fenix: true);
    Get.lazyPut(() => SettingsViewModel(), fenix: true);
    Get.lazyPut(() => DetailsViewModel(), fenix: true);
    Get.lazyPut(() => CategoriesViewModel(), fenix: true);
    Get.lazyPut(() => FeedbackViewModel(), fenix: true);
    Get.lazyPut(() => AboutAppViewModel(), fenix: true);
    Get.put(SplashScreenViewModel());
    Get.put(ThemesViewModel());
    Get.lazyPut(() => PublicData() , fenix: true);
  }
}
