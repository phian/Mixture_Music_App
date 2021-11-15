import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';


class AppThemes {
  AppThemes._();

  static ThemeData buildTheme(Color primaryColor, bool isDarkMode) {
    FlexSchemeColor schemeColor = FlexSchemeColor.from(
      primary: primaryColor,
    );

    ThemeData theme;

    isDarkMode
        ? theme = FlexColorScheme.dark(
            colors: schemeColor,
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          ).toTheme
        : theme = FlexColorScheme.light(
            colors: schemeColor,
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          ).toTheme;

    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        headline4: theme.textTheme.headline4!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      // add another custom style
    );
  }
}
