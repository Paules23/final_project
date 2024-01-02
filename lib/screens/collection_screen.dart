import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/screens/game_screen.dart';
import 'package:final_project/widgets/game_tile.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  Map<int, GameDetails> _gameDetails = {};

  @override
  void initState() {
    super.initState();

    Provider.of<FavoritesProvider>(context, listen: false)
        .addListener(_updateGameDetails);
    _loadInitialFavoriteGames();
  }

  void _loadInitialFavoriteGames() async {
    var favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    for (int id in favoritesProvider.favorites) {
      if (!_gameDetails.containsKey(id)) {
        try {
          var details = await ApiService.fetchGameDetails(id);
          if (mounted) {
            setState(() {
              _gameDetails[id] = details;
            });
          }
        } catch (e) {
          print('Failed to load game details for ID $id: $e');
        }
      }
    }
  }

  void _updateGameDetails() {
    var favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);

    _loadInitialFavoriteGames();
  }

  @override
  void dispose() {
    Provider.of<FavoritesProvider>(context, listen: false)
        .removeListener(_updateGameDetails);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Games Collection'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          int id = favoritesProvider.favorites.elementAt(index);
          GameDetails? details = _gameDetails[id];

          if (details != null) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(gameDetails: details),
                  ),
                );
              },
              child: GameItemWidget(details),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
