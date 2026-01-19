import 'package:flutter/material.dart';

class HomeImageSlider extends StatelessWidget {
  final PageController controller;
  final List<String> images;
  final double height;

  const HomeImageSlider({
    super.key,
    required this.controller,
    required this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: PageView.builder(
          controller: controller,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
