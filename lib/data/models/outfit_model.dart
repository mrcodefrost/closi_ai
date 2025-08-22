import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'outfit_model.g.dart';
part 'outfit_model.freezed.dart';

@freezed
@HiveType(typeId: 1)
class OutfitModel with _$OutfitModel {
  const factory OutfitModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<String> itemIds,
    @HiveField(3) String? occasion,
    @HiveField(4) String? season,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default(false) bool isFavorite,
    @HiveField(8) String? tryOnImageUrl, // Generated try-on image
    @HiveField(9) Map<String, dynamic>? aiMetadata, // AI recommendations
    @HiveField(10) List<String>? tags,
    @HiveField(11) String? weather,
    @HiveField(12) double? rating,
  }) = _OutfitModel;

  factory OutfitModel.fromJson(Map<String, dynamic> json) =>
      _$OutfitModelFromJson(json);
}
