// File: /lib/providers/favorites_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  Set<String> _favorites = {};
  bool _isError = false;
  String _errorMessage = '';

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _favorites = prefs.getStringList('favorites')?.toSet() ?? {};
      _isError = false;
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to load favorites: $e';

      print(_errorMessage);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String gameId) async {
    if (_favorites.contains(gameId)) {
      _favorites.remove(gameId);
    } else {
      _favorites.add(gameId);
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favorites.toList());
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to save favorites: $e';

      print(_errorMessage);
    }
    notifyListeners();
  }

  bool isFavorite(String gameId) => _favorites.contains(gameId);

  Set<String> get favorites => _favorites;

  bool get isError => _isError;

  String get errorMessage => _errorMessage;
}
