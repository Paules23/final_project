import 'dart:convert';
import 'package:http/http.dart' as http;

class SteamApiService {
  final String apiKey;

  SteamApiService(this.apiKey);

  Future<List<int>> getGameIdsOfFeaturedGames() async {
    final String url =
        'https://api.steampowered.com/ISteamApps/GetStoreFeatured/v1/?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<int> gameIds = [];
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('featured_win')) {
          final List<dynamic> featuredGames = data['featured_win'];
          for (var gameData in featuredGames) {
            final int gameId = gameData['id'] ?? 0;
            gameIds.add(gameId);
          }
        }
        return gameIds;
      } else {
        throw Exception('Error al cargar los juegos destacados');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
