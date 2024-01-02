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
            'HOME',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(150, 0, 0, 0),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 26, 25, 25),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex != 0) {
                _tabController.index = 0;
              }
            });
          },
          backgroundColor: Color.fromARGB(255, 31, 30, 30),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              label: 'Collection',
            ),
          ],
          elevation: 20,
        ),
      ),
    );
  }
}
