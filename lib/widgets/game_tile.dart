import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';

class GameTile extends StatelessWidget {
  final GameModel game;

  const GameTile({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: game.imageUrl.isNotEmpty
          ? Image.network(
              game.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
          : Placeholder(
              fallbackWidth: 100,
              fallbackHeight: 100,
            ),
      title: Text(game.title),
      subtitle: Text('Release Date: ${game.releaseDate}'),
    );
  }
}
