import 'package:flutter/material.dart';

class UnFocusWidget extends StatelessWidget {
  final Widget child;

  const UnFocusWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (primaryFocus != null) {
          primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}
