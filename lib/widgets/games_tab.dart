import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/widgets/game_tile.dart';

class GamesTab extends StatelessWidget {
  final Future<List<GameDetails>> gamesDetails;

  const GamesTab(this.gamesDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameDetails>>(
      future: gamesDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No games available'));
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Display 3 items in each row
              crossAxisSpacing: 8.0, // Spacing between items horizontally
              mainAxisSpacing: 8.0, // Spacing between rows vertically
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GameItemWidget(snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
