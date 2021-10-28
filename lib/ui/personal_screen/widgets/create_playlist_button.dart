import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class CreatePlaylistCard extends StatelessWidget {
  const CreatePlaylistCard({
    Key? key,
    this.onTap,
    this.title,
    this.icon,
    this.iconBackgroundColor,
    this.titleStyle,
    this.contentPadding,
    this.cardRadius,
  }) : super(key: key);

  final void Function()? onTap;
  final Color? iconBackgroundColor;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? icon;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? cardRadius;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      color: AppColors.transparent,
      onTap: onTap,
      borderRadius: cardRadius ?? BorderRadius.zero,
      child: Container(
        padding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? AppColors.darkBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: icon ??
                  const Icon(
                    Icons.add_circle_outline_outlined,
                    size: 30.0,
                    color: AppColors.white,
                  ),
            ),
            const SizedBox(width: 16.0),
            Text(
              title ?? 'Add playlist',
              style: titleStyle ??
                  AppTextStyles.lightTextTheme.caption?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: iconBackgroundColor ?? AppColors.darkBlue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
