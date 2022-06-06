import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view/details.dart';

import '../widgets/custom_text.dart';

class LastProduct extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LastProduct({
    required this.imageProduct,
    required this.text,
    required this.price,
    required this.docOne,
     required this.collection,
     required this.snapshot,
     
  });
  final String imageProduct;
  final String text;
  final String price;
  final String docOne;
  final String collection;
  final dynamic snapshot;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: GridTile(
            child: Image.network(imageProduct),
            footer: Container(
                height: 40,
                color: Colors.black.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: text,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ), 
                    CustomText(text: "\$$price",color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,)
                  ],
                ),
                )),
        onTap: () {
          Details(docTwo: snapshot.id, docOne: docOne, collction: collection);
        },
      ),
    );
  }
}