import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    // Determine the current effective brightness for the toggle
    bool isDark = themeProvider.themeMode == ThemeMode.dark;
    if (themeProvider.themeMode == ThemeMode.system) {
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode_rounded),
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle between light and dark theme'),
              value: isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
