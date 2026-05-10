class Author {
  final int id;
  final String username;
  final String? bio;
  final String? profileImage;
  final int followersCount;
  final int storiesCount;
  final bool isFollowing;

  Author({
    required this.id,
    required this.username,
    this.bio,
    this.profileImage,
    this.followersCount = 0,
    this.storiesCount = 0,
    this.isFollowing = false,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      bio: json['bio'],
      profileImage: json['profile_image'],
      followersCount: json['followers_count'] ?? 0,
      storiesCount: json['stories_count'] ?? 0,
      isFollowing: json['is_following'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
      'profile_image': profileImage,
      'followers_count': followersCount,
      'stories_count': storiesCount,
      'is_following': isFollowing,
    };
  }

  Author copyWith({
    int? id,
    String? username,
    String? bio,
    String? profileImage,
    int? followersCount,
    int? storiesCount,
    bool? isFollowing,
  }) {
    return Author(
      id: id ?? this.id,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      followersCount: followersCount ?? this.followersCount,
      storiesCount: storiesCount ?? this.storiesCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
