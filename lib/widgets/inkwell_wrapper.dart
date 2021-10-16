import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;
  final Widget child;
  final BorderRadius? borderRadius;

  const InkWellWrapper({
    Key? key,
    required this.color,
    this.onTap,
    required this.child,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      child: Container(
        color: color,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
