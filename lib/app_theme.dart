import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';

class MyAppTheme {
  bool isDark;

  MyAppTheme({required this.isDark});

  ThemeData get themeData {
    ColorScheme colorScheme = ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: cPrimaryColor,
        primaryVariant: cPrimaryColor,
        secondary: cPrimaryColor,
        secondaryVariant: cPrimaryColor,
        background: cSilver,
        surface: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400);

    var t = ThemeData.from(
      colorScheme: colorScheme,
    ).copyWith(
        highlightColor: cPrimaryColor, toggleableActiveColor: cPrimaryColor);

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}
