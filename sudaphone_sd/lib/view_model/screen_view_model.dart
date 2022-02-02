import 'package:get/get.dart';

class ScreenViewModel extends GetxController {
  RxInt? activeIndex = 0.obs;
  RxDouble value = 0.0.obs;

  void valueOne() {
    value(1.0);
  }

  void valueZero() {
    value(0.0);
  }
}
