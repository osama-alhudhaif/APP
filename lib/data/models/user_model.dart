class User {
  final int id;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? country;
  final String role;
  final String? gender;
  final String? dateOfBirth;
  final bool darkModeEnabled;
  final bool hasActiveSubscription;
  final Map<String, dynamic>? subscriptionInfo;
  final int followersCount;
  final int followingCount;
  final String? dateJoined;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.role = 'reader',
    this.gender,
    this.dateOfBirth,
    this.darkModeEnabled = false,
    this.hasActiveSubscription = false,
    this.subscriptionInfo,
    this.followersCount = 0,
    this.followingCount = 0,
    this.dateJoined,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      country: json['country'],
      role: json['role'] ?? 'reader',
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      darkModeEnabled: json['dark_mode_enabled'] ?? false,
      hasActiveSubscription: json['has_active_subscription'] ?? false,
      subscriptionInfo: json['subscription_info'] is Map
          ? Map<String, dynamic>.from(json['subscription_info'])
          : null,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      dateJoined: json['date_joined'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'country': country,
        'role': role,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'dark_mode_enabled': darkModeEnabled,
        'has_active_subscription': hasActiveSubscription,
        'followers_count': followersCount,
        'following_count': followingCount,
        'date_joined': dateJoined,
      };

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    String? country,
    String? role,
    String? gender,
    String? dateOfBirth,
    bool? darkModeEnabled,
    bool? hasActiveSubscription,
    Map<String, dynamic>? subscriptionInfo,
    int? followersCount,
    int? followingCount,
    String? dateJoined,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      hasActiveSubscription: hasActiveSubscription ?? this.hasActiveSubscription,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      dateJoined: dateJoined ?? this.dateJoined,
      token: token ?? this.token,
    );
  }

  bool get isSubscribed => hasActiveSubscription;
  bool get isWriter => role == 'writer' || role == 'both';
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
