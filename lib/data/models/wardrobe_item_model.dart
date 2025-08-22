import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wardrobe_item_model.g.dart';
part 'wardrobe_item_model.freezed.dart';

@freezed
@HiveType(typeId: 0)
class WardrobeItemModel with _$WardrobeItemModel {
  const factory WardrobeItemModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String category,
    @HiveField(3) String? brand,
    @HiveField(4) required List<String> colors,
    @HiveField(5) required List<String> tags, // 100-200 semantic tags from OpenAI
    @HiveField(6) required String imagePath, // Local path after background removal
    @HiveField(7) String? originalImagePath,
    @HiveField(8) String? cloudImageUrl, // Cloud storage URL
    @HiveField(9) required DateTime createdAt,
    @HiveField(10) DateTime? updatedAt,
    @HiveField(11) @Default(false) bool isFavorite,
    @HiveField(12) String? season,
    @HiveField(13) List<String>? occasions,
    @HiveField(14) String? size,
    @HiveField(15) double? price,
    @HiveField(16) Map<String, dynamic>? metadata,
  }) = _WardrobeItemModel;

  factory WardrobeItemModel.fromJson(Map<String, dynamic> json) =>
      _$WardrobeItemModelFromJson(json);
}
