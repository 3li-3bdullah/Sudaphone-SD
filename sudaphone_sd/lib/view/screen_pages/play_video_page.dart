import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class PlayVideoPage extends StatelessWidget {
  const PlayVideoPage({Key? key, required this.controller}) : super(key: key);
  final BetterPlayerController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 2,
          child: BetterPlayer(controller: controller)),
      ),
    );
  }
}