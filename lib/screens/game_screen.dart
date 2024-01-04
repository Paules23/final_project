import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart';
import 'package:final_project/widgets/game_detail_card.dart';

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
        title: Text(gameDetails.title,
            style: const TextStyle(color: Colors.white)),
        actions: const [
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
                          ? const Color.fromARGB(255, 0, 0, 0)
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
                  GameDetailCard(
                      title: 'Title',
                      content: gameDetails.title,
                      isHighlight: true),
                  GameDetailCard(
                      title: 'Description', content: gameDetails.description),
                  GameDetailCard(
                      title: 'Developer', content: gameDetails.developer),
                  GameDetailCard(
                      title: 'Publisher', content: gameDetails.publisher),
                  GameDetailCard(title: 'Genre', content: gameDetails.genre),
                  GameDetailCard(
                      title: 'Price',
                      content: gameDetails.price,
                      isHighlight: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
