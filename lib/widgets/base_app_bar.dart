import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({
    this.actions,
    this.title,
    this.centerTitle,
    this.backgroundColor,
    this.elevation,
  });

  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
      title: title,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
