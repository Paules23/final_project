import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/screens/game_screen.dart';

class GameItemWidget extends StatelessWidget {
  final GameDetails gameDetails;

  const GameItemWidget(this.gameDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(gameDetails: gameDetails),
          ),
        );
      },
      child: Image.network(
        gameDetails.imageUrl,
        width: double.infinity,
        height: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.width /
                200), // Adjust the height ratio based on your design
        fit: BoxFit.cover,
      ),
    );
  }
}
