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
    final double appBarHeight = AppBar().preferredSize.height;
    final double iconBoxSize = 48.0; // Example size, you can adjust as needed

    return Scaffold(
      appBar: AppBar(
        title: Text(gameDetails.title),
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
                  height: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.width / 200),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.366 - appBarHeight,
                  right: 9.5,
                  child: Container(
                    width: iconBoxSize,
                    height: iconBoxSize,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 130, 28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? Color.fromARGB(255, 0, 0, 0)
                            : Colors.white,
                      ),
                      onPressed: () {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .toggleFavorite(gameDetails.id);
                      },
                    ),
                  ),
                ),
              ],
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
    );
  }
}
