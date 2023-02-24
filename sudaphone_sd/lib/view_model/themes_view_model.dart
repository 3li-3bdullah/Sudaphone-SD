import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesViewModel extends GetxController {
  final GetStorage _box = GetStorage();
  final String _key = "isDarkMode";
  String? email;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  ThemeMode get theme => loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool loadTheme() => _box.read(_key) ?? false;
  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
  void changeTheme(ThemeData theme) => Get.changeTheme(theme);
  void changeThemeMode(ThemeMode theme) {
     Get.changeThemeMode(theme);
    update();
  }
  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     email = prefs.getString('email');
    update();
  }
}
