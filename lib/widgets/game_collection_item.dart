import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/screens/game_screen.dart';
import 'package:final_project/widgets/game_tile.dart';

class GameCollectionItem extends StatelessWidget {
  final GameDetails gameDetails;

  const GameCollectionItem({Key? key, required this.gameDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(gameDetails: gameDetails),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GameItemWidget(gameDetails),
      ),
    );
  }
}
