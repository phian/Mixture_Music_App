import 'package:flutter/material.dart';

class StackedImages extends StatelessWidget {
  final List<String> songImages;
  final TextDirection direction;
  final double size;
  final double xShift;
  final BorderRadius? imageRadius;

  const StackedImages({
    Key? key,
    required this.songImages,
    this.direction = TextDirection.ltr,
    this.size = 100.0,
    this.xShift = 7.0,
    this.imageRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allImages = songImages
        .asMap()
        .map((index, songUrl) {
          final left = size - xShift;

          final value = Container(
            child: ClipRRect(
              borderRadius: imageRadius ?? BorderRadius.circular(8.0),
              child: Image.network(
                songUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.only(left: left * index),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();

    return Stack(
      children: direction == TextDirection.ltr ? allImages.reversed.toList() : allImages,
    );
  }
}
