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
        backgroundColor: Color(0xFFF3EDF7), // Solid color matching Material 3 light background
        surfaceTintColor: Colors.transparent, // Prevents color change on scroll
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
        backgroundColor: Color(0xFF141218), // Solid color matching Material 3 dark background
        surfaceTintColor: Colors.transparent, // Prevents color change on scroll
      ),
      dividerTheme: const DividerThemeData(space: 1),
    );
  }
}
