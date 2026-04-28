import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'about_app_screen.dart';
import 'settings_screen.dart';
import 'lyrics_detail_screen.dart';
import '../providers/favorites_provider.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'All';
  String? _selectedFavoriteCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hindi Christian Songs'),
      ),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          FocusScope.of(context).unfocus();
        }
      },
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
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search lyrics...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty 
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
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
              // Category Chips
              SizedBox(
                height: 50,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('categories')
                      .orderBy('name')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<String> categories = ['♥ Favourites', 'All'];
                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      for (var doc in docs) {
                        final data = doc.data() as Map<String, dynamic>;
                        if (data['name'] != null) {
                          categories.add(data['name'] as String);
                        }
                      }
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedCategory = cat;
                                  _selectedFavoriteCategory = null;
                                });
                              }
                            },
                            selectedColor: theme.colorScheme.primary,
                            labelStyle: TextStyle(
                              color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Songs List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('songs')
                      .orderBy('title')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading songs.'));
                    }

                    var docs = snapshot.data?.docs ?? [];
                    final favoritesProvider = Provider.of<FavoritesProvider>(context);

                    // Apply client-side filter
                    if (_selectedCategory == '♥ Favourites') {
                      final favoriteDocs = docs.where((doc) => favoritesProvider.isFavorite(doc.id)).toList();
                      
                      if (favoriteDocs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border_rounded, size: 64, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('No favorites yet', style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 16)),
                            ],
                          ),
                        );
                      }

                      if (_selectedFavoriteCategory == null) {
                        // GROUP BY CATEGORY AND SHOW FOLDERS
                        final Map<String, int> categoryCounts = {};
                        for (var doc in favoriteDocs) {
                          final data = doc.data() as Map<String, dynamic>;
                          final cat = data['categoryName'] as String? ?? 'Unknown';
                          categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1;
                        }

                        final folderCategories = categoryCounts.keys.toList()..sort();

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: folderCategories.length,
                          itemBuilder: (context, index) {
                            final cat = folderCategories[index];
                            final count = categoryCounts[cat]!;
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.3), width: 1),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                leading: const Icon(Icons.folder_rounded, color: Colors.amber, size: 40),
                                title: Text(
                                  '$cat Favorites',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                subtitle: Text(
                                  '$count Songs added',
                                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                                ),
                                trailing: const Icon(Icons.chevron_right_rounded),
                                onTap: () {
                                  setState(() {
                                    _selectedFavoriteCategory = cat;
                                  });
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        // FILTER FAVORITES BY SPECIFIC CATEGORY
                        docs = favoriteDocs.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return data['categoryName'] == _selectedFavoriteCategory;
                        }).toList();
                      }
                    } else if (_selectedCategory != 'All') {
                      docs = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return data['categoryName'] == _selectedCategory;
                      }).toList();
                    }

                    // Apply search filter
                    if (_searchQuery.isNotEmpty) {
                      docs = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final title = (data['title'] ?? '').toString().toLowerCase();
                        return title.contains(_searchQuery);
                      }).toList();
                    }

                    if (docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isNotEmpty ? Icons.search_off_rounded : Icons.music_note_rounded,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isNotEmpty 
                                ? 'No results found for "$_searchQuery"' 
                                : 'No lyrics available yet',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    final showBackButton = _selectedCategory == '♥ Favourites' && _selectedFavoriteCategory != null;
                    final itemCount = docs.length + (showBackButton ? 1 : 0);

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        if (showBackButton && index == 0) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: TextButton.icon(
                                icon: const Icon(Icons.arrow_back, size: 18),
                                label: const Text('Back to Languages', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  setState(() {
                                    _selectedFavoriteCategory = null;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          );
                        }

                        final actualIndex = showBackButton ? index - 1 : index;
                        final data = docs[actualIndex].data() as Map<String, dynamic>;
                        final title = data['title'] ?? 'Unknown Title';
                        final categoryName = data['categoryName'];
                        final lyrics = data['lyrics'] ?? '';
                        final docId = docs[actualIndex].id;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: theme.colorScheme.outlineVariant.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: categoryName != null 
                              ? Text(
                                  categoryName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ) 
                              : null,
                            trailing: IconButton(
                              icon: Icon(
                                favoritesProvider.isFavorite(docId) 
                                  ? Icons.favorite_rounded 
                                  : Icons.favorite_border_rounded,
                                color: favoritesProvider.isFavorite(docId) 
                                  ? Colors.red 
                                  : null,
                              ),
                              onPressed: () {
                                favoritesProvider.toggleFavorite(docId);
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LyricsDetailScreen(
                                    docId: docId,
                                    title: title,
                                    lyrics: lyrics,
                                    categoryName: categoryName,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
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
