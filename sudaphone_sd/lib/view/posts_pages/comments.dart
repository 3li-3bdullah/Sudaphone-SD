import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey))),
                        child: Row(children: [
                          IconButton(
                              icon: const Icon(Icons.camera_alt_outlined,
                                  color: Colors.purple),
                              onPressed: () {}),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: MediaQuery.of(context).size.width - 70,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "أكتب تعليقك هنا",
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.send_outlined,
                                          color: Colors.green.shade900),
                                      onPressed: () {}),
                                  contentPadding: const EdgeInsets.all(5),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide:
                                         const BorderSide(style: BorderStyle.none)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide:
                                         const BorderSide(style: BorderStyle.none)),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              )),
                        ]),
                      )
                    ]),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
