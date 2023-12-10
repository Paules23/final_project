import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/widgets/game_tile.dart';

class GamesTab extends StatelessWidget {
  final Future<List<GameDetails>> gamesDetails;

  const GamesTab(this.gamesDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameDetails>>(
      future: gamesDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No games available'));
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GameItemWidget(snapshot.data![index]),
                  const SizedBox(width: 16),
                ],
              );
            },
          );
        }
      },
    );
  }
}
