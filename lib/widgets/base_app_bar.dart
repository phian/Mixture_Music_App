import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({this.actions, this.height});
  final List<Widget>? actions;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: AppColors.transparent,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
