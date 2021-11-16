import 'package:flutter/material.dart';

class TextFieldConfig {
  final String? initialValue;
  final TextStyle? style;
  final bool autoFocus;
  final Color? cursorColor;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autocorrect;
  final String obscureCharacter;
  final bool enableSuggestions;
  final FocusNode? focusNode;
  final InputDecoration? inputDecoration;
  final bool isEnabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final TextAlignVertical? textAlignVertical;
  final bool readOnly;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  const TextFieldConfig({
    this.initialValue,
    this.style,
    this.autoFocus = false,
    this.cursorColor,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autocorrect = true,
    this.obscureCharacter = '•',
    this.enableSuggestions = true,
    this.focusNode,
    this.inputDecoration,
    this.isEnabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.textAlignVertical,
    this.readOnly = false,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
    this.controller,
  });
}
