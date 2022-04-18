import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/details.dart';

// ignore: must_be_immutable
class PhoneList extends StatelessWidget {
  PhoneList(
      {required this.collction,
      required this.snapshot,
      required this.docOne,
      required this.isHasData,
      Key? key})
      : super(key: key);
  var docOne;
  var collction;
  var snapshot;
  var isHasData;

  @override
  Widget build(BuildContext context) {
    if (isHasData.hasData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          child: SizedBox(
            height: 180,
            width: 100,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      height: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            child: Text("${snapshot?.data()['name']}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center),
                          ),
                          Row(children: [
                            const Text("Front Camera : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot?.data()['frontCamera']}",
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(children: [
                            const Text("OS : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot?.data()['os']}",
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(children: [
                            const Text("Storage : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot?.data()['storage']}",
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(children: [
                            const Text("Battery :",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot?.data()['battery']}",
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Price : ${snapshot?.data()['price']}",
                                  style: const TextStyle(color: Colors.pink)),
                              const Text("more..",
                                  style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Image.network("${snapshot?.data()['imageUrl']}")),
                ],
              ),
            ),
          ),
          onTap: () {
            Get.to(
                () => Details(
                    snapshot: snapshot, docOne: docOne, collction: collction),
                transition: Transition.zoom);
          },
        ),
      );
    } else if (isHasData.connectionState == ConnectionState.waiting) {
      return SizedBox(
        height: 180,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/please_wait.json"),
          ],
        ),
      );
    } else {
      return Center(
        child: Lottie.asset("assets/lottie/please_wait.json"),
      );
    }
  }
}
