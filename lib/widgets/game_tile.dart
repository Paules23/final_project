import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:flutter/foundation.dart';

class GameItemWidget extends StatelessWidget {
  final GameDetails gameDetails;

  const GameItemWidget(this.gameDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print('Image tapped for ${gameDetails.title}');
            }
          },
          child: Image.network(
            gameDetails.imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        /* Text(
          'Title: ${gameDetails.title}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text('Developer: ${gameDetails.developer}'),
        Text('Price: ${gameDetails.price}'),
        Text('Genre: ${gameDetails.genre}'),*/
      ],
    );
  }
}
