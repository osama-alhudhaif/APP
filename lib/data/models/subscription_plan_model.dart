class SubscriptionPlan {
  final String id;
  final String name;
  final String duration;
  final double price;
  final String? description;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    this.description,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'price': price,
      'description': description,
    };
  }
}
