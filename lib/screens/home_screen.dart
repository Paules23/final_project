import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/bottom_navigation_bar.dart';
import 'package:final_project/widgets/rounded_bar.dart';
import 'package:final_project/widgets/games_tab.dart';
import 'package:final_project/widgets/reviews_tab.dart';
import 'package:final_project/widgets/lists_tab.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<int> appIds = [
    1245620,
    367520,
  ];

  late Future<List<GameDetails>> _gamesDetails;
  late Future<List<String>> _reviews;
  late Future<List<String>> _lists;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _gamesDetails = _fetchGameDetailsList();
    _reviews = _fetchReviews();
    _lists = _fetchLists();

    _tabController = TabController(length: 3, vsync: this);
  }

  Future<List<GameDetails>> _fetchGameDetailsList() async {
    List<GameDetails> gamesList = [];
    for (var appId in appIds) {
      try {
        GameDetails details = await ApiService.fetchGameDetails(appId);
        gamesList.add(details);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to fetch game details for appId: $appId');
        }
      }
    }
    return gamesList;
  }

  Future<List<String>> _fetchReviews() async {
    return [];
  }

  Future<List<String>> _fetchLists() async {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 50),
            child: RoundedBar(
              buttonTitles: const ['GAMES', 'REVIEWS', 'LISTS'],
              onPressed: (index) {
                _tabController.animateTo(index);
              },
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GamesTab(_gamesDetails),
            ReviewsTab(_reviews),
            ListsTab(_lists),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}
