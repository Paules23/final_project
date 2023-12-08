import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/widgets/bottom_navigation_bar.dart';
import 'package:final_project/widgets/rounded_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
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
        print('Failed to fetch game details for appId: $appId');
      }
    }
    return gamesList;
  }

  Future<List<String>> _fetchReviews() async {
    // Implement fetching reviews logic
    return [];
  }

  Future<List<String>> _fetchLists() async {
    // Implement fetching lists logic
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              kToolbarHeight + 50), // Adjust the height as needed
          child: RoundedBar(
            buttonTitles: ['GAMES', 'REVIEWS', 'LISTS'],
            onPressed: (index) {
              _tabController.animateTo(index);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGamesTab(),
          _buildReviewsTab(),
          _buildListsTab(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildGamesTab() {
    return FutureBuilder<List<GameDetails>>(
      future: _gamesDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No games available'));
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GameItemWidget(snapshot.data![index]),
                  SizedBox(width: 16),
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildReviewsTab() {
    return FutureBuilder<List<String>>(
      future: _reviews,
      builder: (context, snapshot) {
        // Implement how to display reviews
        return Center(child: Text('Reviews Tab Content'));
      },
    );
  }

  Widget _buildListsTab() {
    return FutureBuilder<List<String>>(
      future: _lists,
      builder: (context, snapshot) {
        // Implement how to display lists
        return Center(child: Text('Lists Tab Content'));
      },
    );
  }
}
