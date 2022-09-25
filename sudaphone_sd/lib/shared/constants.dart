
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kPrimaryColor = Color(0xffd6a659);
const kSecondaryColor = Color(0xFF59706F);
const kDarkGreyColor = Color(0xFFA8A8A8);
const kWhiteColor = Color(0xFFFFFFFF);
const kZambeziColor = Color(0xFF5B5B5B);
const kBlackColor = Color.fromARGB(255, 0, 0, 0);
const kDarkColor = Color(0xff202020);
const kTextFieldColor = Color(0xFF979797);

Color topLogin = const Color(0xff3b247e);
Color bottomLogin = const Color(0xff09fbd3);

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 30);

TextStyle titleText = const TextStyle(
    color: kPrimaryColor, fontSize: 32, fontWeight: FontWeight.w700);
TextStyle subTitle = const TextStyle(
    color: kSecondaryColor, fontSize: 18, fontWeight: FontWeight.w500);
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
    iconTheme: const IconThemeData(color: kDarkColor),
    popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white)
  );
  static final darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: kDarkColor,
      systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kDarkColor,
      statusBarIconBrightness :  Brightness.light,
    )
      ),
      scaffoldBackgroundColor: kDarkColor,
      colorScheme: const ColorScheme.dark(),
      fontFamily: 'Poppins',
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.brown),
      cardColor: Colors.grey[900],
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kDarkColor)
      );
}

enum MenuItems { save, edit, delete }

enum SavedItems { unsave, viewPost ,delete,edit }
