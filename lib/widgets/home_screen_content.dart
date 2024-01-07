import 'package:flutter/material.dart';
import 'package:final_project/widgets/rounded_bar.dart';
import 'package:final_project/screens/tabs/games_tab.dart';
import 'package:final_project/screens/tabs/reviews_tab.dart';
import 'package:final_project/screens/tabs/lists_tab.dart';

class HomeScreenContent extends StatelessWidget {
  final TabController tabController;

  const HomeScreenContent({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            shadows: [
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(150, 0, 0, 0))
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 26, 25, 25),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: RoundedBar(
            buttonTitles: const ['GAMES', 'REVIEWS', 'LISTS'],
            onPressed: (index) {
              tabController.animateTo(index);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          GamesTab(),
          ReviewsTab(),
          ListsTab(),
        ],
      ),
    );
  }
}
