import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about_app_screen.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Placeholder songs list
  final List<String> _dummySongs = [
    "Aradhana Karte Hain",
    "Tu Hi Rab Hai",
    "Yeshu Tera Naam Sabse Uncha",
    "Aatma Ka Fal",
    "Dhanyawad Ke Saath",
    "Mera Prabhu Yeshu",
    "Mahima Ho Teri",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    // Determine the current effective brightness for the toggle
    bool isDark = themeProvider.themeMode == ThemeMode.dark;
    if (themeProvider.themeMode == ThemeMode.system) {
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hindi Christian Songs'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.library_music_rounded,
                    size: 48,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hindi Christian Songs',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_rounded),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category_rounded),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode_rounded),
              title: const Text('Dark Mode'),
              value: isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutAppScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar Placeholder
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search lyrics...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Songs List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: _dummySongs.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: theme.colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    _dummySongs[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_border_rounded),
                    onPressed: () {
                      // TODO: Toggle favorite status
                    },
                  ),
                  onTap: () {
                    // TODO: Navigate to lyrics detail page
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
