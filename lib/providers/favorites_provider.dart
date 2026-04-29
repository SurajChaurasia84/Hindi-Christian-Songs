import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<String> _favoriteIds = {};
  bool _isLoaded = false;
  static const String _key = 'favorite_songs';

  Set<String> get favoriteIds => _favoriteIds;
  bool get isLoaded => _isLoaded;

  FavoritesProvider() {
    _loadFavorites();
  }

  bool isFavorite(String docId) {
    return _favoriteIds.contains(docId);
  }

  void toggleFavorite(String docId) {
    if (_favoriteIds.contains(docId)) {
      _favoriteIds.remove(docId);
    } else {
      _favoriteIds.add(docId);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedFavorites = prefs.getStringList(_key);
    if (savedFavorites != null) {
      _favoriteIds = savedFavorites.toSet();
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _favoriteIds.toList());
  }
}
