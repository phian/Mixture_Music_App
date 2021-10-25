import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;

  LoadingContainer({
    Key? key,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.width,
    this.height,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: width ?? 100.0,
        height: height ?? 100.0,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: shape,
          color: loadingColor ?? Colors.grey,
        ),
      ),
    );
  }
}
