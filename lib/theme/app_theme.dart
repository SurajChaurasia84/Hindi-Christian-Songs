import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, height: 1.6),
        bodyMedium: TextStyle(fontSize: 16, height: 1.5),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(space: 1),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD0BCFF),
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, height: 1.6),
        bodyMedium: TextStyle(fontSize: 16, height: 1.5),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(space: 1),
    );
  }
}
