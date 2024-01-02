// reviews_tab.dart
import 'package:flutter/material.dart';
import 'package:final_project/models/review_model.dart';
import 'package:final_project/widgets/review_card.dart';
import 'package:final_project/services/steam_api_service.dart';

class ReviewsTab extends StatefulWidget {
  const ReviewsTab({Key? key}) : super(key: key);

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  late Future<List<Review>> reviewsFuture;

  @override
  void initState() {
    super.initState();
    reviewsFuture = fetchReviewsWithImages();
  }

  Future<List<Review>> fetchReviewsWithImages() async {
    List<Review> reviews = [
      Review(
        gameName: 'Lies of P', // Example game name
        username: 'GameLover65',
        rating: 3.5,
        reviewText:
            '"Lies of P" is expected to deliver a unique spin on the familiar action-RPG genre with its dark, Pinocchio-inspired world. The game promises intricate, challenging combat, a hauntingly beautiful aesthetic, and a deep, twisting narrative that reimagines the classic tale. It aims to captivate players with its blend of grim storytelling and compelling gameplay, offering a fresh and intriguing experience.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Powerwash Simulator', // Example game name
        username: 'Paules23',
        rating: 4.5,
        reviewText:
            '"PowerWash Simulator" offers a surprisingly satisfying and therapeutic cleaning experience, focusing on the simple pleasure of power washing various dirty objects to their pristine conditions. With its meditative gameplay, attention to detail, and a variety of scenarios, the game provides a strangely addictive and relaxing escape. Its praised for its cathartic effect and the instant gratification of turning grimy chaos into organized cleanliness, appealing to those looking for a calming, yet engaging gaming experience.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'SuperFlight', // Example game name
        username: 'Rotyer15',
        rating: 2,
        reviewText:
            '"Superflight" is celebrated for its simple yet exhilarating gameplay, offering an addictive experience as players glide through colorful, procedurally generated landscapes. Its minimalist design and easy-to-learn controls make for an accessible yet challenging game, where the thrill of beating high scores by skillfully navigating tight spaces is endlessly satisfying. With its low price and engaging mechanics, Superflight provides a pure, exhilarating sense of freedom and speed, perfect for quick play sessions.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Dave the Diver', // Example game name
        username: 'Chi3vitee',
        rating: 4,
        reviewText:
            '"Dave the Diver" combines exploration, adventure, and strategy as players dive into the mysterious depths of the ocean. Its recognized for its unique blend of diving simulation and sushi restaurant management, offering both tranquil underwater experiences and bustling business challenges. The games colorful art, diverse marine life, and engaging gameplay loop provide an intriguing and relaxing escape. With its innovative concept and charming narrative, "Dave the Diver" offers a refreshing take on the simulation genre.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Undertale', // Example game name
        username: 'ShadowBlade47',
        rating: 5,
        reviewText:
            '"Undertale" stands out for its unique blend of classic RPG elements with a deeply engaging story that changes based on player choices. Known for its clever writing, memorable characters, and emotional depth, the game challenges traditional video game morality and storytelling. Its retro-style graphics and innovative soundtrack complement the games thematic richness and humor. "Undertale" offers a profound, sometimes humorous, often touching experience that has left a lasting impact on players and the gaming community.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Hollow Knight', // Example game name
        username: 'StarGazer99',
        rating: 5,
        reviewText:
            '"Hollow Knight" is widely acclaimed for its beautifully hand-drawn art, intricate and challenging gameplay, and expansive, atmospheric world. The game masterfully combines action, exploration, and storytelling, setting players on an adventure through a hauntingly desolate kingdom teeming with bizarre creatures and forgotten lore. Its precise combat, complex character progression, and the sheer depth of its cryptic world offer a compelling experience that keeps players enthralled for hours, making it a standout title in the Metroidvania genre.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Serial Cleaner', // Example game name
        username: 'FrostFireX',
        rating: 1,
        reviewText:
            '"Serial Cleaner" is noted for its unique, darkly humorous take on the stealth action genre, where players are tasked with cleaning up crime scenes without getting caught. Set in the 1970s, the game pairs its morbid premise with a vibrant, retro aesthetic and a funky soundtrack. It challenges players with increasingly complex levels, requiring strategic thinking and quick reflexes. Despite its grim subject, "Serial Cleaner" offers a quirky, engaging experience that combines macabre comedy with satisfying stealth gameplay.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
      Review(
        gameName: 'Superhot', // Example game name
        username: 'ThunderSprint23',
        rating: 3.5,
        reviewText:
            '"Superhot" is an innovative first-person shooter that distinguishes itself with its unique time-manipulation mechanic. Time only moves when the player moves, creating intense, strategic gameplay moments. The games minimalist, stark visuals and immersive sound design contribute to its distinctive style. Its celebrated for its clever level design, challenging puzzles, and the feeling of being a cinematic action hero. "Superhot" offers a fresh and captivating take on the FPS genre, providing players with a sense of control and mastery over time that few other games can match.',
        imageUrl: '', // Initially empty, will be filled by the API
      ),
    ];

    for (var review in reviews) {
      try {
        var gameDetails =
            await ApiService.getGameDetailsByName(review.gameName);
        if (gameDetails != null) {
          review.imageUrl = gameDetails.imageUrl; // Update imageUrl
        }
      } catch (e) {
        print("Error fetching game details: $e");
      }
    }
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No reviews available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ReviewCard(review: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
