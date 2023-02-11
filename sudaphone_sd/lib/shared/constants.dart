import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kPrimaryColor = Color(0xffd6a659);
const kSecondaryColor = Color(0xFF59706F);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xff333333);
const kDarkColor = Color(0xff202020);
const kTextFieldColor = Color(0xFF979797);
const Color kBackgroundColor = Color.fromRGBO(239, 235, 233, 1);
const kDark1 = Color(0xff212332);
const kDark2 = Color(0xff292939); //0xff2d2f3a

TextStyle textButton = const TextStyle(
  color: kPrimaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

class Themes {
  static final lightTheme = ThemeData(
      // useMaterial3: true,
      // colorSchemeSeed: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          )),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      fontFamily: 'Poppins',
      primaryColor: kDark1,
      cardColor: Colors.white,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: Colors.white),
      iconTheme: const IconThemeData(color: kDark1),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white));
  //Dark Theme
  static final darkTheme = ThemeData(
      // useMaterial3: true,
      // colorSchemeSeed: kDark2,
      appBarTheme: const AppBarTheme(
          backgroundColor: kDark1,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: kDark1,
            statusBarIconBrightness: Brightness.light,
          )),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: kDark1),
      scaffoldBackgroundColor: kDark1,
      colorScheme: const ColorScheme.dark(),
      fontFamily: 'Poppins',
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.brown),
      cardColor: kDark2,
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kDark2));
}

enum MenuItems { save, edit, delete }

enum SavedItems { unsave, viewPost, delete, edit }
