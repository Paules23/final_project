import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  final Future<List<String>> reviews;

  const ReviewsTab(this.reviews, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: reviews,
      builder: (context, snapshot) {
        return const Center(child: Text('Reviews Tab Content'));
      },
    );
  }
}
