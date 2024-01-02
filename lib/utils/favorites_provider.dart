import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/models/game_model.dart';

class FavoritesProvider with ChangeNotifier {
  Set<int> _favorites = {};
  bool _isError = false;
  String _errorMessage = '';

  Map<int, GameDetails> _gameDetailsCache = {};

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? favStringList = prefs.getStringList('favorites');
      if (favStringList != null) {
        _favorites = favStringList.map((id) => int.parse(id)).toSet();
      }
      _isError = false;
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to load favorites: $e';
      print(_errorMessage);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(int gameId) async {
    if (_favorites.contains(gameId)) {
      _favorites.remove(gameId);
    } else {
      _favorites.add(gameId);
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'favorites', _favorites.map((id) => id.toString()).toList());
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to save favorites: $e';
      print(_errorMessage);
    }
    notifyListeners();
  }

  Future<void> addFavorite(int gameId) async {
    try {
      _favorites.add(gameId);

      var details = await ApiService.fetchGameDetails(gameId);
      _gameDetailsCache[gameId] = details;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'favorites', _favorites.map((id) => id.toString()).toList());
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to add favorite: $e';
      print(_errorMessage);
    }
    notifyListeners();
  }

  void removeFavorite(int gameId) {
    _favorites.remove(gameId);
    _gameDetailsCache.remove(gameId);

    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'favorites', _favorites.map((id) => id.toString()).toList());
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to save favorites: $e';
      print(_errorMessage);
    }
  }

  bool isFavorite(int gameId) => _favorites.contains(gameId);
  Set<int> get favorites => _favorites;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  GameDetails? getGameDetails(int gameId) => _gameDetailsCache[gameId];
}
