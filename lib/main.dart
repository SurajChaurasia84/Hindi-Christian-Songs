import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const HindiChristianSongsApp());
}

class HindiChristianSongsApp extends StatelessWidget {
  const HindiChristianSongsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hindi Christian Songs',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Adapts to user's system setting (Light/Dark)
      home: const HomePage(),
    );
  }
}
