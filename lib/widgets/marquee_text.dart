import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeText extends StatelessWidget {
  const MarqueeText(
    this.text, {
    Key? key,
    this.style,
    this.horizontalPadding,
  }) : super(key: key);

  final String text;
  final double? horizontalPadding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(
            text: text,
            style: style,
          );

          final painter = TextPainter(
            text: span,
            maxLines: 1,
            textDirection: TextDirection.ltr,
          );

          painter.layout();

          final isOverflow = painter.size.width > constraints.maxWidth;

          return SizedBox(
            height: painter.size.height,
            child: isOverflow
                ? Marquee(
                    text: text,
                    style: style,
                    blankSpace: 50,
                    startAfter: Duration(seconds: 2),
                    pauseAfterRound: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeEndFraction: 0.1,
                    fadingEdgeStartFraction: 0.1,
                  )
                : Text(
                    text,
                    style: style,
                  ),
          );
        },
      ),
    );
  }
}
