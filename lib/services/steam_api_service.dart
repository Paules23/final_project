import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/constants.dart';

class SteamApiService {
  Future<List<GameModel>> getLatestReleases() async {
    final String url = '${Constants.steamAPIBaseUrl}ISteamApps/GetAppList/v2/';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['games'];
        List<GameModel> games = jsonData.map((gameData) {
          return GameModel.fromJson(gameData);
        }).toList();
        return games;
      } else {
        throw Exception('Error al obtener los últimos juegos');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }

  Future<List<GameModel>> searchGames(String query) async {
    final String url =
        '${Constants.steamAPIBaseUrl}ISteamApps/GetAppList/v2/?query={término_de_búsqueda}';

    try {
      final response = await http.get(Uri.parse('$url?query=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['results'];
        List<GameModel> games = jsonData.map((gameData) {
          return GameModel.fromJson(gameData);
        }).toList();
        return games;
      } else {
        throw Exception('Error al buscar juegos');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
