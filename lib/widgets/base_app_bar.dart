import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.actions,
    this.title,
    this.centerTitle,
    this.backgroundColor,
    this.elevation,
    this.leading,
  }) : super(key: key);

  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: actions,
      title: title,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
