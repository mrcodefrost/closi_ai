import 'dart:io';

class WardrobeItem {
  final String id;
  final String name;
  final String category;
  final String brand;
  final String color;
  final List<String> tags;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  WardrobeItem({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.color,
    required this.tags,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WardrobeItem.fromJson(Map<String, dynamic> json) {
    return WardrobeItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      color: json['color'],
      tags: List<String>.from(json['tags'] ?? []),
      imagePath: json['imagePath'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'brand': brand,
      'color': color,
      'tags': tags,
      'imagePath': imagePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  WardrobeItem copyWith({
    String? id,
    String? name,
    String? category,
    String? brand,
    String? color,
    List<String>? tags,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WardrobeItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      tags: tags ?? this.tags,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
