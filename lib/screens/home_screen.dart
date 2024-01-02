import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/rounded_bar.dart';
import 'package:final_project/screens/tabs/games_tab.dart';
import 'package:final_project/screens/tabs/reviews_tab.dart';
import 'package:final_project/screens/tabs/lists_tab.dart';
import 'package:final_project/screens/search_screen.dart';
import 'package:final_project/screens/collection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<int> appIds = [
    1245620,
    367520,
    814380,
    620,
    774361,
    1868140,
    1086940,
    219150,
    1307580,
    413150,
    391540,
    239030,
    656350,
    1497440,
    368010,
    108600,
    739630,
    550,
  ];

  late Future<List<GameDetails>> _gamesDetails;
  late Future<List<String>> _reviews;
  late Future<List<String>> _lists;

  late TabController _tabController;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _gamesDetails = _fetchGameDetailsList();
    _reviews = _fetchReviews();
    _lists = _fetchLists();

    _tabController = TabController(length: 3, vsync: this);

    _screens = [
      buildHomeScreenContent(),
      const SearchScreen(),
      const CollectionScreen(),
    ];
  }

  Future<List<GameDetails>> _fetchGameDetailsList() async {
    List<GameDetails> gamesList = [];
    for (var appId in appIds) {
      try {
        GameDetails details = await ApiService.fetchGameDetails(appId);
        gamesList.add(details);
      } catch (e) {
        print('Failed to fetch game details for appId: $appId, Error: $e');
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

  Widget buildHomeScreenContent() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 24, // Set the font size to 24 (adjust as needed)
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          centerTitle: true, // Center the title horizontally
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 0),
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
            ReviewsTab(),
            ListsTab(_lists),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex != 0) {
              _tabController.index = 0;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Collection',
          ),
        ],
      ),
    );
  }
}
