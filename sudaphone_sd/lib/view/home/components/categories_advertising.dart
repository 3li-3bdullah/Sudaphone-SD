import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories/categories.dart';
import 'package:sudaphone_sd/view/categories/phones/huawei.dart';
import 'package:sudaphone_sd/view/categories/phones/iphone.dart';
import 'package:sudaphone_sd/view/categories/phones/lenovo.dart';
import 'package:sudaphone_sd/view/categories/phones/nokia.dart';
import 'package:sudaphone_sd/view/categories/phones/oppo.dart';
import 'package:sudaphone_sd/view/categories/phones/realme.dart';
import 'package:sudaphone_sd/view/categories/phones/samsung.dart';
import 'package:sudaphone_sd/view/categories/phones/tecno.dart';
import 'package:sudaphone_sd/view/categories/phones/vivo.dart';
import 'package:sudaphone_sd/view/categories/phones/xiaomi.dart';
import 'package:sudaphone_sd/view/home/components/custom_listtile.dart';
import 'package:sudaphone_sd/view_model/screen_view_model.dart';

class CategoriesAdvertising extends GetWidget<ScreenViewModel> {
  const CategoriesAdvertising({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2.53,
      width: Get.width,
      child: Obx(
        () => controller.isCateHasData.value
            ? Center(
                child: Image.asset("assets/images/loader.gif"),
              )
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.listCategories!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                    child: CustomListTile(
                      logo: controller.listCategories![index].logo,
                      videoUrl: controller.listCategories![index].videoUrl,
                      thumbinalUrl:
                          controller.listCategories![index].thumbinalUrl,
                      onTap: () {
                        controller.onSelectedCategory(categoryName: controller.listCategories![index].name);
                      },
                      text: controller.listCategories![index].name,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
