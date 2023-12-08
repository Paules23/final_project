import 'package:flutter/material.dart';
import 'package:final_project/models/game_model.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/game_tile.dart';
import 'package:final_project/widgets/bottom_navigation_bar.dart';
import 'package:final_project/widgets/rounded_bar.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> appIds = [
    1245620,
    367520,
  ];

  late Future<List<GameDetails>> _gamesDetails;

  @override
  void initState() {
    super.initState();
    _gamesDetails = _fetchGameDetailsList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedBar(
            buttonTitles: ['GAMES', 'REVIEWS', 'LISTS'],
            onPressed: (index) {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Latest Releases',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GameDetails>>(
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildGameItem(snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildGameItem(GameDetails gameDetails) {
    return GestureDetector(
      onTap: () {
        // Perform actions when the image is tapped
        // For example, navigate to a new screen or perform some action
        // Here, we'll just print a message to the console
        if (kDebugMode) {
          print('Image tapped for ${gameDetails.title}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              gameDetails.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
