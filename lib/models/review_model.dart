class Review {
  final String gameName;
  final String username;
  final double rating;
  final String reviewText;
  String imageUrl;

  Review({
    required this.gameName,
    required this.username,
    required this.rating,
    required this.reviewText,
    required this.imageUrl,
  });
}
