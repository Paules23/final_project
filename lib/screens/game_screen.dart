import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';

class GameScreen extends StatelessWidget {
  final GameDetails gameDetails;

  const GameScreen({Key? key, required this.gameDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameDetails.title), // Game title
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              gameDetails.imageUrl, // Game cover image
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameDetails.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Rating stars would go here
                  // You can use a package like flutter_rating_bar to create interactive stars
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(gameDetails.description),
                  ),
                  // Here, implement the carousel for screenshots using a horizontal ListView.builder
                ],
              ),
            ),
            // Action buttons would go here
          ],
        ),
      ),
    );
  }
}
