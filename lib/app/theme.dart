import 'package:flutter/material.dart';

class AppTheme {
  static const Color purple = Color(0xFF8000E2);
  static const Color deepPurple = Color(0xFF9212BA);
  static const Color orange = Color(0xFFFE5F02);
  static const Color yellow = Color(0xFFFFE100);
  static const Color background = Color(0xFFF6EFE0);

  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: purple,
      brightness: Brightness.light,
    );

    final scheme = base.copyWith(
      primary: purple,
      primaryContainer: deepPurple,
      secondary: orange,
      tertiary: yellow,
      surface: background,
      background: background,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
