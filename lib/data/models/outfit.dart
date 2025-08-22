class Outfit {
  final String id;
  final String name;
  final List<String> itemIds;
  final String? occasion;
  final String? season;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;

  Outfit({
    required this.id,
    required this.name,
    required this.itemIds,
    this.occasion,
    this.season,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  factory Outfit.fromJson(Map<String, dynamic> json) {
    return Outfit(
      id: json['id'],
      name: json['name'],
      itemIds: List<String>.from(json['itemIds'] ?? []),
      occasion: json['occasion'],
      season: json['season'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'itemIds': itemIds,
      'occasion': occasion,
      'season': season,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  Outfit copyWith({
    String? id,
    String? name,
    List<String>? itemIds,
    String? occasion,
    String? season,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Outfit(
      id: id ?? this.id,
      name: name ?? this.name,
      itemIds: itemIds ?? this.itemIds,
      occasion: occasion ?? this.occasion,
      season: season ?? this.season,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
