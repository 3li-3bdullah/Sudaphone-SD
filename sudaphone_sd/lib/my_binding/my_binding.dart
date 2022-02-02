import 'package:get/get.dart';
import 'package:sudaphone_sd/view_model/post_view_model.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScreenViewModel());
    Get.put(PostViewModel());
  }
}
