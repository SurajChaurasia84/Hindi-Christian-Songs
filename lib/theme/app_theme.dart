import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A1F33),
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(0xFF0A1F33),
        secondary: const Color(0xFF123A5A),
        surface: const Color(0xFFF7F9FB),
        inversePrimary: const Color(0xFF0A1F33),
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F9FB),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 18, height: 1.6),
        bodyMedium: TextStyle(fontSize: 16, height: 1.5),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF0A1F33),
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(space: 1),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A1F33),
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
        backgroundColor: Color(0xFF211F26), // Slightly lighter than background for contrast
        foregroundColor: Color(0xFFE6E1E5), // Off-white text
        surfaceTintColor: Colors.transparent, // Prevents color change on scroll
      ),
      dividerTheme: const DividerThemeData(space: 1),
    );
  }
}
