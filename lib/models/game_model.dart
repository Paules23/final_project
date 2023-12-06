class GameModel {
  final String title;
  final String imageUrl;
  final String releaseDate;

  GameModel({
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'releaseDate': releaseDate,
    };
  }
}
