import 'package:flutter/material.dart';

import '../constants/enums/enums.dart';
import 'rounded_inkwell_wrapper.dart';

class SignInButton extends StatelessWidget {
  final SignInType signInType;
  final Color buttonColor;
  final Widget child;
  final void Function()? onTap;

  SignInButton({
    required this.signInType,
    required this.buttonColor,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedInkWellWrapper(
      color: buttonColor,
      child: child,
      onTap: onTap,
    );
  }
}
