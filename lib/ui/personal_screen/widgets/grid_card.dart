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

  @override
  _GridCardState createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.contentPadding ?? const EdgeInsets.all(8.0),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.cardRadius ?? BorderRadius.circular(12.0),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 0.5,
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child:
                  Icon(widget.cardIcon, size: 35.0, color: widget.iconColor)),
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
                widget.countNumber != null
                    ? Text('${widget.countNumber}')
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
