// File: /lib/screens/game_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart'; // Import the FavoritesProvider

class GameScreen extends StatelessWidget {
  final GameDetails gameDetails;

  const GameScreen({Key? key, required this.gameDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accessing the FavoritesProvider to check if the current game is favorite
    var isFavorite =
        Provider.of<FavoritesProvider>(context).isFavorite(gameDetails.id);

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
                  // ... [other widgets like rating stars and carousel]
                ],
              ),
            ),
            // ... [other widgets like action buttons]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Toggle the favorite status for the current game
          Provider.of<FavoritesProvider>(context, listen: false)
              .toggleFavorite(gameDetails.id);
        },
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        backgroundColor: isFavorite ? Colors.red : Colors.grey,
      ),
    );
  }
}
