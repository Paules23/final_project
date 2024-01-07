import 'package:flutter/material.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/widgets/search_input_field.dart';
import 'package:final_project/widgets/game_search_results.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<GameDetails>>? _featuredGames;
  bool _isSearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _featuredGames = ApiService.fetchFeaturedGames();
  }

  void _searchGame(String gameName) async {
    if (gameName.isEmpty) {
      setState(() {
        _featuredGames = ApiService.fetchFeaturedGames();
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final details = await ApiService.getGameDetailsByName(gameName);
      setState(() {
        _featuredGames = Future.value(details == null ? [] : [details]);
        _isSearching = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error searching for game: $e");
      }
      setState(() {
        _featuredGames = Future.value([]);
        _isSearching = false;
      });
    }
  }

  void _onSearchChanged(String gameName) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchGame(gameName);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Game',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchInputField(
            onSearchChanged: (value) {
              setState(() {});
              _onSearchChanged(value);
            },
          ),
          Expanded(
            child: GameSearchResults(
              featuredGames: _featuredGames,
              isSearching: _isSearching,
            ),
          ),
        ],
      ),
    );
  }
}
