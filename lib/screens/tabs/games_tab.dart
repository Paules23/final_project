import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/screens/game_screen.dart';

class GamesTab extends StatelessWidget {
  final Future<List<GameDetails>> gamesDetails;

  const GamesTab(this.gamesDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 150;
    crossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;

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
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GameItemWidget(snapshot.data![index]),
                ),
              );
            },
          );
        }
      },
    );
  }
}
