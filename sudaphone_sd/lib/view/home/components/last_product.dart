import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view/details/last_product_details.dart';

class LastProduct extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LastProduct({ required this.collection,
    required this.phoneDoc, required this.name, required this.imageUrl
  });
  
  final String phoneDoc;
  final String collection;
  final String name;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GridTile(
        footer: Container(
          height: 40,
          color: Colors.black.withOpacity(.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                  children: <TextSpan>[
                    TextSpan(text: name),
                  ],
                ),
              ),
            ],
          ),
        ),
        child: Image.network(imageUrl),
      ),
      onTap: () {
        LastProducDetails(phoneDoc: phoneDoc , collection: collection,);
      },
    );
  }
}
