import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about_app_screen.dart';
import 'settings_screen.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Placeholder songs list
  final List<String> _dummySongs = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                color: theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.library_music_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Hindi Christian Songs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
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
      body: Stack(
        children: [
          // Background Music Graphics
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.03, // Very subtle background opacity
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: -20,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Icon(Icons.church_rounded, size: 160, color: theme.colorScheme.onSurface),
                      ),
                    ),
                    Positioned(
                      top: 250,
                      right: -30,
                      child: Transform.rotate(
                        angle: 0.3,
                        child: Icon(Icons.menu_book_rounded, size: 200, color: theme.colorScheme.onSurface),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 20,
                      child: Transform.rotate(
                        angle: -0.1,
                        child: Icon(Icons.volunteer_activism_rounded, size: 140, color: theme.colorScheme.onSurface),
                      ),
                    ),
                    Positioned(
                      bottom: -40,
                      right: 40,
                      child: Transform.rotate(
                        angle: 0.15,
                        child: Icon(Icons.music_note_rounded, size: 180, color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Content
          Column(
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
                child: _dummySongs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.music_note_rounded,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No lyrics available yet',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
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
        ],
      ),
    );
  }
}
