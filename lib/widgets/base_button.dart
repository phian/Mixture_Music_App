import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class BaseButton extends StatelessWidget {
  final String content;
  final Color? buttonColor;
  final BorderRadius? buttonRadius;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;

  const BaseButton({
    required this.content,
    this.margin,
    this.constraints,
    this.buttonColor,
    this.buttonRadius,
    this.onTap,
    this.contentPadding,
    this.contentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      child: InkWellWrapper(
        color: buttonColor ?? AppColors.cE30098,
        borderRadius: buttonRadius,
        onTap: onTap,
        child: Container(
          padding: contentPadding ?? EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: Text(
            content,
            style: contentStyle ??
                TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
