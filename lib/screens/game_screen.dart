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

    return Scaffold(
      appBar: AppBar(
        title: Text(gameDetails.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              gameDetails.imageUrl,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameDetails.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${gameDetails.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Developer: ${gameDetails.developer}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Publisher: ${gameDetails.publisher}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Genre: ${gameDetails.genre}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: ${gameDetails.price}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<FavoritesProvider>(context, listen: false)
              .toggleFavorite(gameDetails.id);
        },
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        backgroundColor:
            isFavorite ? const Color.fromARGB(255, 244, 155, 54) : Colors.grey,
      ),
    );
  }
}
