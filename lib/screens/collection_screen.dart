import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/utils/favorites_provider.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_collection_item.dart';
import 'package:final_project/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final Map<int, GameDetails> _gameDetails = {};

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
          if (kDebugMode) {
            print('Failed to load game details for ID $id: $e');
          }
        }
      }
    }
  }

  void _updateGameDetails() {
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
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 150;
    crossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Games Collection',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          int id = favoritesProvider.favorites.elementAt(index);
          GameDetails? details = _gameDetails[id];

          if (details != null) {
            return GameCollectionItem(gameDetails: details);
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}
