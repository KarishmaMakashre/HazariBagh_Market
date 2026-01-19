import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeVideoBanner extends StatelessWidget {
  final VideoPlayerController controller;
  final double height;

  const HomeVideoBanner({
    super.key,
    required this.controller,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: controller.value.isInitialized
            ? SizedBox(
          height: height,
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
        )
            : SizedBox(
          height: height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
