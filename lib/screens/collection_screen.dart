import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart'; // Ensure this is the correct path
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/services/steam_api_service.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late Future<List<GameDetails>> _favoriteGamesDetails;

  @override
  void initState() {
    super.initState();
    // Load favorite games details
    _favoriteGamesDetails = _loadFavoriteGames();
  }

  Future<List<GameDetails>> _loadFavoriteGames() async {
    // Get the list of favorite game IDs from the provider
    var favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    await favoritesProvider.loadFavorites(); // Ensure favorites are loaded

    List<GameDetails> details = [];
    if (favoritesProvider.isError) {
      // If there's an error loading favorites, throw an exception to be caught by FutureBuilder
      throw Exception(favoritesProvider.errorMessage);
    }

    for (String id in favoritesProvider.favorites) {
      try {
        var gameDetails = await ApiService.fetchGameDetails(int.parse(id));
        details.add(gameDetails);
      } catch (e) {
        // Handle errors or add logging here if needed
        print('Failed to fetch game details for ID $id: $e');
        // Optionally, continue loading other games even if one fails
      }
    }
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Games'),
      ),
      body: FutureBuilder<List<GameDetails>>(
        future: _favoriteGamesDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Use snapshot.error to display the error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite games added.'));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GameItemWidget(snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
