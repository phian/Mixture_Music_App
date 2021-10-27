import 'package:flutter/material.dart';

import '../constants/enums/enums.dart';
import 'rounded_inkwell_wrapper.dart';

class SignInButton extends StatelessWidget {
  final SignInType signInType;
  final Color buttonColor;
  final Widget child;
  final void Function()? onTap;

  const SignInButton({
    Key? key,
    required this.signInType,
    required this.buttonColor,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedInkWellWrapper(
      color: buttonColor,
      child: child,
      onTap: onTap,
    );
  }
}
