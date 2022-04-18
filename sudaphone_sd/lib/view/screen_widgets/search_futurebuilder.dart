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
    if (query.toLowerCase().contains("huawei") || query.contains("Huawei")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allHuawei")
              .collection("huawei")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
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
    else if (query.toLowerCase().contains("samsung") || query.contains("Samsung")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allSamsung")
              .collection("samsung")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Iphone Methods
    */
    else if (query.toLowerCase().contains("iphone") || query.contains("Iphone")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allIphone")
              .collection("iphone")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Vivo Methods
    */
    else if (query.toLowerCase().contains("vivo") || query.contains("vivo")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allVivo")
              .collection("vivo")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Realme Methods
    */
    else if (query.toLowerCase().contains("realme") || query.contains("Realme")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allRealme")
              .collection("realme")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Xiaomi Methods
    */
    else if (query.toLowerCase().contains("xiaomi") ||
        query.toLowerCase().contains("poco") || query.contains("Xiaomi")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allXiaomi")
              .collection("xiaomi")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Lenovo Methods
    */
    else if (query.toLowerCase().contains("lenovo") || query.contains("Lenovo")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allLenovo")
              .collection("lenovo")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Tecno Methods
    */
    else if (query.toLowerCase().contains("tecno") || query.contains("Tecno")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allTecno")
              .collection("tecno")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Nokia Methods
    */
    else if (query.toLowerCase().contains("nokia") || query.contains("nokia")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allNokia")
              .collection("nokia")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    }
    /* 
    * Oppo Methods
    */
    else if (query.toLowerCase().contains("oppo") || query.contains("Oppo")) {
      return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("phonesCategory")
              .doc("allOppo")
              .collection("oppo")
              .where("name", isGreaterThanOrEqualTo: query)
              .get(),
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
                  color: Colors.purpleAccent,
                ),
              );
            }
          });
    } else {
      return const Center(
        child: CustomText(
            text: "Please write the phone's brand first ",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: Colors.pink),
      );
    }
  }
}
