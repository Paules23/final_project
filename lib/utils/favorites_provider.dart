import 'package:flutter/foundation.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/utils/preferences_util.dart';

class FavoritesProvider with ChangeNotifier {
  Set<int> _favorites = {};
  bool _isError = false;
  String _errorMessage = '';

  final Map<int, GameDetails> _gameDetailsCache = {};

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      List<String> favStringList = await PreferencesUtil.getFavoriteIds();
      _favorites = favStringList.map((id) => int.parse(id)).toSet();
      _isError = false;
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to load favorites: $e';
      if (kDebugMode) {
        print(_errorMessage);
      }
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(int gameId) async {
    if (_favorites.contains(gameId)) {
      _favorites.remove(gameId);
    } else {
      _favorites.add(gameId);
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(int gameId) async {
    try {
      _favorites.add(gameId);

      var details = await ApiService.fetchGameDetails(gameId);
      _gameDetailsCache[gameId] = details;

      await _saveFavorites();
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to add favorite: $e';

      if (kDebugMode) {
        print(_errorMessage);
      }
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
      await PreferencesUtil.setFavoriteIds(
          _favorites.map((id) => id.toString()).toList());
    } catch (e) {
      _isError = true;
      _errorMessage = 'Failed to save favorites: $e';

      if (kDebugMode) {
        print(_errorMessage);
      }
    }
  }

  bool isFavorite(int gameId) => _favorites.contains(gameId);
  Set<int> get favorites => _favorites;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  GameDetails? getGameDetails(int gameId) => _gameDetailsCache[gameId];
}
