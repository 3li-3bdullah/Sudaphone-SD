import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/details.dart';

// ignore: must_be_immutable
class PhoneList extends StatelessWidget {
  PhoneList(
      {required this.collction,
      required this.snapshot,
      required this.docOne,
      required this.docTwo,
      Key? key})
      : super(key: key);
  var docOne;
  var docTwo;
  var collction;
  var snapshot;

  @override
  Widget build(BuildContext context) {
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
                            child: Text("${snapshot.data()['name']}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center),
                          ),
                          Row(children: [
                            const Text("Rear Camera : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot.data()['rearCamera']}",
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          Row(children: [
                            const Text("Performance : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot.data()['performance']}",
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          Row(children: [
                            const Text("Storage : ",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot.data()['storage']}",
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          Row(children: [
                            const Text("Battery :",
                                style: TextStyle(color: Colors.grey)),
                            Text("${snapshot.data()['battery']}",
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          Row(
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Text("Price : ${snapshot.data()['price']}",
                                      style:
                                          const TextStyle(color: Colors.pink)),
                                ]),
                              ),
                              Row(children: const [
                                Text("more...",
                                    style: TextStyle(color: Colors.green)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1, child: Image.network(snapshot.data()['imageUrl'])),
              ],
            ),
          ),
        ),
        onTap: () {
          Get.to(
              () => Details(
                  snapshot: snapshot,
                  docOne: docOne,
                  docTwo: docTwo,
                  collction: collction),
              transition: Transition.zoom);
        },
      ),
    );
  }
}
