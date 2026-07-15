class UserDiscoveryModel {
  final String userId;
  final String name;
  final String avatarUrl;
  UserDiscoveryModel({
    required this.userId,
    required this.name,
    required this.avatarUrl,
  });
  factory UserDiscoveryModel.fromJson(Map<String, dynamic> json) {
    return UserDiscoveryModel(
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }
}
