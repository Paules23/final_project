import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/widgets/bottom_navigation_bar.dart';
import 'package:final_project/widgets/rounded_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String steamApiKey = '37D9C03B00BDCD0B8CE03351101779AF';
  late SteamApiService steamApiService;
  List<GameModel> games = [];

  @override
  void initState() {
    super.initState();
    steamApiService = SteamApiService(steamApiKey);
    _fetchGamesAndImages();
  }

  Future<void> _fetchGamesAndImages() async {
    try {
      List<int> gameIds = await steamApiService.getGameIdsOfFeaturedGames();
      List<GameModel> gamesWithImages = await _getGamesWithImages(gameIds);
      setState(() {
        games = gamesWithImages;
      });
    } catch (e) {
      print('Error al obtener juegos e imágenes: $e');
    }
  }

  Future<List<GameModel>> _getGamesWithImages(List<int> gameIds) async {
    List<GameModel> gamesList = [];

    for (int gameId in gameIds) {
      final String imageUrl =
          'https://cdn.cloudflare.steamstatic.com/steam/apps/$gameId/capsule_184x69.jpg';
      final GameModel game = GameModel(
        title: 'Nombre del juego',
        imageUrl: imageUrl,
        releaseDate: 'Fecha de lanzamiento',
      );
      gamesList.add(game);
    }

    return gamesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedBar(
            buttonTitles: ['GAMES', 'REVIEWS', 'LISTS'],
            onPressed: (index) {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Latest Releases',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GameTile(game: games[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
