import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class MRefreshIndicator extends StatelessWidget {
  const MRefreshIndicator({
    Key? key,
    required this.context,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final BuildContext context;
  final Widget child;
  final IndicatorController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            if (!controller.isIdle)
              Positioned(
                top: 35.0 * controller.value,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    value: !controller.isLoading ? controller.value.clamp(0.0, 1.0) : null,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, 100.0 * controller.value),
              child: child,
            ),
          ],
        );
      },
    );
  }
}
