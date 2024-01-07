import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/screens/game_screen.dart';
import 'package:final_project/widgets/loading_indicator.dart';

class GameSearchResults extends StatelessWidget {
  final Future<List<GameDetails>>? featuredGames;
  final bool isSearching;

  const GameSearchResults({
    Key? key,
    required this.featuredGames,
    required this.isSearching,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameDetails>>(
      future: featuredGames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            isSearching) {
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          List<GameDetails> games = snapshot.data ?? [];
          if (games.isEmpty && !isSearching) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(gameDetails: game),
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
    );
  }
}
