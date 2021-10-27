import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class AppThemes {
  AppThemes._();

  static final baseLightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppTextStyles.fontName,
    //scaffoldBackgroundColor: lightBackgroundColor,
    textTheme: AppTextStyles.lightTextTheme,
    colorScheme: const ColorScheme.light().copyWith(
      secondary: AppColors.captionTextColor,
    ),
    hintColor: AppColors.hintColor,
  );

  

  static final baseDarkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppTextStyles.fontName,
    //scaffoldBackgroundColor: darkBackgroundColor,
    textTheme: AppTextStyles.darkTextTheme,
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: AppColors.captionTextColor,
    ),
    hintColor: AppColors.darkHintColor,
  );

  static final lightColdTheme = baseLightTheme.copyWith(
    primaryColor: AppColors.darkBlue,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.darkBlue,
    ),
  );

  static final lightCoolTheme = baseLightTheme.copyWith(
    primaryColor: AppColors.coolBlue,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.coolBlue,
    ),
  );

  static final lightWarmTheme = baseLightTheme.copyWith(
    primaryColor: AppColors.fadedOrange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.fadedOrange,
    ),
  );

  static final lightHotTheme = baseLightTheme.copyWith(
    primaryColor: AppColors.orange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.orange,
    ),
  );

  static final darkColdTheme = baseDarkTheme.copyWith(
    primaryColor: AppColors.darkBlue,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.darkBlue,
    ),
  );

  static final darkCoolTheme = baseDarkTheme.copyWith(
    primaryColor: AppColors.coolBlue,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.coolBlue,
    ),
  );

  static final darkWarmTheme = baseDarkTheme.copyWith(
    primaryColor: AppColors.fadedOrange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.fadedOrange,
    ),
  );

  static final darkHotTheme = baseDarkTheme.copyWith(
    primaryColor: AppColors.orange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.orange,
    ),
  );
}
