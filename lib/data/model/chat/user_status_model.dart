class UserStatusModel {
  final bool isOnline;
  final DateTime? lastSeen;

  UserStatusModel({required this.isOnline, this.lastSeen});

  factory UserStatusModel.fromJson(Map<String, dynamic> json) {
    return UserStatusModel(
      isOnline: json['isOnline'] ?? false,
      lastSeen: json['lastSeen'] != null
          ? DateTime.parse(json['lastSeen']).toLocal()
          : null,
    );
  }
}