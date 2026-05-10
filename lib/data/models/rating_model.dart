class Rating {
  final int id;
  final int score;
  final DateTime createdAt;
  final int authorId;
  final String authorName;

  Rating({
    required this.id,
    required this.score,
    required this.createdAt,
    required this.authorId,
    required this.authorName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      score: json['score'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      authorId: json['author_id'] ?? json['user']?['id'] ?? 0,
      authorName: json['author_name'] ?? json['user']?['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'created_at': createdAt.toIso8601String(),
      'author_id': authorId,
      'author_name': authorName,
    };
  }
}
