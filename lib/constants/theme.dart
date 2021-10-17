import 'package:flutter/material.dart';

class AppTheme {
  static const Color brightGrey = Color(0xFF334449);
  static const Color subTextColor = Color(0xFF5C5C5F);
  static const Color subTextColor2 = Color(0xFFA0ABB3);

  static const Color primaryColor = Color(0xFF489AB4);

  static const String fontName = 'Roboto';

  AppTheme._();
  static final ThemeData light = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFF489AB4),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFF489AB4),
    ),
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 28,
    letterSpacing: 0.25,
    color: brightGrey,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.25,
    color: brightGrey,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: brightGrey,
  );

  static const TextStyle subText = TextStyle(
    fontFamily: AppTheme.fontName,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: subTextColor2,
  );
}
