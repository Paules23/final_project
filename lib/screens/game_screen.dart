import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart';

class GameScreen extends StatelessWidget {
  final GameDetails gameDetails;

  const GameScreen({Key? key, required this.gameDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFavorite =
        Provider.of<FavoritesProvider>(context).isFavorite(gameDetails.id);
    double imageHeight = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(gameDetails.title, style: TextStyle(color: Colors.white)),
        actions: [
          Icon(Icons.gamepad, color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  gameDetails.imageUrl,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: imageHeight - 70,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 244, 162, 54),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                    onPressed: () {
                      Provider.of<FavoritesProvider>(context, listen: false)
                          .toggleFavorite(gameDetails.id);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gameDetailCard('Title', gameDetails.title, isHighlight: true),
                  gameDetailCard('Description', gameDetails.description),
                  gameDetailCard('Developer', gameDetails.developer),
                  gameDetailCard('Publisher', gameDetails.publisher),
                  gameDetailCard('Genre', gameDetails.genre),
                  gameDetailCard('Price', gameDetails.price, isHighlight: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameDetailCard(String title, String content,
      {bool isHighlight = false}) {
    return Card(
      color:
          isHighlight ? const Color.fromARGB(255, 244, 155, 54) : Colors.black,
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: isHighlight
                    ? Colors.white
                    : const Color.fromARGB(255, 244, 155, 54),
                fontWeight: FontWeight.bold)),
        subtitle: Text(content, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
