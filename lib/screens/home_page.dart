import 'package:flutter/material.dart';

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
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hindi Christian Songs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Songs',
            onPressed: () {
              // TODO: Implement Search
            },
          ),
        ],
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
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
