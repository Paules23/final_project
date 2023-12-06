import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SteamApiService steamApiService = SteamApiService();
  List<GameModel> games = [];

  @override
  void initState() {
    super.initState();
    _fetchLatestReleases();
  }

  Future<void> _fetchLatestReleases() async {
    try {
      List<GameModel> latestGames = await steamApiService.getLatestReleases();
      setState(() {
        games = latestGames;
      });
    } catch (e) {
      print('Error al obtener los últimos juegos: $e');
    }
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
