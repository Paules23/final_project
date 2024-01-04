import 'package:flutter/material.dart';
import 'package:final_project/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = review.rating.floor();
    bool hasHalfStar = (review.rating - fullStars) >= 0.5;

    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              review.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) {
                        if (index < fullStars) {
                          return const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 240, 130, 28),
                          );
                        } else if (index == fullStars && hasHalfStar) {
                          return const Icon(
                            Icons.star_half,
                            color: Color.fromARGB(255, 240, 130, 28),
                          );
                        } else {
                          return const Icon(Icons.star_border,
                              color: Colors.grey);
                        }
                      },
                    ),
                  ),
                  Text(
                    review.reviewText,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
