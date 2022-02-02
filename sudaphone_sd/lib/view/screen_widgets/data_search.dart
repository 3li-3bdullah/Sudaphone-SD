import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
          onPressed: () {
            query = " ";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return (IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back),
    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Result Search
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searchers for something
    return const Text("Body Search");
    //  ListView.builder(
    //     itemCount: searchlist.length,
    //     itemBuilder: (context, i) {
    //       return ListTile(
    //         leading: Icon(Icons.mobile_screen_share),
    //         title: Text(name),
    //         onTap: () {
    //           query = name;
    //           showResults(context);
    //         },
    //       );
    //     });
    // Text("Body Search");
  }
}
