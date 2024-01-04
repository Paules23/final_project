import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_project/models/game_model.dart';

class ApiService {
  static const String apiKey = '37D9C03B00BDCD0B8CE03351101779AF';

  static Future<List<dynamic>> fetchSteamGames() async {
    const steamApiEndpoint =
        'https://api.steampowered.com/ISteamApps/GetAppList/v2/?key=$apiKey';

    final response = await http.get(Uri.parse(steamApiEndpoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['applist']['apps'];
    } else {
      throw Exception('Failed to load game list');
    }
  }

  static Future<GameDetails> fetchGameDetails(int gameId) async {
    final gameInfoEndpoint =
        'https://store.steampowered.com/api/appdetails?appids=${gameId.toString()}&key=$apiKey';

    final response = await http.get(Uri.parse(gameInfoEndpoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['$gameId']['success']) {
        final gameData = data['$gameId']['data'];
        int steamAppId = gameData['steam_appid'] ?? -1;

        return GameDetails(
          id: steamAppId,
          title: gameData['name'] ?? 'Title not available',
          description:
              gameData['short_description'] ?? 'Description not available',
          price: gameData['price_overview']['final_formatted'] ??
              'Price not available',
          genre: _getGenres(gameData['genres']),
          developer:
              gameData['developers']?.join(', ') ?? 'Developer not available',
          publisher:
              gameData['publishers']?.join(', ') ?? 'Publisher not available',
          imageUrl: gameData['header_image'] ?? '',
        );
      } else {
        throw Exception('Failed to load game details for game ID $gameId');
      }
    } else {
      throw Exception(
          'Failed to load game details for game ID $gameId with status code ${response.statusCode}');
    }
  }

  static Future<GameDetails?> getGameDetailsByName(String gameName) async {
    try {
      List<dynamic> allGames = await fetchSteamGames();

      var foundGame = allGames.firstWhere(
        (game) =>
            game['name'].toString().toLowerCase() == gameName.toLowerCase(),
        orElse: () => null,
      );

      if (foundGame != null) {
        return await fetchGameDetails(foundGame['appid']);
      }
      return null;
    } catch (e) {
      throw Exception('Error getting game details by name: $e');
    }
  }

  static Future<List<GameDetails>> fetchFeaturedGames() async {
    const featuredGamesUrl = 'https://store.steampowered.com/api/featured/';
    final response = await http.get(Uri.parse(featuredGamesUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<GameDetails> featuredGames = [];
      for (var item in jsonResponse['featured_win']) {
        int steamAppId = item['steam_appid'] as int? ?? -1;
        final gameDetails = GameDetails(
          id: steamAppId,
          title: item['name'] ?? 'Available soon',
          description: item['short_description'] ?? 'Available soon',
          price: item['price'] ?? 'Available soon',
          genre: item['genre'] ?? 'Available soon',
          developer: item['developer'] ?? 'Available soon',
          publisher: item['publisher'] ?? 'Available soon',
          imageUrl: item['header_image'] ?? '',
        );
        featuredGames.add(gameDetails);
      }
      return featuredGames;
    } else {
      throw Exception(
          'Failed to load featured games with status code ${response.statusCode}');
    }
  }

  static String _getGenres(List<dynamic>? genres) {
    if (genres != null && genres.isNotEmpty) {
      final genreList = genres.map((genre) => genre['description']).toList();
      return genreList.join(', ');
    }
    return '';
  }
}
