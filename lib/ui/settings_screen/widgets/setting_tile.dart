import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.tileRadius,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? tileRadius;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: onTap,
      color: AppColors.transparent,
      borderRadius: tileRadius ?? BorderRadius.zero,
      child: Container(
        padding: contentPadding ?? const EdgeInsets.all(16.0),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 16.0),
            Expanded(child: title),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
