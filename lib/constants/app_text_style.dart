import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const fontName = 'Roboto';

  static const lightTextTheme = TextTheme(
    headline4: _h4,
    headline5: _h5,
    caption: _caption,
    subtitle1: _subText,
  );

  static const darkTextTheme = TextTheme(
    headline4: _h4,
    headline5: _h5,
    caption: _caption,
    subtitle1: _subText,
  );

  static const TextStyle _h4 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.25,
    color: AppColors.captionTextColor,
  );

  static const TextStyle _h5 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.25,
    color: AppColors.captionTextColor,
  );

  static const TextStyle _caption = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.captionTextColor,
  );

  static const TextStyle _subText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subTextColor,
  );
}
