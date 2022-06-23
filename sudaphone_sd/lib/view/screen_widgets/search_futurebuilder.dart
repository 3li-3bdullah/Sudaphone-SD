import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';
import 'package:sudaphone_sd/view/widgets/phone_list.dart';

// ignore: must_be_immutable
class SearchFutureBuilder extends StatelessWidget {
  SearchFutureBuilder({required this.query, Key? key}) : super(key: key);
  String query;

  @override
  Widget build(BuildContext context) {
    /* 
    * Huawei Methods
    */
    if (query.toLowerCase().contains("huawei") || query.toLowerCase().contains("honor")) {
     
      log(query.toString());
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allHuawei")
              .collection("huawei")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "huawei",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allHuawei",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * To see if the query empty or not 
    */
    else if (query.isEmpty) {
      return const Center(
        child: CustomText(
            text: "What's the phone are looking for!",
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
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allSamsung")
              .collection("samsung")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "samsung",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allSamsung",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Iphone Methods
    */
    else if (query.toLowerCase().contains("iphone")) {
      query = query.replaceAll("iphone", "Iphone");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allIphone")
              .collection("iphone")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "iphone",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allIphone",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Vivo Methods
    */
    else if (query.toLowerCase().contains("vivo")) {
      query = query.replaceAll("vivo", "Vivo");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allVivo")
              .collection("vivo")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "vivo",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allVivo",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Realme Methods
    */
    else if (query.toLowerCase().contains("realme")) {
      query = query.replaceAll("realme", "Realme");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allRealme")
              .collection("realme")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "realme",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allRealme",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
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
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allXiaomi")
              .collection("xiaomi")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "xiaomi",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allXiaomi",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Lenovo Methods
    */
    else if (query.toLowerCase().contains("lenovo")) {
      query = query.replaceAll("lenovo", "Lenovo");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allLenovo")
              .collection("lenovo")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "lenovo",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allLenovo",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Tecno Methods
    */
    else if (query.toLowerCase().contains("tecno")) {
      query = query.replaceAll("tecno", "Tecno");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allTecno")
              .collection("tecno")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "tecno",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allTecno",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Nokia Methods
    */
    else if (query.toLowerCase().contains("nokia")) {
      query = query.replaceAll("nokia", "Nokia");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allNokia")
              .collection("nokia")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "nokia",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allNokia",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    }
    /* 
    * Oppo Methods
    */
    else if (query.toLowerCase().contains("oppo")) {
      query = query.replaceAll("oppo", "Oppo");
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allOppo")
              .collection("oppo")
              .orderBy('name')
              .startAt([query]).endAt([query + '\uf8ff']).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return PhoneList(
                      isHasData: snapshot,
                      collction: "oppo",
                      snapshot: snapshot.data?.docs[index],
                      docOne: "allOppo",
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("assets/lottie/searching.json"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              );
            }
          });
    } else {
      return const SizedBox(
          // child: CustomText(
          //     text: "Please write the phone's brand first ",
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //     textAlign: TextAlign.center,
          //     color: Colors.pink),
          );
    }
  }
}
