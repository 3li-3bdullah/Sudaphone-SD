import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreenViewModel extends GetxController {
  //* ---------------------- Declaring Variables --------------

  late StreamSubscription<InternetConnectionStatus> listener;
  RxInt internetConnectionChecker = 0.obs;

  //* ---------------------- Declaring Methods --------------

  @override
  void onInit() {
    super.onInit();
    listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          internetConnectionChecker.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          internetConnectionChecker.value = 0;
          break;
      }
    });
  }

    @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }
  
}
