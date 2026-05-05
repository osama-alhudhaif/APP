class Comment {
  final int id;
  final int story;
  final int user;
  final String userUsername;
  final String content;
  final bool isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.story,
    required this.user,
    required this.userUsername,
    required this.content,
    this.isApproved = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      story: json['story'] ?? 0,
      user: json['user'] ?? 0,
      userUsername: json['user_username'] ?? json['author_name'] ?? '',
      content: json['content'] ?? '',
      isApproved: json['is_approved'] ?? true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'story': story,
        'user': user,
        'user_username': userUsername,
        'content': content,
        'is_approved': isApproved,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
