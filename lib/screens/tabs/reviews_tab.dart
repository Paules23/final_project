import 'package:flutter/material.dart';
import 'package:final_project/models/review_model.dart';
import 'package:final_project/widgets/review_card.dart';
import 'package:final_project/services/steam_api_service.dart';
import 'package:final_project/widgets/loading_indicator.dart';

class ReviewsTab extends StatefulWidget {
  const ReviewsTab({Key? key}) : super(key: key);

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Review>> reviewsFuture;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    reviewsFuture = fetchReviewsWithImages();
  }

  Future<List<Review>> fetchReviewsWithImages() async {
    List<Review> reviews = [
      Review(
        gameName: 'Lies of P',
        username: 'GameLover65',
        rating: 3.5,
        reviewText:
            '"Lies of P" is expected to deliver a unique spin on the familiar action-RPG genre with its dark, Pinocchio-inspired world. The game promises intricate, challenging combat, a hauntingly beautiful aesthetic, and a deep, twisting narrative that reimagines the classic tale. It aims to captivate players with its blend of grim storytelling and compelling gameplay, offering a fresh and intriguing experience.',
        imageUrl: '',
      ),
      Review(
        gameName: 'Powerwash Simulator',
        username: 'Paules23',
        rating: 4.5,
        reviewText:
            '"PowerWash Simulator" offers a surprisingly satisfying and therapeutic cleaning experience, focusing on the simple pleasure of power washing various dirty objects to their pristine conditions. With its meditative gameplay, attention to detail, and a variety of scenarios, the game provides a strangely addictive and relaxing escape. Its praised for its cathartic effect and the instant gratification of turning grimy chaos into organized cleanliness, appealing to those looking for a calming, yet engaging gaming experience.',
        imageUrl: '',
      ),
      Review(
        gameName: 'Dave the Diver',
        username: 'Chi3vitee',
        rating: 4,
        reviewText:
            '"Dave the Diver" combines exploration, adventure, and strategy as players dive into the mysterious depths of the ocean. Its recognized for its unique blend of diving simulation and sushi restaurant management, offering both tranquil underwater experiences and bustling business challenges. The games colorful art, diverse marine life, and engaging gameplay loop provide an intriguing and relaxing escape. With its innovative concept and charming narrative, "Dave the Diver" offers a refreshing take on the simulation genre.',
        imageUrl: '',
      ),
      Review(
        gameName: 'Hollow Knight',
        username: 'StarGazer99',
        rating: 5,
        reviewText:
            '"Hollow Knight" is widely acclaimed for its beautifully hand-drawn art, intricate and challenging gameplay, and expansive, atmospheric world. The game masterfully combines action, exploration, and storytelling, setting players on an adventure through a hauntingly desolate kingdom teeming with bizarre creatures and forgotten lore. Its precise combat, complex character progression, and the sheer depth of its cryptic world offer a compelling experience that keeps players enthralled for hours, making it a standout title in the Metroidvania genre.',
        imageUrl: '',
      ),
      Review(
        gameName: 'Superhot',
        username: 'ThunderSprint23',
        rating: 3.5,
        reviewText:
            '"Superhot" is an innovative first-person shooter that distinguishes itself with its unique time-manipulation mechanic. Time only moves when the player moves, creating intense, strategic gameplay moments. The games minimalist, stark visuals and immersive sound design contribute to its distinctive style. Its celebrated for its clever level design, challenging puzzles, and the feeling of being a cinematic action hero. "Superhot" offers a fresh and captivating take on the FPS genre, providing players with a sense of control and mastery over time that few other games can match.',
        imageUrl: '',
      ),
    ];

    for (var review in reviews) {
      try {
        var gameDetails =
            await ApiService.getGameDetailsByName(review.gameName);
        if (gameDetails != null) {
          review.imageUrl = gameDetails.imageUrl;
        }
      } catch (e) {
        // ignore: avoid_print
        print("Error fetching game details: $e");
      }
    }
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Review>>(
      future: reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
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
