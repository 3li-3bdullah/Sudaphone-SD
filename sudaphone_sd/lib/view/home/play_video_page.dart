import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:sudaphone_sd/view_model/home_view_model.dart';
import 'package:get/get.dart';

class PlayVideoPage extends GetWidget<HomeViewModel> {
  const PlayVideoPage({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    controller.mediaUrl.value = videoUrl;
    controller.initialPlayer();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 2,
          child: BetterPlayer(
            controller: controller.betterPlayerController,
          ),
        ),
      ),
    );
  }
}
