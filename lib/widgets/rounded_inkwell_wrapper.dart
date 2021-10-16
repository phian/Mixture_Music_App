import 'package:flutter/material.dart';

class RoundedInkWellWrapper extends StatelessWidget {
  final Color color;

  final VoidCallback? onTap;

  final Widget child;

  const RoundedInkWellWrapper({
    Key? key,
    required this.color,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
