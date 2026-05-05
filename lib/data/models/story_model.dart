class Story {
  final int id;
  final String title;
  final String? filePath;
  final String? fileName;
  final String? description;
  final int author;
  final String authorUsername;
  final String status;
  final String genre;
  final int viewsCount;
  final int likesCount;
  final double averageRating;
  final int ratingsCount;
  final int commentsCount;
  final String language;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Story({
    required this.id,
    required this.title,
    this.filePath,
    this.fileName,
    this.description,
    required this.author,
    required this.authorUsername,
    this.status = 'published',
    required this.genre,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.averageRating = 0.0,
    this.ratingsCount = 0,
    this.commentsCount = 0,
    required this.language,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      filePath: json['file_path'],
      fileName: json['file_name'],
      description: json['description'],
      author: json['author'] is int ? json['author'] : (json['author']?['id'] ?? 0),
      authorUsername: json['author_username'] ?? json['author']?['username'] ?? '',
      status: json['status'] ?? 'published',
      genre: json['genre'] ?? '',
      viewsCount: json['views_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      averageRating: (json['average_rating'] ?? 0.0).toDouble(),
      ratingsCount: json['ratings_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      language: json['language'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'file_path': filePath,
        'file_name': fileName,
        'description': description,
        'author': author,
        'author_username': authorUsername,
        'status': status,
        'genre': genre,
        'views_count': viewsCount,
        'likes_count': likesCount,
        'average_rating': averageRating,
        'ratings_count': ratingsCount,
        'comments_count': commentsCount,
        'language': language,
        'tags': tags,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  Story copyWith({
    int? id,
    String? title,
    String? filePath,
    String? fileName,
    String? description,
    int? author,
    String? authorUsername,
    String? status,
    String? genre,
    int? viewsCount,
    int? likesCount,
    double? averageRating,
    int? ratingsCount,
    int? commentsCount,
    String? language,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      description: description ?? this.description,
      author: author ?? this.author,
      authorUsername: authorUsername ?? this.authorUsername,
      status: status ?? this.status,
      genre: genre ?? this.genre,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      averageRating: averageRating ?? this.averageRating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      commentsCount: commentsCount ?? this.commentsCount,
      language: language ?? this.language,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isPdf =>
      fileName?.toLowerCase().endsWith('.pdf') == true ||
      filePath?.toLowerCase().contains('.pdf') == true;
}
