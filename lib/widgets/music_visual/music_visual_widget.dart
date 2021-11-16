import 'package:flutter/material.dart';

class MusicVisualizer extends StatefulWidget {
  const MusicVisualizer({
    Key? key,
    required this.colors,
    required this.durations,
    this.visualComponentAmount = 5,
  }) : super(key: key);

  final List<Color> colors;
  final List<int> durations;
  final int visualComponentAmount;

  @override
  State<MusicVisualizer> createState() => _MusicVisualizerState();
}

class _MusicVisualizerState extends State<MusicVisualizer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        widget.colors.length,
        (index) => Container(
          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 8.0),
          child: _MusicVisualWidget(
            duration: widget.durations[index % widget.durations.length],
            color: widget.colors[index % widget.colors.length],
          ),
        ),
      ),
    );
  }
}

class _MusicVisualWidget extends StatefulWidget {
  const _MusicVisualWidget({
    Key? key,
    required this.color,
    required this.duration,
  }) : super(key: key);
  final int duration;
  final Color color;

  @override
  __MusicVisualWidgetState createState() => __MusicVisualWidgetState();
}

class __MusicVisualWidgetState extends State<_MusicVisualWidget> with SingleTickerProviderStateMixin {
  late Animation<double> _visualAnimation;
  late AnimationController _animationController;

  void _initAnimation() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.slowMiddle,
      // curve: Curves.decelerate,
    );
    _visualAnimation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.0,
      height: _visualAnimation.value,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
