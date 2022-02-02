import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudaphone_sd/view/categories_pages/mobiledetails.dart';

class MobList extends StatelessWidget {
  final String? name;
  final String? camera;
  final String? cpu;
  final String? battery;
  final String? price;
  final String? memory;
  final String? imageAtDetails;
  MobList(
      {required this.battery,
      required this.camera,
      required this.cpu,
      required this.memory,
      required this.name,
      required this.price,
      required this.imageAtDetails});
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
                Expanded(flex: 1, child: Image.asset(imageAtDetails!)),
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
                            child: Text(name!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center),
                          ),
                          Row(children: [
                            const Text("الكاميرا:",
                                style: TextStyle(color: Colors.grey)),
                            Text(camera!,
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          Row(children: [
                            const Text("المعالج : ",
                                style: TextStyle(color: Colors.grey)),
                            Text(cpu!,
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          Row(children: [
                            const Text("الذاكرة:",
                                style: TextStyle(color: Colors.grey)),
                            Text(memory!,
                                style: const TextStyle(color: Colors.blue)),
                          ]),
                          Row(children: [
                            const Text("البطارية :",
                                style: TextStyle(color: Colors.grey)),
                            Text(battery!,
                                style: const TextStyle(color: Colors.blue))
                          ]),
                          Row(
                            children: [
                              Expanded(
                                child: Row(children: [
                                  Text("السعر : $price",
                                      style:
                                          const TextStyle(color: Colors.pink)),
                                ]),
                              ),
                              Row(children: const [
                                Text("للمزيد إضغط هنا",
                                    style: TextStyle(color: Colors.green)),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        onTap: () {
          Get.to( MobileDetails(photo: imageAtDetails!,namePhone: name!,));
        },
      ),
    );
  }
}
