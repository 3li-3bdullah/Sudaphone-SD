import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view/categories_pages/moblist.dart';
import 'package:sudaphone_sd/view/widgets/custom_text.dart';

class Nokia extends StatelessWidget {
   Nokia({ Key? key }) : super(key: key);

  final List<Map<String, String>> _mobilelist = <Map<String, String>>[
    {
      'image': 'assets/images/product/nokia.jpg',
      'name': 'G300',
      'camera': '108 Megapixel',
      'cpu': 'Snapdragon 865 ثماني',
      'battery': '7000mha شحن سريع w15',
      'price': '1200\$',
      'memory': '256GB'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const CustomText(
                text: 'Nokia',
                textAlign: TextAlign.center,
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.normal),
            centerTitle: true,
          ),
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
              itemCount: _mobilelist.length,
              itemBuilder: (context, i) {
                return MobList(
                  imageAtDetails: _mobilelist[i]['image'],
                  battery: _mobilelist[i]['battery'],
                  name: _mobilelist[i]['name'],
                  cpu: _mobilelist[i]['cpu'],
                  camera: _mobilelist[i]['camera'],
                  memory: _mobilelist[i]['memory'],
                  price: _mobilelist[i]['price'],
                );
              },
            ),
          ),
        ));
  }
}