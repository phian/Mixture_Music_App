import 'package:flutter/material.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({
    Key? key,
    required this.imageUrls,
    this.gridRadius,
    this.loadingHeight,
    this.loadingWidth,
    this.gridSize,
    this.gridImageAmount = 4,
  }) : super(key: key);

  final List<String?> imageUrls;
  final BorderRadius? gridRadius;
  final double? gridSize;
  final double? loadingWidth;
  final double? loadingHeight;
  final int gridImageAmount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: gridRadius ?? BorderRadius.zero,
      child: SizedBox(
        height: gridSize ?? MediaQuery.of(context).size.width / 2,
        width: gridSize ?? MediaQuery.of(context).size.width / 2,
        child: Wrap(
          direction: Axis.vertical,
          children: List.generate(
            gridImageAmount,
            (index) => Image.network(
              imageUrls[index] ?? '',
              width: (gridSize ?? MediaQuery.of(context).size.width) / 4,
              height: (gridSize ?? MediaQuery.of(context).size.width) / 4,
              loadingBuilder: (context, child, chunkEvent) {
                if (chunkEvent == null) return child;

                return LoadingContainer(width: loadingWidth ?? 30.0, height: loadingHeight ?? 30.0);
              },
            ),
          ),
        ),
      ),
    );
  }
}
