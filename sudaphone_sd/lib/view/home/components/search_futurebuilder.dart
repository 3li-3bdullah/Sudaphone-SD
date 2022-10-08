import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/shared/components/custom_text.dart';
import 'package:sudaphone_sd/shared/components/custom_text2.dart';
import 'package:sudaphone_sd/shared/components/phone_list.dart';
import 'package:sudaphone_sd/view/home/components/search_result.dart';

// ignore: must_be_immutable
class SearchFutureBuilder extends StatelessWidget {
  SearchFutureBuilder({required this.query, Key? key}) : super(key: key);
  String query;

  @override
  Widget build(BuildContext context) {
    /* 
    * Huawei Methods
    */
    if (query.toLowerCase().contains("huawei")) {
      query = query.replaceAll("huawei", "Huawei");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allHuawei",
          collection2: "huawei");
    }
    if (query.toLowerCase().contains("honor")) {
      query = query.replaceAll("honor", "Honor");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allHuawei",
          collection2: "huawei");
    }
    /* 
    * To see if the query empty or not 
    */
    else if (query.isEmpty) {
      return const Center(
        child: CustomText2(
            text: "What's the phone are you looking for!",
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center),
      );
    }
    /* 
    * Samsung Methods
    */
    else if (query.toLowerCase().contains("samsung")) {
      query = query.replaceAll("samsung", "Samsung");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allSamsung",
          collection2: "samsung");
    }
    /* 
    * Iphone Methods
    */
    else if (query.toLowerCase().contains("iphone")) {
      query = query.replaceAll("iphone", "Iphone");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allIphone",
          collection2: "iphone");
    }
    /* 
    * Vivo Methods
    */
    else if (query.toLowerCase().contains("vivo")) {
      query = query.replaceAll("vivo", "Vivo");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allVivo",
          collection2: "vivo");
    }
    /* 
    * Realme Methods
    */
    else if (query.toLowerCase().contains("realme")) {
      query = query.replaceAll("realme", "Realme");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allRealme",
          collection2: "realme");
    }
    /* 
    * Xiaomi Methods
    */
    else if (query.toLowerCase().contains("xiaomi") ||
        query.toLowerCase().contains("poco")) {
      if (query.contains("xiaomi")) {
        query = query.replaceAll("xiaomi", "Xiaomi");
      } else {
        query = query.replaceAll("poco", "Poco");
      }
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allXiaomi",
          collection2: "xiaomi");
    }
    /* 
    * Lenovo Methods
    */
    else if (query.toLowerCase().contains("lenovo")) {
      query = query.replaceAll("lenovo", "Lenovo");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allLenovo",
          collection2: "lenovo");
    }
    /* 
    * Tecno Methods
    */
    else if (query.toLowerCase().contains("tecno")) {
      query = query.replaceAll("tecno", "Tecno");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allTecno",
          collection2: "tecno");
    }
    /* 
    * Nokia Methods
    */
    else if (query.toLowerCase().contains("nokia")) {
      query = query.replaceAll("nokia", "Nokia");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allNokia",
          collection2: "nokia");
    }
    /* 
    * Oppo Methods
    */
    else if (query.toLowerCase().contains("oppo")) {
      query = query.replaceAll("oppo", "Oppo");
      return SearchResult(
          query: query,
          collection1: "phonesCategory",
          doc1: "allOppo",
          collection2: "oppo");
    } else if (query.trim().isNotEmpty) {
      return SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: CustomText(
                text: "Sorry!, We don't have each categories of phones yet.",
                fontSize: 17,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
              )),
              // const SizedBox(height: 10,),
              Lottie.asset("assets/lotties/no_data.json"),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
