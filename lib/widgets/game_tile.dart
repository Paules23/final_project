import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';

class GameTile extends StatelessWidget {
  final GameModel game;

  const GameTile({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                game.imageUrl, // URL de la imagen del juego obtenida de la API
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              game.title, // Título del juego obtenido de la API
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Release Date: ${game.releaseDate}', // Fecha de lanzamiento del juego obtenida de la API
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
