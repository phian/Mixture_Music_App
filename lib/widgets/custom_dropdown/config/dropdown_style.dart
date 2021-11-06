import 'package:flutter/material.dart';

class DropdownButtonStyle {
  final OutlinedBorder? buttonShape;
  final double? buttonElevation;
  final Color? buttonBackgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? buttonPrimaryColor;
  final BorderSide? side;
  final Color? shadowColor;
  final Duration? animationDuration;
  final TextStyle? buttonTextStyle;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;

  const DropdownButtonStyle({
    this.buttonBackgroundColor,
    this.buttonPrimaryColor,
    this.constraints,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonElevation,
    this.padding,
    this.buttonShape,
    this.side,
    this.shadowColor,
    this.animationDuration,
    this.buttonTextStyle,
    this.fixedSize,
    this.maximumSize,
    this.minimumSize,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? dropdownColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  /// button width must be set for this to take effect
  final double? dropdownWidth;
  final double? dropdownHeight;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.dropdownWidth,
    this.elevation,
    this.dropdownColor,
    this.padding,
    this.borderRadius,
    this.dropdownHeight,
  });
}
