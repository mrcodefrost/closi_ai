class UserProfile {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? gender;
  final String? height;
  final String? weight;
  final String? bodyType;
  final List<String> stylePreferences;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.gender,
    this.height,
    this.weight,
    this.bodyType,
    required this.stylePreferences,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      bodyType: json['bodyType'],
      stylePreferences: List<String>.from(json['stylePreferences'] ?? []),
      profileImageUrl: json['profileImageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'stylePreferences': stylePreferences,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserProfile copyWith({
    String? id,
    String? username,
    String? email,
    String? fullName,
    String? gender,
    String? height,
    String? weight,
    String? bodyType,
    List<String>? stylePreferences,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyType: bodyType ?? this.bodyType,
      stylePreferences: stylePreferences ?? this.stylePreferences,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
