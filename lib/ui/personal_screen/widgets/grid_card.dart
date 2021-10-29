import 'package:flutter/material.dart';

import '../../../constants/app_text_style.dart';

class GridCard extends StatefulWidget {
  const GridCard({
    Key? key,
    required this.cardIcon,
    required this.cardTitle,
    required this.iconColor,
    this.contentPadding,
    this.cardRadius,
    this.countNumber,
    this.width,
    this.height,
    this.cardColor,
    this.onTap,
  }) : super(key: key);

  // final String cardIcon;
  final EdgeInsetsGeometry? contentPadding;
  final IconData cardIcon;
  final String cardTitle;
  final Color iconColor;
  final BorderRadius? cardRadius;
  final int? countNumber;
  final double? width;
  final double? height;
  final Color? cardColor;
  final void Function()? onTap;

  @override
  _GridCardState createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> with SingleTickerProviderStateMixin {
  late double _scale;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (tapUpDetails) {
        _onTapUp(tapUpDetails);
        widget.onTap?.call();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          padding: widget.contentPadding ?? const EdgeInsets.all(8.0),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.cardRadius ?? BorderRadius.circular(12.0),
            color: widget.cardColor ?? Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Icon(widget.cardIcon, size: 35.0, color: widget.iconColor)),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.cardTitle,
                        style: AppTextStyles.lightTextTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widget.countNumber != null ? Text('${widget.countNumber}') : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
