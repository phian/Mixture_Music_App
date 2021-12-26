import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // default theme
  var light = FlexColorScheme.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  ).toTheme.obs;

  var dark = FlexColorScheme.dark(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
  ).toTheme.obs;

  void setThemeColor(Color value) {
    var schemeColor = FlexSchemeColor.from(
      primary: value,
    );

    // set two theme in the same time so if change light to dark mode, primary color will be synchronized
    dark.value = FlexColorScheme.dark(
      colors: schemeColor,
    ).toTheme;

    light.value = FlexColorScheme.light(
      colors: schemeColor,
    ).toTheme;
  }
}
