import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/home/data_search.dart';
import 'package:sudaphone_sd/view_model/themes_view_model.dart';

class SearchIcon extends GetWidget<ThemesViewModel> {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: IconButton(
        icon: Image(
          image: const AssetImage("assets/images/search1.png"),
          height: 45,
          width: 45,
          color:
              controller.theme == ThemeMode.dark ? Colors.white : Colors.black,
        ),
        onPressed: () => showSearch(context: context, delegate: DataSearch()),
      ),
    );
  }
}
