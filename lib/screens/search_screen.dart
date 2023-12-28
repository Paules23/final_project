import 'package:flutter/material.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/screens/game_screen.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<GameDetails>>? _featuredGames;
  String _searchQuery = '';
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Fetch featured games when the widget is first created
    _featuredGames = ApiService.fetchFeaturedGames();
  }

  void _searchGame(String gameName) async {
    if (gameName.isEmpty) {
      setState(() {
        _featuredGames = ApiService.fetchFeaturedGames();
        _isSearching = false; // Set to false when not searching
      });
      return;
    }

    setState(() {
      _isSearching = true; // Set to true when search begins
    });

    try {
      final details = await ApiService.getGameDetailsByName(gameName);
      setState(() {
        _featuredGames = Future.value(details == null ? [] : [details]);
        _isSearching = false; // Set to false when search ends
      });
    } catch (e) {
      // Handle error
      print("Error searching for game: $e");
      setState(() {
        _featuredGames = Future.value([]);
        _isSearching = false; // Set to false on error
      });
    }
  }

  void _onSearchChanged(String gameName) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchGame(gameName);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
              _onSearchChanged(value);
            },
          ),
          Expanded(
            child: FutureBuilder<List<GameDetails>>(
              future: _featuredGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    _isSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  List<GameDetails> games = snapshot.data ?? [];
                  if (games.isEmpty && !_isSearching) {
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
                          // Navigate to the detailed screen for the game
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(gameDetails: game),
                            ),
                          );
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
