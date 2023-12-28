// search_screen.dart
import 'package:flutter/material.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/models/game_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<GameDetails>>? _featuredGames;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch featured games when the widget is first created
    _featuredGames = ApiService.fetchFeaturedGames();
  }

  void _searchGame(String gameName) async {
    try {
      final details = await ApiService.getGameDetailsByName(gameName);
      setState(() {
        _featuredGames = Future.value(details == null ? [] : [details]);
      });
    } catch (e) {
      // Handle error
      print("Error searching for game: $e");
      setState(() {
        _featuredGames = Future.value([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Game'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter game name',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              if (_searchQuery.isNotEmpty) {
                _searchGame(_searchQuery);
              } else {
                // If the search query is empty, fetch the featured games again
                _featuredGames = ApiService.fetchFeaturedGames();
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<GameDetails>>(
              future: _featuredGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  List<GameDetails> games = snapshot.data ?? [];
                  if (games.isEmpty) {
                    return const Center(child: Text("No games found."));
                  }
                  return ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      GameDetails game = games[index];
                      return ListTile(
                        title: Text(game.title),
                        leading: Image.network(game.imageUrl),
                        onTap: () {
                          // Navigate to a detailed screen for the game
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Start searching..."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
