
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kPrimaryColor = Color(0xffd6a659);
const kSecondaryColor = Color(0xFF59706F);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color.fromARGB(255, 0, 0, 0);
const kDarkColor = Color(0xff202020);
const kTextFieldColor = Color(0xFF979797);
const Color kBackgroundColor = Color.fromRGBO(239, 235, 233, 1);

TextStyle textButton = const TextStyle(
  color: kPrimaryColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

class Themes {
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness :  Brightness.dark,
    )),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    fontFamily: 'Poppins',
    primaryColor: Colors.black,
    cardColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    iconTheme: const IconThemeData(color: kDarkColor),
    popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white)
  );
  //Dark Theme
  static final darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: kDarkColor,
      systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kDarkColor,
      statusBarIconBrightness :  Brightness.light,
    )
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: kDarkColor),
      scaffoldBackgroundColor: kDarkColor,
      colorScheme: const ColorScheme.dark(),
      fontFamily: 'Poppins',
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.brown),
      cardColor: kDarkColor,
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kDarkColor)
      );
}

enum MenuItems { save, edit, delete }

enum SavedItems { unsave, viewPost ,delete,edit }
