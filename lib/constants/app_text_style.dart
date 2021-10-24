import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppTextStyles {
  AppTextStyles._();

  static const fontName = 'Roboto';

  static const lightTextTheme = TextTheme(
    headline4: h4,
    headline5: h5,
    caption: caption,
    subtitle1: subText,
  );

  static const darkTextTheme = TextTheme(
    headline4: darkH4,
    headline5: darkH5,
    caption: darkCaption,
    subtitle1: darkSubText,
  );

  static const TextStyle h4 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.25,
    color: AppColors.captionTextColor,
  );

  static const TextStyle h5 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.25,
    color: AppColors.captionTextColor,
  );

  static const TextStyle caption = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.captionTextColor,
  );

  static const TextStyle subText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subTextColor,
  );

  // ========= dark style ========================

  static const TextStyle darkH4 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.25,
    color: AppColors.darkCaptionTextColor,
  );

  static const TextStyle darkH5 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.25,
    color: AppColors.darkCaptionTextColor,
  );

  static const TextStyle darkCaption = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.darkCaptionTextColor
  );

  static const TextStyle darkSubText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkSubTextColor,
  );
}
