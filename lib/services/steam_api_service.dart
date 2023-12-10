import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_project/models/game_model.dart';

class ApiService {
  static Future<List<dynamic>> fetchSteamGames() async {
    const apiKey = '37D9C03B00BDCD0B8CE03351101779AF';
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
    const apiKey = '37D9C03B00BDCD0B8CE03351101779AF';
    final gameInfoEndpoint =
        'https://store.steampowered.com/api/appdetails?appids=$gameId&key=$apiKey';

    final response = await http.get(Uri.parse(gameInfoEndpoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['$gameId']['success']) {
        final gameData = data['$gameId']['data'];

        return GameDetails(
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
        throw Exception('Failed to load game details');
      }
    } else {
      throw Exception('Failed to load game details');
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
