import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sudaphone_sd/view/details/details.dart';

class PhoneList extends StatelessWidget {
  const PhoneList(
      {required this.collction,
      required this.snapshot,
      required this.docOne,
      required this.isHasData,
      Key? key})
      : super(key: key);
  final docOne;
  final collction;
  final snapshot;
  final isHasData;

  @override
  Widget build(BuildContext context) {
    if (isHasData.hasData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3.9,
            width: 100,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      height: MediaQuery.of(context).size.height / 3.9,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Price : ${snapshot?.data()['price']}",
                                  style: const TextStyle(color: Colors.pink)),
                              const SizedBox(
                                width: 20,
                              ),
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
                    child: isHasData.connectionState != ConnectionState.waiting
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loader.gif",
                            image: "${snapshot?.data()['imageUrl']}",
                            height: MediaQuery.of(context).size.height / 4)
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Get.to(
                () => Details(
                    docTwo: snapshot.id, docOne: docOne, collction: collction),
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
            Lottie.asset("assets/lotties/loading.json"),
          ],
        ),
      );
    } else {
      return Center(
        child: Lottie.asset("assets/lotties/loading.json"),
      );
    }
  }
}
