import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/widgets/loading_indicator.dart';

class GamesTab extends StatefulWidget {
  const GamesTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GamesTabState createState() => _GamesTabState();
}

class _GamesTabState extends State<GamesTab> {
  final List<GameDetails> _games = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreGames();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreGames();
      }
    });
  }

  void _loadMoreGames() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    List<GameDetails> moreGames = await ApiService.fetchRandomGames(40);
    setState(() {
      _games.addAll(moreGames);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 150;
    crossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;

    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemCount: _isLoading ? _games.length + 1 : _games.length,
        itemBuilder: (context, index) {
          if (_isLoading && index == _games.length) {
            return const LoadingIndicator();
          }
          return InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GameItemWidget(_games[index]),
            ),
          );
        },
        controller: _scrollController,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
